//
//  mapViewController.swift
//  Rolling12
//
//  Created by Sunil Rao on 2014-11-28.
//  Copyright (c) 2014 Baryon. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    
    @IBAction func clearMap(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
