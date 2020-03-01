//
//  POIItem.swift
//  TestCurrentLocation
//
//  Created by nancy on 2020/03/01.
//  Copyright © 2020 nancy. All rights reserved.
//

import GoogleMapsUtils

class POIItem: NSObject, GMUClusterItem {

    var position: CLLocationCoordinate2D

    init(position: CLLocationCoordinate2D) {
        self.position = position
    }
}
