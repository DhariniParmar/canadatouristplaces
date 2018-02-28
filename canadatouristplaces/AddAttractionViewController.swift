//
//  AddAttractionViewController.swift
//  canadatouristplaces
//
//  Created by Student on 2018-02-13.
//  Copyright © 2018 Student. All rights reserved.
//

import UIKit
import CoreLocation

protocol AddAttractionVCDelegate: class {
    
    func addAttractionVCDidCancel()
    func addAttractionVC(_ control: AddAttractionViewController, didFinishAdd item: ChecklistItem)
    func addAttractionVC(_ control: AddAttractionViewController, didFinishEdit item: ChecklistItem)
}

class AddAttractionViewController: UITableViewController, IconPickerVCDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet weak var textfield: UITextField!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var showRate: UILabel!
    
    @IBOutlet weak var textFieldLongitude: UITextField!
    
    @IBOutlet weak var textFieldLatitude: UITextField!
    
    @IBOutlet weak var ratingSlider: UISlider!
    @IBOutlet var datePickerCell: UITableViewCell!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    @IBOutlet weak var datePickerSwitch: UISwitch!
    @IBOutlet weak var textfieldLocation: UITextField!
    weak var delegate: AddAttractionVCDelegate?
    
    @IBOutlet weak var iconImage: UIImageView!
    
    var itemtoEdit: ChecklistItem?
     var iconProvinceName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let item = itemtoEdit {
            textfield.text = item.text
            textfieldLocation.text = item.location
            ratingSlider.value = item.slider
            showRate.text = String(ratingSlider.value)
            textFieldLongitude.text = String(item.longitude)
            textFieldLatitude.text = String(item.latitude)
        
            self.title = "EditAttraction"
            iconProvinceName = item.iconName
            if let iconName = iconProvinceName {
                iconImage.image = UIImage(named: iconName)
            }
           
        } else {
            title = "AddAttraction"
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
    
    
    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        dueDateLabel.text = formatter.string(from: datePicker.date)
        
    }
    
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        
        tableView.reloadData()
    }
    
    
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        
        if let item = itemtoEdit {
            item.text = textfield.text!
            item.location = textfieldLocation.text!
            item.slider = ratingSlider.value
            showRate.text = String(ratingSlider.value)
            if let icon = iconProvinceName {
                item.iconName = icon
            }
           
            delegate?.addAttractionVC(self, didFinishEdit: item)
        } else {
            //extract the textfield content
            let text = textfield.text!
            let location = textfieldLocation.text!
            let sliderValue = ratingSlider.value
            let latitude = Double(textFieldLatitude.text!)
            let longitude = Double(textFieldLongitude.text!)
            //make a new checklistitem object
            let item = ChecklistItem(text: text, checked: false, location: location, slider: sliderValue, latitude: latitude!, longitude: longitude! )
            if let icon = iconProvinceName {
                item.iconName = icon
            }
            //send it back to the upper stream VC
            delegate?.addAttractionVC(self, didFinishAdd: item)
        }
        
    }
    

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.addAttractionVCDidCancel()
    }
    
    
    @IBAction func ForwardGeocodingToGPS(_ sender: Any) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString((textfieldLocation.text)!, completionHandler: {
            placemarks, error in
            print("Found the location: \(String(describing: placemarks))")
            if let placemark = placemarks?.last {
                if  let latitude = placemark.location?.coordinate.latitude,
                    let longitude = placemark.location?.coordinate.longitude {
                    self.textFieldLatitude.text = "\(String(describing: latitude))"
                    self.textFieldLongitude.text = "\(String(describing: longitude))"
                    let alert = UIAlertController(title: "Geocode Lookup Result GeoForwarding:", message:
                        
                        "The location Longitude: \(self.textFieldLongitude.text!) and The location Latitude: \(self.textFieldLatitude.text!)" , preferredStyle: .alert)
                    
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                    
                    alert.addAction(alertAction)
                    
                   self.present(alert, animated: true, completion: nil)
                }
            }
        })
        
    }
    
    
    
    @IBAction func ReverseGeocodingToAddress(_ sender: Any) {
        
        let geocoder = CLGeocoder();
        let location = CLLocation(latitude: Double(textFieldLatitude.text!)!,  longitude: Double(textFieldLongitude.text!)! )
        geocoder.reverseGeocodeLocation(location, completionHandler: {
            placemarks, error in
            print("Location Found: \(String(describing: placemarks))")
            if let placemark = placemarks?.last!{
                var address = ""
                if let streetFirst = placemark.subThoroughfare {
                    address = address + streetFirst + " "
                }
                if let streetTwo = placemark.thoroughfare {
                    address = address + streetTwo + " "
                }
                if let city = placemark.locality {
                    address = address + city + " "
                }
                if let prov = placemark.administrativeArea {
                    address = address + prov + " "
                }
                if let postcode = placemark.postalCode{
                    address = address + postcode + " "
                }
                self.textfieldLocation.text = address
                
                let alert = UIAlertController(title: "Geocode Lookup Result:", message:
                    
                    "The location Address: \(self.textfieldLocation.text!)" , preferredStyle: .alert)

                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)

                alert.addAction(alertAction)

                self.present(alert, animated: true, completion: nil)
                
            }
        })
    }
    
    
    
    
    
    // MARK: - Table view data source
/*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
*/
    func iconPicker(_ controller: IconPickerViewController, didPick iconName: String) {
        self.iconProvinceName = iconName
        //place the icon represented by the picked icon name in the image view
        iconImage.image = UIImage(named: iconName)
        //dismiss the iconpicker vc
        //dismiss(animated: true, completion: nil)???
        navigationController?.popViewController(animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        if indexPath.row == 5 {
            return datePickerCell
        }
        return super.tableView(tableView, cellForRowAt: indexPath)
    }
    
    // use table cell height to control the show and hide of date picker
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 5 {
            if datePickerSwitch.isOn {
                return 217
            } else {
                return 0
            }
        } else {
            return 44
        }
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
        
        let controller = segue.destination as! IconPickerViewController
        controller.delegate = self
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
