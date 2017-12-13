//
//  TrackPoint.swift
//  GPXKit
//
//  Created by Don Willems on 13/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public class TrackPoint: NSObject {

    public let longitude : Double
    public let latitude : Double
    public let elevation : Double?
    public let time : Date
    
    public init(withLongitude longitude: Double, andLatitude latitude : Double, atTime time : Date) {
        self.longitude = longitude
        self.latitude = latitude
        self.elevation = nil
        self.time = time
    }
    
    public init(withLongitude longitude: Double, latitude : Double, andElevation elevation : Double, atTime time : Date) {
        self.longitude = longitude
        self.latitude = latitude
        self.elevation = elevation
        self.time = time
    }
    
}

public extension TrackPoint {
    
    public static func == (left: TrackPoint, right: TrackPoint) -> Bool {
        return left.time == right.time && left.longitude == right.longitude && left.elevation == right.elevation && left.latitude == right.latitude
    }
    
    public static func != (left: TrackPoint, right: TrackPoint) -> Bool {
        return left.time != right.time || left.longitude != right.longitude || left.elevation != right.elevation || left.latitude != right.latitude
    }
    
    public static func < (left: TrackPoint, right: TrackPoint) -> Bool {
        return left.time < right.time
    }
    
    public static func > (left: TrackPoint, right: TrackPoint) -> Bool {
        return left.time > right.time
    }
}

