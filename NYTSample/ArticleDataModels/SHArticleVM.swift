//
//  SHArticleVM.swift
//  NYTSample
//
//  Created by Shakir Husain on 27/07/19.
//  Copyright © 2019 General. All rights reserved.
//

import UIKit

class SHArticleVM: NSObject {
    
    var  dataModel : SHArticleDM
    unowned var view : SHArticleCell?
   
    init(inDataModel : SHArticleDM) {
        self.dataModel = inDataModel
       
    }
    
    deinit {
        
    }
    
}

extension SHArticleVM {
    
    public func updateView() {
//        view?.imgThumbnail.image
        view?.lblTitle.text = dataModel.title
        view?.lblByline.text = dataModel.byline
        view?.lblPblshDate.text = dataModel.published_date
    }

    public func configure(_ inView: SHArticleCell) {
        view = inView
        updateView()
    }
}
