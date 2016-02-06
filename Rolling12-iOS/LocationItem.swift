//
//  LocationItem.swift
//  Rolling12-iOS
//
//  Created by Sunil Rao on 2014-12-06.
//  Copyright (c) 2014 Baryon. All rights reserved.
//

import Foundation
import CoreData

class LocationItem: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var latitude: NSNumber
    @NSManaged var longitude: NSNumber
    @NSManaged var uuid: String

}
