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
    
    init(text: String, checked:Bool){
        self.text = text
        self.checked = checked
    }

}
