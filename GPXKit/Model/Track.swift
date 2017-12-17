//
//  Track.swift
//  GPXKit
//
//  Created by Don Willems on 13/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public struct Track {

    public var name : String?
    public var comment : String?
    public var trackDescription: String?
    public var source : String?
    public var links = [Link]()
    public var trackNumber: UInt?
    public var type : String?
    
    public var extensions = [GPXExtension]()
    
    public var time : Date? {
        get {
            if segments.count <= 0 {
                return nil
            } else {
                return segments[0].time
            }
        }
    }
    
    public var segments : [Segment] {
        get {
            return _segments
        }
    }
    private var _segments = [Segment]()
    
    public init() {
        self.name = nil
    }
    
    public init(withName name: String) {
        self.name = name
    }
    
    public init(withSegment segment: Segment){
        self.init()
        self.appendSegment(segment)
    }
    
    public init(withName name: String, andSegment segment: Segment){
        self.init(withName: name)
        self.appendSegment(segment)
    }
    
    public init(withSegments segments: [Segment]){
        self.init()
        self.appendSegments(segments)
    }
    
    public init(withName name: String, andSegments segments: [Segment]){
        self.init(withName: name)
        self.appendSegments(segments)
    }
    
    public init(withTrackPoints trackPoints : [WayPoint]){
        let segment = Segment(withWayPoints: trackPoints)
        self.init(withSegment: segment)
    }
    
    public init(withName name: String, andTrackPoints trackPoints : [WayPoint]){
        let segment = Segment(withWayPoints: trackPoints)
        self.init(withName: name, andSegment: segment)
    }
    
    public mutating func appendSegment(_ segment : Segment){
        _segments.append(segment)
        _segments = _segments.sorted(by: <)
    }
    
    public mutating func appendSegments(_ segments : [Segment]) {
        _segments.append(contentsOf: segments)
        _segments = _segments.sorted(by: <)
    }
}
