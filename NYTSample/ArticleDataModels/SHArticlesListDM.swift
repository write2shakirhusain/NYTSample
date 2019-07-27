//
//  SHArticlesListDM.swift
//  NYTSample
//
//  Created by Shakir Husain on 27/07/19.
//  Copyright © 2019 General. All rights reserved.
//

import UIKit

class SHArticlesListDM: NSObject, Codable {
    
    var status : String
    var copyright : String
    var num_results : Int64
    var results : [SHArticleDM]
    
    
    private enum CodingKeys: String, CodingKey {
        
        case status
        case copyright
        case num_results
        case results
        
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
        copyright = try container.decode(String.self, forKey: .copyright)
        num_results = try container.decode(Int64.self, forKey: .num_results)
        results = try container.decode(Array<SHArticleDM>.self, forKey: .results)
        
    }
    
    func encode(to encoder: Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
        try container.encode(copyright, forKey: .copyright)
        try container.encode(num_results, forKey: .num_results)
        try container.encode(results, forKey: .results)
        
    }
}

