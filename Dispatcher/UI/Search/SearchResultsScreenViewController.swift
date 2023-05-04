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
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultsTableView.delegate = self
        searchResultsTableView.dataSource = self
        searchResultsTableView.register(UINib(nibName: AppConstants.articleCellNibName, bundle: nil), forCellReuseIdentifier: AppConstants.articleCellIdentifier)
        
        noResultsView.isHidden = true
        searchKeyWordsLabel.text = (searchKeyWords)
        configureActivityIndicator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchArticlesBySearchKeywords()
        searchResultsTableView.reloadData()
    }
    
    private func configureActivityIndicator() {
            activityIndicator.style = .large
            activityIndicator.center = searchResultsView.center
        searchResultsView.addSubview(activityIndicator)
    }
    
    private func fetchArticlesBySearchKeywords() {
        self.activityIndicator.startAnimating()
        searchViewModel.getArticlesFromAPIBySearch(searchKeyWords, pageNumber: currentPage, completionHandler: { errorMsg in
            if(errorMsg != nil) {
                self.activityIndicator.stopAnimating()
                if(errorMsg == AppConstants.noArticlesFoundError) {
                    self.noResultsView.isHidden = false
                } else {
                    self.present(Utils.showErrorAlert(errorMsg!),animated: true, completion: nil)
                }
            } else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.searchViewModel.addNewSearch(self.searchKeyWords)
                    self.searchResultsTableView.reloadData()
                }
            }
        })
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}

extension SearchResultsScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchViewModel.articlesAmount()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentArticle = searchViewModel.currentArticle(index: indexPath.row)
        
        if let cell = (tableView.dequeueReusableCell(withIdentifier: AppConstants.articleCellIdentifier, for: indexPath) as? ArticleCell) {
            cell.id = currentArticle.id
            cell.autherLabel.text = currentArticle.author
            cell.titleLabel.text = currentArticle.title
            cell.subTitleLabel.text = currentArticle.summary
            cell.tagLabel.text = currentArticle.topic.first
            cell.dateLabel.text = Utils.formatDate(currentArticle.date)
            cell.articleImage.image = Utils.loadImageFromUrl(currentArticle.imageURL)
            
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (searchViewModel.articlesToDisplay.count - 1) {
            if (currentPage < searchViewModel.totalResultsPages) {
                currentPage += 1
                fetchArticlesBySearchKeywords()
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
