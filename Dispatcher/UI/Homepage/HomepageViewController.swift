//
//  HomeViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 17/04/2023.
//

import UIKit
import Alamofire

class HomepageViewController: UIViewController {

    @IBOutlet weak var articlesTableView: UITableView!
    @IBOutlet var homepageView: UIView!
    @IBOutlet weak var headerView: HeaderView!
    
    let homepageViewModel = HomepageViewModel.shared
    let activityIndicator = UIActivityIndicatorView()
    let tableFotterActivityIndicator = UIActivityIndicatorView()
    var isPagination = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        headerView.initView(headerType: .mainHeader)
        headerView.delegate = self

        setupTableView()
        configureActivityIndicator()
        getArticles()
    }
    
    private func setupTableView() {
        articlesTableView.dataSource = self
        articlesTableView.delegate = self
        articlesTableView.rowHeight = 450
        articlesTableView.register(UINib(nibName: NibNames.articleCellNibName, bundle: nil), forCellReuseIdentifier: TableCellsIdentifiers.articleCellIdentifier)
        
        setupFotterView()
    }
    
    private func setupFotterView() {
        tableFotterActivityIndicator.style = .large
        articlesTableView.tableFooterView = tableFotterActivityIndicator
        NSLayoutConstraint.activate([
            tableFotterActivityIndicator.centerXAnchor.constraint(equalTo: articlesTableView.tableFooterView?.centerXAnchor ?? NSLayoutXAxisAnchor()),
            tableFotterActivityIndicator.centerYAnchor.constraint(equalTo: articlesTableView.tableFooterView?.centerYAnchor ?? NSLayoutYAxisAnchor())
        ])
        
    }
    
    private func configureActivityIndicator() {
        activityIndicator.style = .large
        activityIndicator.center = homepageView.center
        homepageView.addSubview(activityIndicator)

    }
    
    private func getArticles() {
        isPagination == true ? (tableFotterActivityIndicator.startAnimating()) : self.activityIndicator.startAnimating()
    
        homepageViewModel.getArticlesToDisplay(completionHandler: { errorMsg, numberOfNewItems in
            self.isPagination == true ? (self.tableFotterActivityIndicator.stopAnimating()) : self.activityIndicator.stopAnimating()
            if(errorMsg != nil) {
                self.present(createErrorAlert(errorMsg!), animated: true, completion: nil)
            } else {
                DispatchQueue.main.async {
                    let indexPathForNewRows = self.buildIndexPathForNewRows(numberOfNewItems: numberOfNewItems)
                    self.articlesTableView.insertRows(at: indexPathForNewRows, with: .automatic)
                }
            }
        })
    }

    private func buildIndexPathForNewRows(numberOfNewItems: Int) -> [IndexPath] {
        let numberOfRows = self.articlesTableView.numberOfRows(inSection: 0)
        return (numberOfRows...(numberOfRows + numberOfNewItems - 1)).map { IndexPath(row: $0, section: 0) }
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (homepageViewModel.articlesToDisplay.count - 3) {
            if (homepageViewModel.currentPage < homepageViewModel.totalResultsPages) {
                isPagination = true
                getArticles()
                isPagination = false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor(named: ColorsPalleteNames.screenBackgroundColor)
       
        let label = UILabel()
        label.text = TextCostants.topHeadlinesHeaderText
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.frame = CGRect(x: 10, y: 10, width: 250, height: 40)
        
        view.addSubview(label)
        return view
      }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(AppConstants.tableRowHight)
    }
}

extension HomepageViewController: ArticleCellDelegate, UITableViewDelegate, HeaderViewDelegate {
    func notificationsPressed() {
    }
    
    func searchPressed() {
        self.performSegue(withIdentifier: SegueIdentifiers.fromHomepageToSearchScreen, sender: self)
    }
    
  
    func navigateButtonPressed(_ articleID: String) {
    }
    
    func favoritesButtonPressed(_ articleID: String) {
    }
}
