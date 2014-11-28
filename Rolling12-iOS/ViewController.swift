//
//  ViewController.swift
//  Rolling12
//
//  Created by Sunil Rao on 2014-11-27.
//  Copyright (c) 2014 Baryon. All rights reserved.
//

import UIKit
import MapKit

//Add UITableViewDataSource to class declaration
class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var locationTableView: UITableView!
    
    //Insert below the tableView IBOutlet
    var locations = [String]()
    
    @IBAction func addLocation(sender: AnyObject) {
        
        var alert = UIAlertController(title: "New Location",
            message: "Add a new location",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default) { (action: UIAlertAction!) -> Void in
                
                let textField = alert.textFields![0] as UITextField
                self.locations.append(textField.text)
                self.locationTableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        locationTableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
    }

    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return locations.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
                as UITableViewCell
            
            cell.textLabel.text = locations[indexPath.row]
            
            return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

