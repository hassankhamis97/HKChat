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
    public func startNewConversation() {
        
    }
    public func getConversations() {
        
    }
    public func checkNewConversation(pearedUserId : String , completion : (_ isNewConversation: Bool) -> Void) {
        db?.collection("HK_UserChat").document(Auth.auth().currentUser!.uid).collection(Auth.auth().currentUser!.uid).document(pearedUserId).getDocument(completion: { (DocumentSnapshot, Error) in
            
        })
    }
}
