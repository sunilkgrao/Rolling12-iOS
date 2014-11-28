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
    
    var title:String
    var region:CLCircularRegion
    var media:MPMediaItem
    
    init( title:String, region:CLCircularRegion, media:MPMediaItem ) {
        self.title = title
        self.region = region
        self.media = media
        
    }
    
UIDevice.currentDevice().identifierForVendor.UUIDString
    
}
