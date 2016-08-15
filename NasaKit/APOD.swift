//
//  APOD.swift
//  NearbyNasa
//
//  Created by Johann Kerr on 8/12/16.
//  Copyright © 2016 Johann Kerr. All rights reserved.
//

import Foundation
import SwiftyJSON


class APOD{
    var mediaType: String!
    var title: String!
    var url:String!
    var hdUrl: String!
    var date: String!
    var explanation: String!
    var copyright: String!
    
    
    init(dict: JSON){
        self.mediaType = dict["media_type"].string
        self.copyright = dict["copyright"].string
        self.date = dict["date"].string
        self.explanation = dict["explanation"].string
        self.hdUrl = dict["hdurl"].string
        self.title = dict["title"].string
        self.url = dict["url"].string
    }
}