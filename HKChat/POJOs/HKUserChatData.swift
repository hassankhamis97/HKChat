//
//  HKUserChatData.swift
//  HKChat
//
//  Created by Hassan Khamis on 6/30/20.
//  Copyright © 2020 Hassan Khamis. All rights reserved.
//

import Foundation
public protocol HKUserChatDataType : Codable {
    var email: String { get }
    
    var userChatId: Int { get }
    
    var userId: String { get }
    
    var name: String { get }
    
    var photoUrl: String { get }
    
    var currentViewedPerson: String { get }
}
public struct HKUserChatData : HKUserChatDataType {
    public var userId: String
    
    public var email: String
    
    public var userChatId: Int
    
    public var name: String
    
    public var photoUrl: String
    
    public var currentViewedPerson: String
    
    public init(userId: String,email: String,userChatId: Int,name: String,photoUrl: String,currentViewedPerson: String){
        self.userId = userId
        self.email = email
        self.userChatId = userChatId
        self.name = name
        self.photoUrl = photoUrl
        self.currentViewedPerson = currentViewedPerson
    }
    
}

