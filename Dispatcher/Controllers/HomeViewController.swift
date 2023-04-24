//
//  HomeViewController.swift
//  Dispatcher
//
//  Created by Ofek Cohen on 17/04/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var notificationsButton: UIButton!
    @IBOutlet weak var articlesTableView: UITableView!
    
    let articlesToDisplay = Articles().articales
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        articlesTableView.rowHeight = 450
        articlesTableView.dataSource = self
        articlesTableView.delegate = self
        
        articlesTableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: ArticleCell.articleCellIdentifier)
        
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func notificationsButtonPressed(_ sender: UIButton) {
        
        
    }
    
    
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesToDisplay.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.articleCellIdentifier, for: indexPath) as! ArticleCell
        let currentArticle = articlesToDisplay[indexPath.row]
        
        cell.dateLabel.text = currentArticle.date
        cell.autherLabel.text = currentArticle.auther
        cell.titleLabel.text = currentArticle.title
        cell.subTitleLabel.text = currentArticle.subTitle
        cell.tagLabel.text = currentArticle.tags.first
        
        let numberOfTags = currentArticle.tags.count - 1
        if(numberOfTags > 0) {
            cell.moreTagsLabel.text = "+ \(numberOfTags)"
        } else {
            cell.moreTagsLabel.text = cell.tagLabel.text
            cell.tagLabel.isHidden = true
        }
        
        cell.delegate = self
        return cell
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
    func navigateButtonPressed(_ articleTitle: String) {
        print(articleTitle)
    }
    
    func favoritesButtonPressed(_ articleTitle: String) {
        print(articleTitle)
    }
}
