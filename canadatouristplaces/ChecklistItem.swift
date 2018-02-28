//
//  ChecklistItem.swift
//  canadatouristplaces
//
//  Created by Student on 2018-02-13.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class ChecklistItem: NSObject, Codable {
    
    var text = ""
    var checked = false
    var iconName:String = ""
    var location = ""
    var slider:Float = 0.0
    var latitude:Double
    var longitude:Double
    
    init(text: String, checked:Bool, location: String, slider: Float, latitude: Double, longitude: Double){
        self.text = text
        self.checked = checked
        self.location = location
        self.slider = slider
        self.latitude = latitude
        self.longitude = longitude
    }

}
