//
//  GarminTrackPointExtensionParser.swift
//  GPXKit
//
//  Created by Don Willems on 17/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public class GarminTrackPointExtensionParser: GPXExtensionParser {
    
    private let GarminTrackPointExtensionNamespace = "http://www.garmin.com/xmlschemas/TrackPointExtension/v1"

    public func canParseExtensionElement(withName elementName: String, namespaceURI: String?) -> Bool {
        if elementName == "TrackPointExtension" && namespaceURI == GarminTrackPointExtensionNamespace {
            return true
        }
        return false
    }
    
    public func GPXExtension(fromElement element: GPXElement, fromParser parser: GPXParser) -> GPXExtension? {
        let gpxExtension = GarminTrackPointExtension()
        for child in element.children {
            if (child as? GPXElement) != nil {
                let childELement = child as! GPXElement
                if childELement.elementName == "hr" && childELement.namespaceURI == GarminTrackPointExtensionNamespace {
                    let hrstr = childELement.textContent
                    if hrstr != nil {
                        let heartRate = UInt(hrstr!)
                        gpxExtension.heartRate = heartRate
                    }
                } else if childELement.elementName == "atemp" && childELement.namespaceURI == GarminTrackPointExtensionNamespace {
                    let atempstr = childELement.textContent
                    if atempstr != nil {
                        let airTemperature = Double(atempstr!)
                        gpxExtension.airTemperature = airTemperature
                    }
                } else if childELement.elementName == "wtemp" && childELement.namespaceURI == GarminTrackPointExtensionNamespace {
                    let wtempstr = childELement.textContent
                    if wtempstr != nil {
                        let waterTemperature = Double(wtempstr!)
                        gpxExtension.waterTemperature = waterTemperature
                    }
                } else if childELement.elementName == "cad" && childELement.namespaceURI == GarminTrackPointExtensionNamespace {
                    let cadstr = childELement.textContent
                    if cadstr != nil {
                        let cadence = UInt(cadstr!)
                        gpxExtension.cadence = cadence
                    }
                } else if childELement.elementName == "Extensions" && childELement.namespaceURI == GarminTrackPointExtensionNamespace {
                    let extensions = parser.extensions(fromElement: childELement)
                    gpxExtension.extensions = extensions
                }
            }
        }
        return gpxExtension
    }
}
