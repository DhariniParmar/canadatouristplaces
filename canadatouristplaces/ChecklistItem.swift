//
//  ChecklistItem.swift
//  canadatouristplaces
//
//  Created by Student on 2018-02-13.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class ChecklistItem: NSObject {
    
    var text = ""
    var checked = false
    var iconName:String = ""
    var location = ""
    var slider:Float = 0.0
    
    init(text: String, checked:Bool, location: String, slider: Float){
        self.text = text
        self.checked = checked
        self.location = location
        self.slider = slider
    }

}
