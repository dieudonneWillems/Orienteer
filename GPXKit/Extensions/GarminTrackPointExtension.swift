//
//  GarminTrackPointExtension.swift
//  GPXKit
//
//  Created by Don Willems on 17/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public class GarminTrackPointExtension: GPXExtension {
    public var airTemperature : Double?
    public var waterTemperature : Double?
    public var depth : Double?
    public var heartRate : UInt?
    public var cadence : UInt?
    public var extensions = [GPXExtension]()
}
