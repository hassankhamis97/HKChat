//
//  HKConversation.swift
//  HKChat
//
//  Created by Hassan Khamis on 6/30/20.
//  Copyright © 2020 Hassan Khamis. All rights reserved.
//

import Foundation

public protocol HKConversationType : Codable {
    
    var lastMessage: String { get }
    
    var lastMsgTimeStamp: Date { get }
    
    var noOfUnReadMessage: Int { get }
    
    var senderId: String { get }
}
struct HKConversation : HKConversationType {
    var lastMessage: String
    
    var lastMsgTimeStamp: Date
    
    var noOfUnReadMessage: Int
    
    var senderId: String
}
