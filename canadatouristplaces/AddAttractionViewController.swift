//
//  AddAttractionViewController.swift
//  canadatouristplaces
//
//  Created by Student on 2018-02-13.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

protocol AddAttractionVCDelegate: class {
    
    func addAttractionVCDidCancel()
    func addAttractionVC(_ control: AddAttractionViewController, didFinishAdd item: ChecklistItem)
    func addAttractionVC(_ control: AddAttractionViewController, didFinishEdit item: ChecklistItem)
}

class AddAttractionViewController: UITableViewController, IconPickerVCDelegate {
    
    
    @IBOutlet weak var textfield: UITextField!
    weak var delegate: AddAttractionVCDelegate?
    
    @IBOutlet weak var iconImage: UIImageView!
    
    var itemtoEdit: ChecklistItem?
     var iconName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemtoEdit {
            textfield.text = item.text
            self.title = "EditItem"
            iconName = item.iconName
            if let iconName = iconName {
                iconImage.image = UIImage(named: iconName)
            }
           
        } else {
            title = "AddItem"
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        
        if let item = itemtoEdit {
            item.text = textfield.text!
            if let icon = iconName {
                item.iconName = icon
            }
           
            delegate?.addAttractionVC(self, didFinishEdit: item)
        } else {
            //extract the textfield content
            let text = textfield.text!
            //make a new checklistitem object
            let item = ChecklistItem(text: text, checked: false)
            if let icon = iconName {
                item.iconName = icon
            }
            //send it back to the upper stream VC
            delegate?.addAttractionVC(self, didFinishAdd: item)
        }
        
    }
    

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.addAttractionVCDidCancel()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    func iconPicker(_ controller: IconPickerViewController, didPick iconName: String) {
        self.iconName = iconName
        //place the icon represented by the picked icon name in the image view
        iconImage.image = UIImage(named: iconName)
        //dismiss the iconpicker vc
        //dismiss(animated: true, completion: nil)???
        navigationController?.popViewController(animated: true)
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let controller = segue.destination as! IconPickerViewController
        controller.delegate = self
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
