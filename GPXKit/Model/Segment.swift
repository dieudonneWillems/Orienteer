//
//  TrackSegment.swift
//  GPXKit
//
//  Created by Don Willems on 13/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public struct Segment {
    
    public var name : String?
    
    // TODO: Add Extensions
    
    public var time : Date? {
        get {
            if trackPoints.count <= 0 {
                return nil
            } else {
                return trackPoints[0].time
            }
        }
    }

    public var trackPoints : [WayPoint] {
        get {
            return _trackPoints
        }
    }
    private var _trackPoints = [WayPoint]()
    
    public init() {
        self.name = nil
    }
    
    public init(withName name : String) {
        self.name = name
    }
    
    public init(withWayPoints wayPoints: [WayPoint]) {
        self.init()
        self.addTrackPoints(wayPoints)
    }
    
    public init(withName name: String, andWayPoints wayPoints: [WayPoint]) {
        self.init(withName:name)
        self.addTrackPoints(wayPoints)
    }
    
    public mutating func addTrackPoint(_ wayPoint : WayPoint) {
        _trackPoints.append(wayPoint)
        _trackPoints = _trackPoints.sorted(by: <)
    }
    
    public mutating func addTrackPoints(_ wayPoints : [WayPoint]) {
        _trackPoints.append(contentsOf: wayPoints)
        _trackPoints = _trackPoints.sorted(by: <)
    }
}


public extension Segment {
    
    public static func < (left: Segment, right: Segment) -> Bool {
        if left.time != nil && right.time == nil {
            return true
        }
        if left.time == nil {
            return false
        }
        return left.time! < right.time!
    }
    
    public static func > (left: Segment, right: Segment) -> Bool {
        if left.time == nil && right.time != nil {
            return true
        }
        if right.time == nil {
            return false
        }
        return left.time! > right.time!
    }
}
