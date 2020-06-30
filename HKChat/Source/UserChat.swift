//
//  UserChat.swift
//  abseil
//
//  Created by Hassan Khamis on 6/30/20.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

public class UserChat {
    let db : Firestore?
    static var instance : UserChat? = nil
    private init(){
        db = Firestore.firestore()
    }
    public static func getInstance() -> UserChat{
        if UserChat.instance == nil {
            UserChat.instance = UserChat()
        }
        return UserChat.instance!
    }
    public func signupChat(name: String, photoUrl: String, completions: @escaping (_ error: Error?) -> Void ) {
        let maxValue = Int.max
        let userChatData = HKUserChatData(chatId: Int.random(in: 0 ... maxValue), name: name, photoUrl: photoUrl, currentViewedPerson: "")
        let userChatDataDic = try! DictionaryEncoder.encode(userChatData)
        db?.collection("HK_UserChat").document(Auth.auth().currentUser!.uid).setData(userChatDataDic, completion: { err in
            if let err = err {
                print("Error writing document: \(err)")
                completions(err)
            } else {
                completions(nil)
                print("Document successfully written!")
            }
        })
    }
    public func getAllUsers() {
        db?.collection("HK_UserChat").document(Auth.auth().currentUser!.uid).getDocument(completion: { (DocumentSnapshot, Error) in
            
        })
    }
}
