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
        
        
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        
        myLocations.append(locations[0] as CLLocation)
        var sourceIndex = myLocations.count - 1
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

        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity =  NSEntityDescription.entityForName("LocationItem", inManagedObjectContext:managedContext)
        let location = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        let c1 = myLocation.coordinate
        let c2 = myLocation.timestamp
        location.setValue(c1.latitude, forKey: "latitude")
        location.setValue(c1.longitude, forKey: "longitude")
        location.setValue(c2, forKey: "date")
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
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
            
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
                as UITableViewCell
            
            let c1 = myLocations[indexPath.row].coordinate
            let c2 = myLocations[indexPath.row].timestamp
            cell.textLabel.text = "Latitude: " + String(format:"%f",c1.latitude) + " Longitude: " + String(format:"%f",c1.longitude)
            return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"LocationItem")
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        if let results = fetchedResults {
            locations = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        var index = 0
        var myLocation: CLLocation
        
        while index < locations.count {
            
            let lat = locations[index].valueForKey("latitude") as Double
            let long = locations[index].valueForKey("longitude") as Double
            var mypos: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat,long)
            
            var myLocation: CLLocation = CLLocation(latitude: mypos.latitude,longitude: mypos.longitude)
            myLocations.append(myLocation)
            index += 1
        }
        
    }

}

