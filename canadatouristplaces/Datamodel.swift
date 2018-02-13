//
//  Datamodel.swift
//  canadatouristplaces
//
//  Created by Student on 2018-02-13.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class Datamodel: NSObject {
    
    
    func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func dataFilePath() -> URL {
        print(documentDirectory())
        return documentDirectory().appendingPathComponent("Checklist.plist")
    }

}
