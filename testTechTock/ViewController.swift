//
//  ViewController.swift
//  testTechTock
//
//  Created by 神原良継 on 2019/10/16.
//  Copyright © 2019 jp.Antony. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    
    var tableView = UITableView()
    var articles: [String]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        view.addSubview(tableView)
        
        getArticles()
        
    }

    func getArticles() {
        Alamofire.request("URLofEndPoint")
            .responseJSON { response in
                print(response.result.value as Any)
                
                let json = JSON(object)
                json.forEach { (_,json) in
                    let article: String? = json["key"].string
                    self.articles.append(articles)
                }
                self.tableView.reloadData()
        }

    }
    
    

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = articles[indexPath.row]
        return cell
    }
    
    
}

