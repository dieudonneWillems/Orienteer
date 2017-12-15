//
//  GPXExtensionParser.swift
//  GPXKit
//
//  Created by Don Willems on 16/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

protocol GPXExtensionParser {
    
    public func canParseExtensionElement(withName elementName: String, namespaceURI: String?) -> Bool
    
    public func parserDidStartExtensionElement(_ parser: GPXParser)
    public func parser(_ parser: GPXParser, didEndExtensionElementWithResult: Extension?)
    public func parser(_ parser: GPXParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    public func parser(_ parser: GPXParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    public func parser(_ parser: GPXParser, foundCharacters string: String)
    public func parser(_ parser: GPXParser, foundCDATA CDATABlock: Data)
}
