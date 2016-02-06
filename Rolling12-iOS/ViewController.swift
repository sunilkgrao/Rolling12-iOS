//
//  ViewController.swift
//  Rolling12
//
//  Created by Sunil Rao on 2014-11-27.
//  Copyright (c) 2014 Baryon. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import CoreData
import Alamofire

//Add UITableViewDataSource to class declaration
class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var locationTableView: UITableView!
    
    var locations = [NSManagedObject]()
    var myLocations: [CLLocation] = []
    var manager:CLLocationManager!

    
    @IBAction func addLocation(sender: AnyObject) {
        
        manager.startUpdatingLocation()
    }
    
    @IBAction func updateServer(sender: AnyObject) {
        
        
        // Push all data on local store to helios server
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"LocationItem")
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        if let results = fetchedResults {
            locations = results
        } else {
            print("Could not fetch \(error), \(error!.userInfo)")
        }
        
        var index = 0
        while index < locations.count {
            
            let lat = locations[index].valueForKey("latitude") as! Double
            let long = locations[index].valueForKey("longitude") as! Double

            var date = locations[index].valueForKey("date")  as! NSDate
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            //var dateString = NSString(format: "", date.timeIntervalSince1970, dateFormatter.stringFromDate(date))
            let dateString = dateFormatter.stringFromDate(date) as NSString
            
            let parameters = [
                "latitude"  : lat,
                "longitude" : long,
                "date"      : dateString,
                "uuid"      : locations[index].valueForKey("uuid") as NSString
            ]

            Alamofire.request(.POST, "http://rolling12-server.herokuapp.com/locationitems", parameters: parameters, encoding: .JSON)
            //responseJSON { (_,_, JSON, _) in
            //    if let jsonResult = JSON as? Array<Dictionary<String,String>> {
            //        println(jsonResult)
            //    }
            //}
            index += 1
        }
        
        // Flush local data store
        index = 0
        while index < locations.count {
            managedContext.deleteObject(locations[index] as NSManagedObject)
            index += 1
        }
        // save your changes
        managedContext.save(nil)
        myLocations.removeAll()
        self.locationTableView.reloadData()
        
    }
    

    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[CLLocation]) {
        
        myLocations.append(locations[0] as CLLocation)
        let sourceIndex = myLocations.count - 1
        saveLocation(myLocations[sourceIndex])
        self.locationTableView.reloadData()
        manager.stopUpdatingLocation()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recorded Locations"
        locationTableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
        //Setup our Location Manager
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startMonitoringSignificantLocationChanges()
        
    }

    
    
    func saveLocation(myLocation: CLLocation) {

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity =  NSEntityDescription.entityForName("LocationItem", inManagedObjectContext:managedContext)
        let location = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        let c1 = myLocation.coordinate
        let c2 = myLocation.timestamp
        location.setValue(c1.latitude, forKey: "latitude")
        location.setValue(c1.longitude, forKey: "longitude")
        location.setValue(c2, forKey: "date")
        let uuid = UIDevice.currentDevice().identifierForVendor.UUIDString as NSString
        location.setValue(uuid, forKey: "uuid")
        
        var error: NSError?
        if !managedContext.save(&error) {
            print("Could not save \(error), \(error?.userInfo)")
        }
        locations.append(location)
    }
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return myLocations.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
            
            let c1 = myLocations[indexPath.row].coordinate
            let c2 = myLocations[indexPath.row].timestamp
            cell.textLabel?.text = "Latitude: " + String(format:"%f",c1.latitude) + " Longitude: " + String(format:"%f",c1.longitude)
            return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"LocationItem")
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        if let results = fetchedResults {
            locations = results
        } else {
            print("Could not fetch \(error), \(error!.userInfo)")
        }
        
        var index = 0
        var myLocation: CLLocation
        
        while index < locations.count {
            
            let lat = locations[index].valueForKey("latitude") as! Double
            let long = locations[index].valueForKey("longitude") as! Double
            var mypos: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat,long)
            
            var myLocation: CLLocation = CLLocation(latitude: mypos.latitude,longitude: mypos.longitude)
            myLocations.append(myLocation)
            index += 1
        }
        
    }

}

