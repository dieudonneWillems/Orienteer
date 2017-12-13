//
//  TrackSegment.swift
//  GPXKit
//
//  Created by Don Willems on 13/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public class TrackSegment: NSObject {
    
    public var name : String?
    public var time : Date? {
        get {
            if trackPoints.count <= 0 {
                return nil
            } else {
                return trackPoints[0].time
            }
        }
    }

    public var trackPoints : [TrackPoint] {
        get {
            return _trackPoints
        }
    }
    private var _trackPoints = [TrackPoint]()
    
    public override init() {
        self.name = nil
    }
    
    public init(withName name : String) {
        self.name = name
    }
    
    public convenience init(withTrackPoints trackPoints: [TrackPoint]) {
        self.init()
        self.addTrackPoints(trackPoints)
    }
    
    public convenience init(withName name: String, andTrackPoints trackPoints: [TrackPoint]) {
        self.init(withName:name)
        self.addTrackPoints(trackPoints)
    }
    
    public func addTrackPoint(_ trackPoint : TrackPoint) {
        _trackPoints.append(trackPoint)
        _trackPoints.sort(by: < )
    }
    
    public func addTrackPoints(_ trackPoints : [TrackPoint]) {
        _trackPoints.append(contentsOf: trackPoints)
        _trackPoints.sort(by: < )
    }
}


public extension TrackSegment {
    
    public static func < (left: TrackSegment, right: TrackSegment) -> Bool {
        if left.time != nil && right.time == nil {
            return true
        }
        if left.time == nil {
            return false
        }
        return left.time! < right.time!
    }
    
    public static func > (left: TrackSegment, right: TrackSegment) -> Bool {
        if left.time == nil && right.time != nil {
            return true
        }
        if right.time == nil {
            return false
        }
        return left.time! > right.time!
    }
}
