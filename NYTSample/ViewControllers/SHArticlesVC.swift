//
//  ViewController.swift
//  NYTSample
//
//  Created by Shakir Husain on 27/07/19.
//  Copyright © 2019 General. All rights reserved.
//

import UIKit



class SHArticlesVC: UIViewController {

    var arrArticles = [SHArticleVM]()
    let apiManager = SHApiManager()
    

    @IBOutlet weak var tblView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
    }
    
    func fetchArticles() -> Void {
        apiManager.fetchArticlesList { [weak self](inArticles, Error)  in
            DispatchQueue.main.async {
                if let articles = inArticles {
                    self?.arrArticles.append(contentsOf: articles)
                    self?.tblView.reloadData()
                }
            }
        }
    }
    
}

//MARK:  TABLEVIEW DATASOURCE & DELEGATES
extension SHArticlesVC: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension;
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SHArticleCell.self), for: indexPath) as? SHArticleCell {
            let article = arrArticles[indexPath.row]
            article.configure(cell)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let article = arrArticles[indexPath.row]
        SHArticleDetailsVC.push(fromVC: self, inArticleVM: article)

    }
}

class SHArticleCell: UITableViewCell {
    
	@IBOutlet weak var imgThumbnail: UIImageView!
	@IBOutlet weak var lblTitle: UILabel!
	@IBOutlet weak var lblByline: UILabel!
	@IBOutlet weak var lblPblshDate: UILabel!
	override func awakeFromNib() {
		super.awakeFromNib()
		
	}
	
	
}

