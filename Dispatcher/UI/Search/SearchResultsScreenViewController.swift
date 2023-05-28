//
//  SearchResultsScreenViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 03/05/2023.
//

import UIKit

class SearchResultsScreenViewController: UIViewController {
    
    @IBOutlet weak var searchKeyWordsLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var searchResultsView: UIView!
    @IBOutlet weak var searchResultsTableView: UITableView!
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    
    
    var searchViewModel = SearchViewModel()
    let activityIndicator = UIActivityIndicatorView()
    var searchKeyWords: String = ""
    var gotResults = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        noResultsView.isHidden = true
        searchKeyWordsLabel.text = (searchKeyWords)
        configureActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getArticlesBySearchKeywords()
        searchResultsTableView.reloadData()
    }
    
    private func setupTableView() {
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.rowHeight = 450
        searchResultsTableView.register(UINib(nibName: NibNames.articleCellNibName, bundle: nil), forCellReuseIdentifier: TableCellsIdentifiers.articleCellIdentifier)
    }
    
    private func configureActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.center = searchResultsView.center
        searchResultsView.addSubview(activityIndicator)
    }
    
    private func getArticlesBySearchKeywords() {
        self.activityIndicator.startAnimating()
        
        searchViewModel.getArticlesFromAPIBySearch(searchKeyWords: searchKeyWords, completionHandler: { errorMsg, numberOfNewItems in
            self.activityIndicator.stopAnimating()
            if(errorMsg != nil) {
                if(errorMsg == Errors.noArticlesFoundError.rawValue) {
                    self.noResultsView.isHidden = false
                } else {
                    self.present(createErrorAlert(errorMsg!),animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    do {
                       try self.searchViewModel.addNewSearch(self.searchKeyWords)
                    } catch (let error) {
                       self.present(createErrorAlert(error.localizedDescription), animated: true, completion: nil)
                    }
                    let indexPathForNewRows = self.buildIndexPathForNewRows(numberOfNewItems: numberOfNewItems)
                    self.searchResultsTableView.insertRows(at: indexPathForNewRows, with: .automatic)
                }
            }
        })
    }
    
    func buildIndexPathForNewRows(numberOfNewItems: Int) -> [IndexPath] {
        let numberOfRows = self.searchResultsTableView.numberOfRows(inSection: 0)
        return (numberOfRows...(numberOfRows + numberOfNewItems - 1)).map { IndexPath(row: $0, section: 0) }
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
       performSegue(withIdentifier: SegueIdentifiers.fromSearchResultsToHomepage, sender: self)
    }
    
}

extension SearchResultsScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.articlesAmount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentArticle = searchViewModel.getArticleByIndex(index: indexPath.row)
        
        if let cell = (tableView.dequeueReusableCell(withIdentifier: TableCellsIdentifiers.articleCellIdentifier, for: indexPath) as? ArticleCell) {
            cell.id = currentArticle.id
            cell.autherLabel.text = currentArticle.author
            cell.titleLabel.text = currentArticle.title
            cell.subTitleLabel.text = currentArticle.summary
            cell.tagLabel.text = currentArticle.topic.first
            cell.dateLabel.text = formatDate(currentArticle.date)
            cell.articleImage.image = loadImageFromUrl(currentArticle.imageURL)
            
            let numberOfTags = currentArticle.topic.count - 1
            if(numberOfTags > 0) {
                cell.moreTagsLabel.text = "+ \(numberOfTags)"
            } else {
                cell.moreTagsLabel.text = cell.tagLabel.text
                cell.tagLabel.isHidden = true
            }
            
            cell.delegate = self
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(AppConstants.tableRowHight)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (searchViewModel.articlesToDisplay.count - 3) {
            if (searchViewModel.currentPage < searchViewModel.totalResultsPages) {
                getArticlesBySearchKeywords()
            }
        } 
    }
}

extension SearchResultsScreenViewController: UITableViewDelegate,  ArticleCellDelegate {
    func navigateButtonPressed(_ articleID: String) {
        
    }
    
    func favoritesButtonPressed(_ articleID: String) {
        
    }
    
}
