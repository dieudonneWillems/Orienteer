//
//  Copyright.swift
//  GPXKit
//
//  Created by Don Willems on 14/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public struct Copyright {
    
    public let author: String
    public var year: Int?
    public var license: String?
    
    public init(withAuthor author: String) {
        self.author = author
    }
}
