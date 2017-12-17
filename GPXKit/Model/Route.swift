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
    public var routeNumber: UInt?
    public var type : String?
    
    public var extensions = [Extension]()
    
    public var routePoints = [WayPoint]()
    
    public init() {
        
    }
    
    public init(withName name: String) {
        self.name = name
    }
    
    public init(withName name: String, andRouteNumber routeNumber: UInt) {
        self.name = name
        self.routeNumber = routeNumber
    }
}
