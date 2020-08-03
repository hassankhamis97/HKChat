//
//  Messaging.swift
//  HChat
//
//  Created by Hassan Khamis on 6/26/20.
//  Copyright © 2020 Hassan Khamis. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import MessageKit
public class Messaging {
    let db : Firestore?
    static var instance : Messaging? = nil
    private init(){
        db = Firestore.firestore()
    }
    public static func getInstance() -> Messaging{
        if Messaging.instance == nil {
            Messaging.instance = Messaging()
        }
        return Messaging.instance!
    }
    
    
    public func sendTextMessage(userChatId : Int,userId: String, message: String) {
//        if isNewConversation {
        var roomId : String?
        let messageId = String.random()
            let conversation = Conversation.getInstance()
            conversation.updateUserChatConversation(userId: userId, messageType: 1, lastMessage: message)
        
        if userChatId > HKChat.userChatId! {
            roomId = "\(userChatId)-\(HKChat.userChatId!)"
        }
        else{
            roomId = "\(HKChat.userChatId!)-\(userChatId)"
        }
        let messageObj = HKMessage(messageId: messageId, messageKind: 1, sentDate: Date(), messageText: message, senderId: Auth.auth().currentUser!.uid, displayName: HKChat.displayName!)
        var messageObjDic = try! DictionaryEncoder.encode(messageObj)
        messageObjDic["sentDate"] = FieldValue.serverTimestamp()
        db?.collection("HK_Messaging").document(roomId!).collection(roomId!).document(messageId).setData(messageObjDic, completion: { (error) in

        })
        
    }
    
    public func getMessages(userChatId : Int, completion: @escaping (_ results: [Message]) -> Void) {
        var roomId : String?
        if userChatId > HKChat.userChatId! {
            roomId = "\(userChatId)-\(HKChat.userChatId!)"
        }
        else{
            roomId = "\(HKChat.userChatId!)-\(userChatId)"
        }
        db?.collection("HK_Messaging").document(roomId!).collection(roomId!).order(by: "sentDate", descending: true).addSnapshotListener({ (querySnapshot, error) in
            var messages = [Message]()
            for item in querySnapshot!.documents {
                let sentDate = item.data()["sentDate"] as! Timestamp
//                x.seconds
                let sender = Sender(senderId: item.data()["senderId"] as! String, displayName: item.data()["displayName"] as! String)
                let messageKit = Message(sender: sender, messageId: item.data()["messageId"] as! String, sentDate: sentDate.dateValue(), kind: .text(item.data()["messageText"] as! String))
                messages.append(messageKit)
            }
            completion(messages)
        })
    }
    
    
}

extension String {

    static func random(length: Int = 20) -> String {
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""

        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }
}
public struct HKMessage : Codable{
    public var messageId: String
    
    public var messageKind: Int
    
    public var sentDate: Date
    
    public var messageText: String
    
    public var senderId: String
    
    public var displayName: String

}
public struct Message: MessageType {
    public var sender: SenderType
    
    public var messageId: String
    
    public var sentDate: Date
    
    public var kind: MessageKind
    
    public init(sender: SenderType,messageId: String,sentDate: Date,kind: MessageKind) {
        self.sender = sender
        self.messageId = messageId
        self.sentDate = sentDate
        self.kind = kind
    }
}
struct Sender : SenderType {
    public var senderId: String
    
    public var displayName: String
}
