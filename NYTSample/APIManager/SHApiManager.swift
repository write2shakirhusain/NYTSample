//
//  SHApiManager.swift
//  NYTSample
//
//  Created by Shakir Husain on 27/07/19.
//  Copyright © 2019 General. All rights reserved.
//

import UIKit


class SHConstants {
    static var baseUrl = "http://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=GjytgmOpe2Psg3PIJKTMenBfJ9VNlSqX"
}


 class SHApiManager: NSObject {
    //MARK: PROPERTIES
    typealias CallbackCompletion = ([SHArticleVM]?, Error?)-> Void
    var callBack:CallbackCompletion?
    var callbacksMediaDidUpload =  [(inError:Error, inSuccess:Bool)-> Void]()
    var session = URLSession.shared
    
    //MARK: METHODS
    func fetchArticlesList(inCallBack :  @escaping CallbackCompletion) -> Void {
        self.callBack = inCallBack
        guard let url = URL.init(string: SHConstants.baseUrl) else { return }
        
        var  request = URLRequest.init(url:url , cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        let task =  self.session.dataTask(with: request) { [weak self](data:Data?, urlResponse:URLResponse?, error:Error?) in
            
            if let err = error { // Checking Error
                self?.callBack?(nil, err)
                return
            }
            
            guard let responseData = data else {
                self?.callBack?(nil, error)
                print("Error: did not receive data") // Use Debug print
                return
            }
            // parse the result as JSON, since that's what the API provides
            do {
                guard let testingJSON = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                    print("error trying to convert data to JSON") // Use Debug print
                    return
                }
                // now we have the todo
                // let's just print it to prove we can access it
                print("Json Data found : " + testingJSON.description) // Use Debug print
                //use the JSONDecoder to decode the encoded data
                
                if let data1 = data{
                    do {
                        let userDataObject = try JSONDecoder().decode(SHArticlesListDM.self,from: data1)
                        print("Decoded Data: ", userDataObject.results )
                        
                        let listOfViewModel = userDataObject.results.map({ (inUserModel : SHArticleDM) -> SHArticleVM in
                            let viewModel =  SHArticleVM(inDataModel: inUserModel)
                            viewModel.starDownloading()

                            return viewModel
                        });
                        self?.callBack?(listOfViewModel, nil)
                    } catch {
                        print(error) // Use Debug print
                        self?.callBack?(nil, error)
                    }
                }
                
            } catch  {
                print("error trying to convert data to JSON") // Use Debug print
                return
            }
        }
        task.resume()
    }
}
