//
//  HomeViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 17/04/2023.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var notificationsButton: UIButton!
    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet var homepageView: UIView!
    
    let homepageViewModel = HomepageViewModel()
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        articlesTableView.rowHeight = 450
        articlesTableView.dataSource = self
        articlesTableView.delegate = self
        
        articlesTableView.register(UINib(nibName: AppConstants.articleCellNibName, bundle: nil), forCellReuseIdentifier: AppConstants.articleCellIdentifier)
        configureActivityIndicator()
        fetchArticles()
    }
    
    private func showErrorAlert(_ msg: String) {
        
        let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    private func configureActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.center = homepageView.center
        homepageView.addSubview(activityIndicator)
    }
    
    private func fetchArticles() {
        self.activityIndicator.startAnimating()
        homepageViewModel.getArticlesFromAPI(completionHandler: { errorMsg in
            if(errorMsg != nil) {
                self.showErrorAlert((errorMsg!))
                self.activityIndicator.stopAnimating()
            } else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.articlesTableView.reloadData()
                }
            }
        })
    }
    
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func notificationsButtonPressed(_ sender: UIButton) {
        
        
    }
    
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homepageViewModel.articlesAmount()
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentArticle = homepageViewModel.currentArticle(index: indexPath.row)
        
        if let cell = (tableView.dequeueReusableCell(withIdentifier: AppConstants.articleCellIdentifier, for: indexPath) as? ArticleCell) {
            cell.id = currentArticle.id
            cell.autherLabel.text = currentArticle.author
            cell.titleLabel.text = currentArticle.title
            cell.subTitleLabel.text = currentArticle.summary
            cell.tagLabel.text = currentArticle.topic.first
            cell.dateLabel.text = Utils.formatDate(currentArticle.date)

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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(named: "screenBackgroundColor")
       
        let label = UILabel()
        label.text = "Top Headlines in Israel"
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 19, weight: .bold)
        label.frame = CGRect(x: 10, y: 10, width: 250, height: 28)
        
        view.addSubview(label)
            
        return view
      }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}

extension HomeViewController: ArticleCellDelegate, UITableViewDelegate {
    func navigateButtonPressed(_ articleID: String) {
        print(articleID)
    }
    
    func favoritesButtonPressed(_ articleID: String) {
        print(articleID)
    }
}