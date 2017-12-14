//
//  Copyright.swift
//  GPXKit
//
//  Created by Don Willems on 14/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public struct Copyright {
    
    public var author: String?
    public var year: Int?
    public var license: URL?
    
    public init(withAuthor author: String, andYear year: Int) {
        self.author = author
        self.year = year
    }
    
    public init(withAuthor author: String, year: Int, andLicense license: URL) {
        self.author = author
        self.year = year
        self.license = license
    }
}
