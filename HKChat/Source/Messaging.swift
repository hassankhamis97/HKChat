//
//  Messaging.swift
//  HChat
//
//  Created by Hassan Khamis on 6/26/20.
//  Copyright © 2020 Hassan Khamis. All rights reserved.
//

import Foundation
public class Messaging {
    static var instance : Messaging? = nil
    private init(){
        
    }
    public static func getInstance() -> Messaging{
        if Messaging.instance == nil {
            Messaging.instance = Messaging()
        }
        return Messaging.instance!
    }
    public func name() {
        print("YESSSSS")
    }
}
