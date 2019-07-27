//
//  SHArticleDM.swift
//  NYTSample
//
//  Created by Shakir Husain on 26/07/19.
//  Copyright © 2019 General. All rights reserved.
//

import UIKit

//** Article Structure

struct SHArticleDM: Codable {
    
    var byline : String
    var type : String
    var title : String
    var abstract : String
    var published_date : String
    var media : [SHArticleMedia]
}


//** Article Media Structure
struct SHArticleMedia:Codable {
    
    var type : String
    var subtype : String
    var caption : String?
    var mediaMetadata : [SHArticleMediaMetadata]?

    
    private  enum CodingKeys: String, CodingKey {

        case type
        case subtype
        case caption
        case mediaMetadata = "media-metadata"

    }
}


//** Article Media Metadat Structure
struct SHArticleMediaMetadata:Codable {
    
    var url : String
    var format : String
    var width : Float
    var height : Float
}

