//
//  GPSData.swift
//  GPXKit
//
//  Created by Don Willems on 14/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public struct GPSData {
    
    public var creator : String?
    public var time : Date?
    public var metadata : Metadata?
    
    private var _tracks = [Track]()
    private var _routes = [Route]()
    private var _wayPoints = [WayPoint]()
    
    // TODO: Add Extensions
    
    public init() {
        self.time = nil
        self.creator = nil
    }
    
    public init(withTime time : Date) {
        self.init()
        self.time = time
        self.creator = nil
    }

}
