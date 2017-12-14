//
//  FixType.swift
//  GPXKit
//
//  Created by Don Willems on 14/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

public enum FixType: String {
    case none = "none"
    case twoDimensional = "2d"
    case threeDimensional = "3d"
    case differentialGlobalPositioning = "dgps"
    case militarySignal = "pps"
}
