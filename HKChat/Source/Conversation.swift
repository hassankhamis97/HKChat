//
//  Conversation.swift
//  HKChat
//
//  Created by Hassan Khamis on 6/30/20.
//  Copyright © 2020 Hassan Khamis. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
public class Conversation{
    let db : Firestore?
    static var instance : Conversation? = nil
    private init(){
        db = Firestore.firestore()
    }
    public static func getInstance() -> Conversation{
        if Conversation.instance == nil {
            Conversation.instance = Conversation()
        }
        return Conversation.instance!
    }
    public func updateUserChatConversation(userId: String,messageType: Int,lastMessage: String?) {
        let conversation = HKConversation(lastMessageType: messageType, lastMessage: lastMessage ?? "", lastMsgTimeStamp: Date()
            , noOfUnReadMessage: 0, senderId: Auth.auth().currentUser!.uid)
        var conversaionDic = try! DictionaryEncoder.encode(conversation)
        conversaionDic["lastMsgTimeStamp"] = FieldValue.serverTimestamp()
        
        saveInFireStore(firstId: Auth.auth().currentUser!.uid, secondId: userId, conversaionDic: conversaionDic)
        saveInFireStore(firstId: userId, secondId: Auth.auth().currentUser!.uid, conversaionDic: conversaionDic)
        
    }
    private func saveInFireStore(firstId: String, secondId: String, conversaionDic: [String : Any])
    {
        db?.collection("HK_UserChat").document(firstId).collection(firstId).document(secondId).setData(conversaionDic, completion: { (error) in
            guard error != nil else {
                //                print(error?.localizedDescription)
                return
            }
        })
    }
    public func getConversations(completion: @escaping (_ results: [HKConversationDetail]) -> Void) {
        var conversations = [HKConversationDetail]()
        db?.collection("HK_UserChat").document(Auth.auth().currentUser!.uid).collection(Auth.auth().currentUser!.uid).getDocuments(completion: { (querySnapshot, error) in
            for doc in querySnapshot!.documents {
                let timestamp = doc["lastMsgTimeStamp"] as! Timestamp
                let conversation = HKConversationDetail(pearedUserId: doc.reference.documentID,
                    lastMessageType: doc["lastMessageType"] as! Int,
                                                        lastMessage: doc["lastMessage"] as! String,
                                                        lastMsgTimeStamp: timestamp.dateValue(),
                                                        noOfUnReadMessage: doc["noOfUnReadMessage"] as! Int,
                                                        senderId: doc["senderId"] as! String)
//                self.fillConversationData()
                conversations.append(conversation)
            }
            self.fillConversationData(conversations: conversations) {
                completion(conversations)
            }
//            self.fillConversationData(conversations: conversations, completion: nil)
//            completion(conversations)
            
        })
    }
    private func fillConversationData(conversations: [HKConversationDetail] , completion: @escaping () -> Void) {
        var count = 0
        for conversation in conversations {
            db?.collection("HK_UserChat").document(conversation.pearedUserId!).getDocument(completion: { (documentSnapshot, error) in
                
                count += 1
                conversation.name = documentSnapshot?.data()!["name"] as? String
                conversation.photoUrl = documentSnapshot?.data()!["photoUrl"] as? String
                conversation.userChatId = documentSnapshot?.data()!["userChatId"] as? Int
                conversation.email = documentSnapshot?.data()!["email"] as? String
                conversation.pearedUserId = documentSnapshot?.data()!["userId"] as? String
                conversation.currentViewedPerson = documentSnapshot?.data()!["currentViewedPerson"] as? String
                if count == conversations.count {
                    print(conversations)
                    completion()
                }
            })
            
        }
    }
    public func checkNewConversation(userChatId: Int , completion : @escaping (_ isNewConversation: Bool) -> Void) {
        //        db?.collection("HK_UserChat").document(Auth.auth().currentUser!.email!).collection(Auth.auth().currentUser!.email!).whereField("userChatId", in: [userChatId]).getDocuments(completion: { (DocumentSnapshot, Error) in
        //            if (DocumentSnapshot?.documents.count)! > 0 {
        //                completion(false)
        //            }
        //            else {
        //                completion(true)
        //            }
        
        
        //        })
        db?.collection("HK_UserChat").document(String(HKChat.userChatId!)).collection(String(HKChat.userChatId!)).document(String(userChatId)).getDocument(completion: { (documentSnapshot, error) in
            completion(!(documentSnapshot!.exists))
        })
    }
}
