//
//  GPXParser.swift
//  GPXKit
//
//  Created by Don Willems on 15/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public class GPXParser: NSObject, XMLParserDelegate {
    
    public let fileURL : URL
    public var delegate : GPXParserDelegate?
    public var extensionParsers = [GPXExtensionParser]()
    
    private let parser : XMLParser?
    private var result: GPSData?
    private var currentExtensionParser : GPXExtensionParser?
    
    public init?(contentsOf file: URL) {
        self.fileURL = file
        parser = XMLParser(contentsOf: fileURL)
        if parser == nil {
            return nil
        }
        super.init()
        parser!.shouldProcessNamespaces = true
        parser!.delegate = self
    }
    
    public func parse() {
        parser!.parse()
    }
    
    public func parserDidStartDocument(_ parser: XMLParser) {
        print("Parser started on document")
        delegate?.parserDidStartGPXDocument(self)
    }
    
    public func parserDidEndDocument(_ parser: XMLParser) {
        print("Parser ended on document")
        delegate?.parser(self, finishedParsingDocumentWithResult: result)
    }
    
    public func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if currentExtensionParser != nil {
            currentExtensionParser!.parser(self, didStartElement: elementName, namespaceURI: namespaceURI, qualifiedName: qName, attributes: attributeDict)
        } else {
            
        }
        print("Parser started on element \(elementName) with namespace \(namespaceURI ?? "no namespace"), qualified name: \(qName ?? "no qualified name"), and attributes \(attributeDict)")
    }
    
    public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        if currentExtensionParser != nil {
            currentExtensionParser!.parser(self, didEndElement: elementName, namespaceURI: namespaceURI, qualifiedName: qName)
        } else {
            
        }
        print("Parser ended on element \(elementName) with namespace \(namespaceURI ?? "no namespace"), qualified name: \(qName ?? "no qualified name")")
    }
    
    public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("Parser error occurred: \(parseError)")
        delegate?.parser(self, encounteredError: parseError)
    }
    
    public func parser(_ parser: XMLParser, foundCharacters string: String) {
        if currentExtensionParser != nil {
            currentExtensionParser!.parser(self, foundCharacters: string)
        } else {
            
        }
        print("Parser found characters: \(string)")
    }
    
    public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        if currentExtensionParser != nil {
            currentExtensionParser!.parser(self, foundCDATA: CDATABlock)
        } else {
            
        }
        print("Parser found CDATA: \(CDATABlock)")
    }
}
