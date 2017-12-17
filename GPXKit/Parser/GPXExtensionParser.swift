//
//  GPXExtensionParser.swift
//  GPXKit
//
//  Created by Don Willems on 16/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public protocol GPXExtensionParser {
    
    func canParseExtensionElement(withName elementName: String, namespaceURI: String?) -> Bool
    
    func GPXExtension(fromElement element: GPXElement, fromParser parser: GPXParser) -> GPXExtension?
}
