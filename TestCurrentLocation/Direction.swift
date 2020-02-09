//
//  Direction.swift
//  TestCurrentLocation
//
//  Created by nancy on 2020/02/02.
//  Copyright © 2020 nancy. All rights reserved.
//

import Foundation

struct Direction: Codable {
    let routes: [Route]
}

struct Route: Codable {
    let legs: [Leg]
}

struct Leg: Codable {
    let startLocation: LocationPoint
    let endLocation: LocationPoint
    let steps: [Step]
    
    enum CodingKeys: String, CodingKey {
        case startLocation = "start_location"
        case endLocation = "end_location"
        case steps
    }
}

struct Step: Codable {
    let startLocation: LocationPoint
    let endLocation: LocationPoint
    
    enum CodingKeys: String, CodingKey {
        case startLocation = "start_location"
        case endLocation = "end_location"
    }
}

struct LocationPoint: Codable {
    let lat: Double
    let lng: Double
}
