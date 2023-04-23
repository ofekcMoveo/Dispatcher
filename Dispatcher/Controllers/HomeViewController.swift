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
        
        cell.dateLabel.text = articlesToDisplay[indexPath.row].Date
        cell.autherLabel.text = articlesToDisplay[indexPath.row].auther
        cell.titleLabel.text = articlesToDisplay[indexPath.row].title
        cell.subTitleLabel.text = articlesToDisplay[indexPath.row].subTitle
        cell.tagLabel.text = articlesToDisplay[indexPath.row].tags.first
        cell.moreTagsLabel.text  = "+ \(articlesToDisplay[indexPath.row].tags.count - 1)"
        
        
        return cell
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
