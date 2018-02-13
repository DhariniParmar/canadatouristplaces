//
//  TouristPlaceViewController.swift
//  canadatouristplaces
//
//  Created by Student on 2018-02-13.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit

class TouristPlaceViewController: UITableViewController, AddAttractionVCDelegate {
    
    

    var checklist: [ChecklistItem] = [ChecklistItem]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        
        let item = ChecklistItem(text: "Canada Place", checked: false);
        let newRow = checklist.count;
        checklist.append(item)
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return checklist.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell.
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = checklist[indexPath.row].text
        let checkmarklabel = cell.viewWithTag(1001) as! UILabel
        checkmarklabel.text = "√"
       let iconName = checklist[indexPath.row].iconName
      let imageView = cell.viewWithTag(1002) as! UIImageView
        imageView.image = UIImage(named:iconName)

        return cell
    }
    

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
        
        if (segue.identifier == "AddItem") {
            let controller = segue.destination as! AddAttractionViewController
            controller.delegate = self
        } else if (segue.identifier == "EditItem") {
            let controller = segue.destination as! AddAttractionViewController
            controller.delegate = self
            //identify which cell was touched on
            let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
            //extract the data / text
            let item = checklist[indexPath!.row]
            //send the data to AddAttractionVC
            controller.itemtoEdit = item
        }
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func addAttractionVCDidCancel() {
        
        navigationController?.popViewController(animated: true)
    }
    
    func addAttractionVC(_ control: AddAttractionViewController, didFinishAdd item: ChecklistItem) {
        
        let newRow = checklist.count;
        checklist.append(item)
        //saveChecklist()
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        navigationController?.popViewController(animated: true)
        
    }
    
    func addAttractionVC(_ control: AddAttractionViewController, didFinishEdit item: ChecklistItem) {
        if let index = checklist.index(of: item) {
            checklist[index].text = item.text
            //datamodel.saveChecklist()
            let indexPath = IndexPath(row: index, section: 0)
            //update the table view
            if let cell = tableView.cellForRow(at: indexPath) {
                let label = cell.viewWithTag(1000) as! UILabel
                label.text = item.text
              //  let iconName = datamodel.checklist[indexPath.row].iconName
                //let imageView = cell.viewWithTag(1002) as! UIImageView
                //imageView.image = UIImage(named:iconName)
            }
        }
        //dismiss the itemDetailsVC
        navigationController?.popViewController(animated: true)
        
    }
    

}
