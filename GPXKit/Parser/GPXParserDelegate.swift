//
//  GPXParserDelegate.swift
//  GPXKit
//
//  Created by Don Willems on 15/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public protocol GPXParserDelegate  {

    func parserDidStartGPXDocument(_ parser: GPXParser)
    func parser(_ parser: GPXParser, finishedParsingDocumentWithResult data : GPSData?)
    func parser(_ parser: GPXParser, encounteredError error: Error)
}
