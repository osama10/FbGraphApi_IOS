//
//  Singelton.swift
//  FBGraphApiIos
//
//  Created by Admin on 8/21/17.
//  Copyright © 2017 Mujadidia Inc. All rights reserved.
//

import Foundation

struct Singleton {
    
    private static var singleton  : Singleton!
    public var accessToken : String!{
        
        get {
            
            return self.accessToken
            
        }
        
        set {
            
            accessToken = newValue
            
        }
    }
    
    private init(){
        
        
        
    }
    
    public static func getInstance()->Singleton{
        
        if(singleton == nil){
            
            singleton = Singleton()
        }
        
        return singleton
        
    }
    
    
    
}
