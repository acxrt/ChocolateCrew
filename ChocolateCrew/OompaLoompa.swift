//
//  OompaLoompa.swift
//  ChocolateCrew
//
//  Created by Aina Cuxart on 24/4/17.
//  Copyright © 2017 Aina Cuxart. All rights reserved.
//

import Foundation
import SwiftyJSON

class OompaLoopma {
    
    var id: Int
    var first_name: String
    var last_name: String
    var email: String
    var gender: String
    var profession: String
    var thumbnail: String
    var image: String
    
    public init(){
        id = 0
        first_name = ""
        last_name = ""
        email = ""
        gender = ""
        profession = ""
        thumbnail = ""
        image = ""
    }
    
    public init(id: Int, first_name: String, last_name: String, email: String, gender: String, profession: String, thumbnail: String, image: String) {
    
        self.id = id
        self.first_name = first_name
        self.last_name = last_name
        self.email = email
        self.gender = gender
        self.profession = profession
        self.thumbnail = thumbnail
        self.image = image
        
    }
    
    public init?(json: JSON) {
        id = Int(json["id"].intValue)
        first_name = json["first_name"].stringValue
        last_name = json["last_name"].stringValue
        email = json["email"].stringValue
        gender = json["gender"].stringValue
        profession = json["profession"].stringValue
        thumbnail = json["thumbnail"].stringValue
        image = json["image"].stringValue
    }
    
}
