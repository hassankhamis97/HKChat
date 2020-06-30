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
    
    
    public func sendTextMessage(isNewConversation : Bool) {
        if isNewConversation {
            let conversation = Conversation.getInstance()
            conversation.startNewConversation()
        }
//        db?.collection("HK_Messages").document(Auth.auth().currentUser!.uid).setData(userChatDataDic, completion: { err in
//            if let err = err {
//                print("Error writing document: \(err)")
//                completions(err)
//            } else {
//                completions(nil)
//                print("Document successfully written!")
//            }
//        })
    }
    
    
}

