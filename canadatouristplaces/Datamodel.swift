//
//  Datamodel.swift
//  canadatouristplaces
//
//  Created by Student on 2018-02-13.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class Datamodel: NSObject {
    
    var checklist: [ChecklistItem] = [ChecklistItem]()
    
    func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    func dataFilePath() -> URL {
        print(documentDirectory())
        return documentDirectory().appendingPathComponent("Checklist.plist")
    }
    func saveChecklist() {
        //get an encoder
        let encoder = PropertyListEncoder()
        //encode
        do {
            let data = try encoder.encode(checklist)
            //write the encoded data to the dataFilePath
            try data.write(to: dataFilePath())
        } catch {
            print("Encoding error")
        }
        
    }
    func loadChecklist() {
        //get a decoder tool
        let path = dataFilePath()
        //read from the device
        if let data = try? Data(contentsOf: path) {
            do {
                //decode the data into object
                let decoder = PropertyListDecoder()
                checklist = try decoder.decode([ChecklistItem].self, from: data)
            } catch {
                print("decoding error")
            }
        }
    }
    
    

}
