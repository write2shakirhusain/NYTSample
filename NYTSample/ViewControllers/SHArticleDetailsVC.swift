//
//  SHArticleDetailsVC.swift
//  NYTSample
//
//  Created by Shakir Husain on 27/07/19.
//  Copyright © 2019 General. All rights reserved.
//

import UIKit
import SDWebImage

class SHArticleDetailsVC: UIViewController {
	
	@IBOutlet weak var imgArticle: UIImageView!
	@IBOutlet weak var lblTitle: UILabel!

	@IBOutlet weak var txtVDescription: UITextView!
	
	@IBOutlet weak var lblByline: UILabel!
	@IBOutlet weak var lblPblshDate: UILabel!
    
    var articleVM: SHArticleVM?

    class func push(fromVC:SHArticlesVC , inArticleVM : SHArticleVM) -> Void {
       
        if let detailsVC = UIStoryboard(name: "Main" , bundle: nil).instantiateViewController(withIdentifier: String(describing: SHArticleDetailsVC.self)) as? SHArticleDetailsVC {
            detailsVC.articleVM = inArticleVM
            fromVC.navigationController?.pushViewController(detailsVC, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() -> Void {
        
        if let url = URL(string: "") {
            imgArticle.sd_setImage(with: url) { (image, error, cache, url) in
                
            }
        }
        lblTitle.text = articleVM?.dataModel.title
        lblByline.text = articleVM?.dataModel.byline
        txtVDescription.text = articleVM?.dataModel.abstract
        lblPblshDate.text = articleVM?.dataModel.published_date
        
    }
}
