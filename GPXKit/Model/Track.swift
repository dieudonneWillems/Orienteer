//
//  Track.swift
//  GPXKit
//
//  Created by Don Willems on 13/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public class Track: NSObject {

    public var name : String?
    public var time : Date? {
        get {
            if segments.count <= 0 {
                return nil
            } else {
                return segments[0].time
            }
        }
    }
    public var creator : String?
    
    public var segments : [TrackSegment] {
        get {
            return _segments
        }
    }
    private var _segments = [TrackSegment]()
    
    public override init() {
        self.name = nil
        self.creator = nil
    }
    
    public init(withName name: String) {
        self.name = name
    }
    
    public convenience init(withSegment segment: TrackSegment){
        self.init()
        self.addSegment(segment)
    }
    
    public convenience init(withName name: String, andSegment segment: TrackSegment){
        self.init(withName: name)
        self.addSegment(segment)
    }
    
    public convenience init(withSegments segments: [TrackSegment]){
        self.init()
        self.addSegments(segments)
    }
    
    public convenience init(withName name: String, andSegments segments: [TrackSegment]){
        self.init(withName: name)
        self.addSegments(segments)
    }
    
    public convenience init(withTrackPoints trackPoints : [TrackPoint]){
        let segment = TrackSegment(withTrackPoints: trackPoints)
        self.init(withSegment: segment)
    }
    
    public convenience init(withName name: String, andTrackPoints trackPoints : [TrackPoint]){
        let segment = TrackSegment(withTrackPoints: trackPoints)
        self.init(withName: name, andSegment: segment)
    }
    
    public func addSegment(_ segment : TrackSegment){
        _segments.append(segment)
        _segments.sort(by: < )
    }
    
    public func addSegments(_ segments : [TrackSegment]) {
        _segments.append(contentsOf: segments)
        _segments.sort(by: < )
    }
}
