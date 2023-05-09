//
//  SearchScreenViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 02/05/2023.
//

import UIKit

class SearchScreenViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var clearAllRecentSearchesButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchScreenViewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleSearchBar()
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(UINib(nibName: NibNames.latestSearchCellNibName, bundle: nil), forCellReuseIdentifier: TableCellsIdentifiers.latestSearchesCellIdentifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        do {
            try searchScreenViewModel.fetchLatestSearchs()
            searchTableView.reloadData()
        } catch (let error) {
            self.present(createErrorAlert(error.localizedDescription), animated: true, completion: nil)
        }
    }
    
    private func styleSearchBar() {
        let searchTextField = searchBar.searchTextField
        searchTextField.leftView = nil
        searchTextField.backgroundColor = .white
        
        searchBar.setImage(UIImage(named: "exit"), for: .clear, state: .normal)
    }
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func clearAllRecentSearchesButtonPressed(_ sender: UIButton) {
        searchScreenViewModel.removeAllSearches()
        searchTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == SegueIdentifiers.fromLatestSearchToResults) {
            let searchResultsVC = segue.destination as? SearchResultsScreenViewController
            searchResultsVC?.searchKeyWords = searchBar.text ?? ""
            searchResultsVC?.searchViewModel = searchScreenViewModel
        }
    }
}


extension SearchScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchScreenViewModel.latestSearches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentSearchIndex = (searchScreenViewModel.latestSearches.count - indexPath.row) - 1
        let search = searchScreenViewModel.latestSearches[currentSearchIndex]
        
        if let cell = (tableView.dequeueReusableCell(withIdentifier: TableCellsIdentifiers.latestSearchesCellIdentifier, for: indexPath) as? LatestSearchCell) {
            
            cell.searchWordsLabel.text = search
            cell.selectionStyle = .none
            
            cell.delegate = self
            return cell
    }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedCell = tableView.cellForRow(at: indexPath) as? LatestSearchCell {
            searchBar.text = selectedCell.searchWordsLabel.text
            performSegue(withIdentifier: SegueIdentifiers.fromLatestSearchToResults, sender: self)
        }
    }
}

extension SearchScreenViewController: UITableViewDelegate, UISearchBarDelegate, LatestSearchCellDelegate {
    func searchCellSelected(_ search: String) {
        searchBar.text = search
        performSegue(withIdentifier: SegueIdentifiers.fromLatestSearchToResults, sender: self)
    }
    
    func removeButtonPressed(_ searchToRemove: String) {
        searchScreenViewModel.removeSearch(searchToRemove)
        searchTableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.placeholder = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.performSegue(withIdentifier: SegueIdentifiers.fromLatestSearchToResults, sender: self)
    }
}
