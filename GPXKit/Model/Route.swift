//
//  Route.swift
//  GPXKit
//
//  Created by Don Willems on 14/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public struct Route {

    public var name : String?
    public var comment : String?
    public var routeDescription: String?
    public var source : String?
    public var links = [Link]()
    public var routeNumber: Int?
    public var type : String?
    
    // TODO: Add Extensions
    
    public var routePoints : [WayPoint] {
        get {
            return _routePoints
        }
    }
    private var _routePoints = [WayPoint]()
    
    public init(withName name: String) {
        self.name = name
    }
    
    public init(withName name: String, andRouteNumber routeNumber: Int) {
        self.name = name
        self.routeNumber = routeNumber
    }
    
    public mutating func addRoutePoint(_ routePoint: WayPoint) {
        _routePoints.append(routePoint)
    }
    
    public mutating func addRoutePoints(_ routePoints: [WayPoint]) {
        _routePoints.append(contentsOf: routePoints)
    }
}
