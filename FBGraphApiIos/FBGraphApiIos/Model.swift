//
//  User.swift
//  FBGraphApiIos
//
//  Created by Admin on 8/21/17.
//  Copyright © 2017 Mujadidia Inc. All rights reserved.
//

import Foundation
import ObjectMapper

struct User : Mappable  {
    
    var firstName : String?
    var id : String?
    var lastName : String?
    var name : String?
    var picture : [String : Any]?
    
    init?(map: Map)  {
        
      
        
    }
    
    mutating func mapping(map: Map) {
        
        firstName  <- map["first_name"]
        id  <- map["id"]
        lastName <- map["last_name"]
        name <- map["name"]
        picture <- map["picture"] 
    }
    
}

