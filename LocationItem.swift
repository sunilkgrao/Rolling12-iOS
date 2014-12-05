//
//  LocationItem.swift
//  Rolling12-iOS
//
//  Created by Sunil Rao on 2014-11-28.
//  Copyright (c) 2014 Baryon. All rights reserved.
//

import Foundation
import CoreData

class LocationItem: NSManagedObject {

    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var date: NSDate
    @NSManaged var uuid: NSString

}
