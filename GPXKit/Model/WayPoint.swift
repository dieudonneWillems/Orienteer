//
//  TrackPoint.swift
//  GPXKit
//
//  Created by Don Willems on 13/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public struct WayPoint {

    public var name : String?
    public var comment : String?
    public var wayPointDescription: String?
    public var source : String?
    public var links = [Link]()
    public var symbol : String?
    public var type : String?
    
    public let longitude : Double
    public let latitude : Double
    public var elevation : Double?
    public var time : Date
    
    public var magneticVariance : Double?
    public var geoidHeight: Double?
    public var fix : FixType?
    public var numberOfSatellites : Int?
    public var horizontalDilutionOfPrecision : Double?
    public var verticalDilutionOfPrecision : Double?
    public var positionDilutionOfPrecision : Double?
    public var numberOfSecondsSinceLastDGPSUpdate : Double?
    public var DGPSStationType : Int?
    
    // TODO: Add extensions
    
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
    
    public init(withName name: String, longitude: Double, andLatitude latitude : Double, atTime time : Date) {
        self.init(withLongitude: longitude, andLatitude: latitude, atTime: time)
        self.name = name
    }
    
    public init(withName name: String, longitude: Double, latitude : Double, andElevation elevation : Double, atTime time : Date) {
        self.init(withLongitude: longitude, latitude: latitude, andElevation: elevation, atTime: time)
        self.name = name
    }
    
}

public extension WayPoint {
    
    public static func == (left: WayPoint, right: WayPoint) -> Bool {
        return left.time == right.time && left.longitude == right.longitude && left.elevation == right.elevation && left.latitude == right.latitude
    }
    
    public static func != (left: WayPoint, right: WayPoint) -> Bool {
        return left.time != right.time || left.longitude != right.longitude || left.elevation != right.elevation || left.latitude != right.latitude
    }
    
    public static func < (left: WayPoint, right: WayPoint) -> Bool {
        return left.time < right.time
    }
    
    public static func > (left: WayPoint, right: WayPoint) -> Bool {
        return left.time > right.time
    }
}

