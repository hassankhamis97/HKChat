//
//  HKUserChatData.swift
//  HKChat
//
//  Created by Hassan Khamis on 6/30/20.
//  Copyright © 2020 Hassan Khamis. All rights reserved.
//

import Foundation
public protocol HKUserChatDataType : Codable {
    
    var chatId: Int { get }
    
    var name: String { get }
    
    var photoUrl: String { get }
    
    var currentViewedPerson: String { get }
}
struct HKUserChatData : HKUserChatDataType {
    var chatId: Int
    
    var name: String
    
    var photoUrl: String
    
    var currentViewedPerson: String
    
}
