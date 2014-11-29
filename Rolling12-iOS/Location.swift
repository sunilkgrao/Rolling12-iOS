//
//  Location.swift
//  Rolling12-iOS
//
//  Created by Sunil Rao on 2014-11-28.
//  Copyright (c) 2014 Baryon. All rights reserved.
//

import UIKit
import CoreLocation
import MediaPlayer

class Location: NSObject {
    
    var latitude:Double
    var longitude:Double
    var uuid:Double
    var time:datum
    

    init( latitude:Double, longitude:Double, uuid:Double, time:datum ) {
        self.latitude = latitude
        self.longitude = longitude
        self.uuid = uuid
        self.time = time
        
    }
    
    //NSTimer.scheduledTimerWithTimeInterval(60 * 30, target: self, selector: Selector("handleTimer:"), userInfo: nil, repeats: true)
    //func handleTimer(timer: NSTimer) {
        // start location services, here
        
        // Remember, have `didUpdateLocations` stop location services
        // when good location received
    //}
    
}
