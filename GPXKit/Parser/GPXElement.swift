//
//  GPXElement.swift
//  GPXKit
//
//  Created by Don Willems on 17/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public class GPXElement : NSObject {
    public let elementName : String
    public let namespaceURI : String?
    public let attributes : [String:String]
    
    public var parent : GPXElement?
    public var children = [Any]()
    
    public var depth : Int {
        get {
            if parent != nil {
                return parent!.depth - 1
            }
            return 0
        }
    }
    
    public var textContent : String? {
        get {
            var text = ""
            for child in children {
                if (child as? String) != nil {
                    text.append(child as! String)
                } else if (child as? GPXElement) != nil {
                    let tc = (child as! GPXElement).textContent
                    if tc != nil {
                        text.append(tc!)
                    }
                }
            }
            if text.count <= 0 {
                return nil
            }
            return text
        }
    }
    
    init(elementName: String, namespaceURI: String?, attributes : [String : String]) {
        self.elementName = elementName
        self.namespaceURI = namespaceURI
        self.attributes = attributes
    }

}
