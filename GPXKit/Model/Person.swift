//
//  Person.swift
//  GPXKit
//
//  Created by Don Willems on 14/12/2017.
//  Copyright © 2017 lapsedpacifist. All rights reserved.
//

import Cocoa

public struct Person {

    public var name: String?
    public var email: String?
    public var link: Link?
    
    public init(withName name: String){
        self.name = name
    }
}
