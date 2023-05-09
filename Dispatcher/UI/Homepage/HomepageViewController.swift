//
//  HomeViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 17/04/2023.
//

import UIKit
import Alamofire

class HomepageViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var notificationsButton: UIButton!
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet var homepageView: UIView!
    
    let homepageViewModel = HomepageViewModel.shared
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        setupTableView()
        configureActivityIndicator()
        getArticles()
    }
    
    private func setupTableView() {
        articlesTableView.dataSource = self
        articlesTableView.delegate = self
        articlesTableView.rowHeight = 450
        articlesTableView.register(UINib(nibName: NibNames.articleCellNibName, bundle: nil), forCellReuseIdentifier: TableCellsIdentifiers.articleCellIdentifier)
    }
    
    private func configureActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.center = homepageView.center
        homepageView.addSubview(activityIndicator)

    }
    
    private func getArticles() {
        self.activityIndicator.startAnimating()

        homepageViewModel.getArticlesToDisplay(completionHandler: { errorMsg in
            self.activityIndicator.stopAnimating()
            if(errorMsg != nil) {
                self.present(createErrorAlert(errorMsg!), animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    self.articlesTableView.reloadData()
                }
            }
        })
    }
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        
    }
    
    
    @IBAction func notificationsButtonPressed(_ sender: UIButton) {
        
        
    }
    
    @IBAction func unwindSegue( _ segue: UIStoryboardSegue) {
    }
    
}

extension HomepageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homepageViewModel.articlesAmount()
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentArticle = homepageViewModel.getArticleByIndex(index: indexPath.row)
        
        if let cell = (tableView.dequeueReusableCell(withIdentifier: TableCellsIdentifiers.articleCellIdentifier, for: indexPath) as? ArticleCell) {
            DispatchQueue.main.async {
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
            }
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (homepageViewModel.articlesToDisplay.count - 2) {
            if (homepageViewModel.currentPage < homepageViewModel.totalResultsPages) {
                getArticles()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(named: colorsPalleteNames.screenBackgroundColor)
       
        let label = UILabel()
        label.text = AppConstants.topHeadlinesHeaderText
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.frame = CGRect(x: 10, y: 10, width: 250, height: 28)
        
        view.addSubview(label)
            
        return view
      }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(AppConstants.tableRowHight)
    }
}

extension HomepageViewController: ArticleCellDelegate, UITableViewDelegate {
    func navigateButtonPressed(_ articleID: String) {
        print(articleID)
    }
    
    func favoritesButtonPressed(_ articleID: String) {
        print(articleID)
    }
}
