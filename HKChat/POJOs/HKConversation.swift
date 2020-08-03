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
    
    var lastMessageType: Int { get }
    
    var lastMsgTimeStamp: Date { get }
    
    var noOfUnReadMessage: Int { get }
    
    var senderId: String { get }
}
struct HKConversation : HKConversationType {
    var lastMessageType: Int
    
    var lastMessage: String
    
    var lastMsgTimeStamp: Date
    
    var noOfUnReadMessage: Int
    
    var senderId: String
}
public class HKConversationDetail {
    public var name: String?
    
    public var photoUrl: String?
    
    public var email: String?
    
    public var pearedUserId: String?
    
    public var lastMessageType: Int?
    
    public var lastMessage: String?
    
    public var lastMsgTimeStamp: Date?
    
    public var noOfUnReadMessage: Int?
    
    public var senderId: String?
    
    public var userChatId: Int?
    
    public var currentViewedPerson: String?
    
    init(pearedUserId: String,lastMessageType: Int,lastMessage: String,lastMsgTimeStamp: Date,noOfUnReadMessage: Int,senderId: String) {
        self.pearedUserId = pearedUserId
        self.lastMessageType = lastMessageType
        self.lastMessage = lastMessage
        self.lastMsgTimeStamp = lastMsgTimeStamp
        self.noOfUnReadMessage = noOfUnReadMessage
        self.senderId = senderId
    }
}
