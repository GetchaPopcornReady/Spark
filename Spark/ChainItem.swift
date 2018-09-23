//
//  chainItem.swift
//  Spark
//
//  Created by Joshua Vetter on 9/22/18.
//  Copyright © 2018 Joshua Vetter. All rights reserved.
//
import UIKit

class ChainItem: NSObject{
    
    var status: String?
    var timeleft: String?
    

    
    init(dictionary: [String:Any]){
        super.init()
        status = dictionary["status"] as? String
        timeleft = dictionary["timeleft"] as? String
        
    }
    
}
