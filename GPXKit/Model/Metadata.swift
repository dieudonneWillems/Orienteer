//
//  Metadata.swift
//  GPXKit
//
//  Created by Don Willems on 14/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public struct Metadata {
    
    public var name : String?
    public var fileDescription: String?
    public var author : Person?
    public var copyright : Copyright?
    public var links = [Link]()
    public var creationDate : Date?
    public var keywords: [String]
    public var bounds : Bounds?
    
    // TODO: Add Extensions
}
