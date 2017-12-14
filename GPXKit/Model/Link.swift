//
//  Link.swift
//  GPXKit
//
//  Created by Don Willems on 14/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public struct Link {
    
    public let url : URL
    public var text : String?
    public var mimeType : String?

    public init(withURL url: URL) {
        self.url = url
    }
}
