//
//  SHArticleVM.swift
//  NYTSample
//
//  Created by Shakir Husain on 27/07/19.
//  Copyright © 2019 General. All rights reserved.
//

import UIKit

enum enMediaUrlType {
    
    case eMediaUrlSmall
    case eMediaUrlMedium
    case eMediaUrlBig
    
}

class SHArticleVM: NSObject {
    
    var  dataModel : SHArticleDM
    var  smallImage : UIImage?
    var  bigImage : UIImage?

    unowned var view : SHArticleCell?
   
    init(inDataModel : SHArticleDM) {
        self.dataModel = inDataModel
    }
    
    deinit {
        
    }
    
    func starDownloading() -> Void {
        downloadSmallImage()
        downloadBigImage();
    }

    //MARK: Downloading small Image
    func downloadSmallImage() -> Void {
        
        var imageData:Data?

        DispatchQueue.global().async {
           
            if let url = self.getUrl(inMediaUrlType: .eMediaUrlSmall) {
                
                try?imageData = Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    //ui updation here
                    if let data = imageData{
                        self.smallImage = UIImage(data: data)
                        self.updateView()
                    }
                }
            }
        }
    }
    //MARK: Downloading big Image
    func downloadBigImage() -> Void {
        
        var imageData:Data?
        
        DispatchQueue.global().async {
            
            if let url = self.getUrl(inMediaUrlType: .eMediaUrlBig) {
                
                try?imageData = Data(contentsOf: url)
                
                DispatchQueue.main.async {
                    //ui updation here
                    if let data = imageData{
                        self.bigImage = UIImage(data: data)
                        self.updateView()
                    }
                }
                
            }
        }
    }
}

//MARK:Helper UI Methods in Extension
extension SHArticleVM {
    
    public func updateView() {

        view?.lblTitle.text = dataModel.title
        view?.lblByline.text = dataModel.byline
        view?.lblPblshDate.text = dataModel.published_date
       view?.imgThumbnail.image = self.smallImage
    }

    public func configure(_ inView: SHArticleCell) {
        view = inView
        updateView()
    }
}

//MARK:HHelper methods in Extension
extension SHArticleVM{
   
    func getUrl(inMediaUrlType:enMediaUrlType) -> URL? {
        
        var medaiUrl:URL?
        var medaiUrlStr:String?

        if (self.dataModel.media.count) > 0  {
            let articelMedia = self.dataModel.media[0]

            switch inMediaUrlType {
            
            case .eMediaUrlMedium:
               
                let articelMediaMedata = articelMedia.mediaMetadata![1]
                medaiUrlStr = articelMediaMedata.url

            case .eMediaUrlBig:
                
                let articelMediaMedata = articelMedia.mediaMetadata![2]
                medaiUrlStr = articelMediaMedata.url

                default:
                    let articelMediaMedata = articelMedia.mediaMetadata![0]
                    medaiUrlStr = articelMediaMedata.url
            }
            
            if let urlStr = medaiUrlStr{
                medaiUrl = URL(string: urlStr)
            }
            
        }
        return medaiUrl
    }
    
}
