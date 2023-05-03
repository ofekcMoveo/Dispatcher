//
//  SearchScreenViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 02/05/2023.
//

import UIKit

class SearchScreenViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var babkButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let searchScreenViewModel = SearchScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customSearchBar()
       
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.register(UINib(nibName: AppConstants.previousSearchCellNibName, bundle: nil), forCellReuseIdentifier: AppConstants.previousSearchesCellIdentifier)
    }
    
    private func customSearchBar() {
        let searchTextField = searchBar.searchTextField
        searchBar.setImage(UIImage(named: "exit"), for: .clear, state: .normal)
        
        searchTextField.leftView = nil
        searchTextField.backgroundColor = .white

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == AppConstants.fromPreviousSearchToResults) {
            let searchResultsVC = segue.destination as? SearchResultsScreenViewController
            searchResultsVC?.searchKeyWords = searchBar.text ?? ""
        }
    }
}


extension SearchScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppConstants.LATEST_SEARCHES_AMOUNT
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: AppConstants.previousSearchesCellIdentifier, for: indexPath))
        
        return cell
            
    }
}

extension SearchScreenViewController: UITableViewDelegate, UISearchBarDelegate, PreviousSearchCellDelegate {
    func removeButtonPressed(_ searchToRemove: String) {
        //TODO: remove search from local db
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.placeholder = ""
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSegue(withIdentifier: AppConstants.fromPreviousSearchToResults, sender: self)
    
    }
}
