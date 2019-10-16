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
import SafariServices


class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var articles: [[String]] = []
    var selectUrl:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "記事一覧"
        
        tableView.dataSource = self
        
        
        getArticles()
    
        
    }

    func getArticles() {
        Alamofire.request("https://qiita.com/api/v2/items")
            .responseJSON { response in
                //print(response.result.value as Any)
                guard let object = response.result.value else {
                    return
                }
                
                
                let json = JSON(object)
                
                json.forEach { (_,json) in
                    let article: [String] = [json["title"].string!, json["url"].string!]
                    self.articles.append(article)
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
        cell.textLabel?.text = articles[indexPath.row][0]
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        //print("\(indexPath.row)th cell is celected")
        
        //tableView.deselectRow(at: indexPath, animated: true)
        selectUrl = articles[indexPath.row][1]
        guard let url = URL(string: selectUrl) else { return }
            let safariController = SFSafariViewController(url: url)
            present(safariController, animated: true, completion: nil)

    }
        
}
    


