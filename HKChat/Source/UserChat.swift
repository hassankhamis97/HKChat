//
//  UserChat.swift
//  abseil
//
//  Created by Hassan Khamis on 6/30/20.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


public class HKChat {
    static var userChatId : Int?
    static var displayName : String?
    public static func configure(){
        userChatId = UserDefaults.standard.integer(forKey: "userChatId")
        displayName = UserDefaults.standard.string(forKey: "displayName")
    }
}


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
    public func signupChat(email: String, name: String, photoUrl: String, completions: @escaping (_ error: Error?) -> Void ) {
        
//        let maxValue = Int.max
        let maxValue = 999999999999
        let userChatData = HKUserChatData(userId: Auth.auth().currentUser!.uid,
                                          email: email,
                                          userChatId: Int.random(in: 0 ... maxValue),
                                          name: name,
                                          photoUrl: photoUrl,
                                          currentViewedPerson: "")
        //        let userChatData = HKUserChatData(userId: <#T##String#>, userChatId: Int.random(in: 0 ... maxValue), name: name, photoUrl: photoUrl, currentViewedPerson: "")
        //          let userChatData = HKUserChatData(userChatId: Int.random(in: 0 ... maxValue), name: name, photoUrl: photoUrl, currentViewedPerson: "")
        let userChatDataDic = try! DictionaryEncoder.encode(userChatData)
        db?.collection("HK_UserChat").document(Auth.auth().currentUser!.uid).setData(userChatDataDic, completion: { err in
            if let err = err {
                print("Error writing document: \(err)")
                completions(err)
            } else {
                completions(nil)
                print("Document successfully written!")
                UserDefaults.standard.set(userChatData.userChatId, forKey: "userChatId")
                UserDefaults.standard.set(userChatData.name, forKey: "displayName")
                HKChat.configure()
            }
        })
    }
    public func loginChat() {
        
        db?.collection("HK_UserChat").document(Auth.auth().currentUser!.uid).getDocument(completion: { (DocumentSnapshot, Error) in
            UserDefaults.standard.set(DocumentSnapshot?.data()!["userChatId"] as? Int, forKey: "UserChatId")
            UserDefaults.standard.set(DocumentSnapshot?.data()!["name"] as? Int, forKey: "displayName")
            HKChat.configure()
        })
    }
    public func signoutChat() {
        UserDefaults.standard.removeObject(forKey: "UserChatId")
    }
    public func getAllUsers(completion: @escaping (_ results : [HKUserChatData]) -> Void) {
        
        db?.collection("HK_UserChat").getDocuments(completion: { (DocumentSnapshot, Error) in
            if let err = Error {
                print("Error getting docments : \(err)")
            }else{
                var userChatDataList = [HKUserChatData]()
                //                 DocumentSnapshot?.documents.count
                for doc in DocumentSnapshot!.documents{
                    print(doc.reference.documentID)
                    let userChatData : HKUserChatData = HKUserChatData(userId: doc.data()["userId"] as? String ?? "",
                                                                       email: doc.data()["email"] as? String ?? "",
                                                                       userChatId: doc.data()["userChatId"] as? Int ?? 0,
                                                                       name: doc.data()["name"] as? String ?? "",
                                                                       photoUrl: doc.data()["photoUrl"] as? String ?? "",
                                                                       currentViewedPerson: doc.data()["currentViewedPerson"] as? String ?? "")
                    //                    let userChatData : HKUserChatData = HKUserChatData(
                    //                        userChatId: doc.data()["userChatId"] as? Int ?? 0,
                    //                        name: doc.data()["name"] as? String ?? "",
                    //                        photoUrl: doc.data()["photoUrl"] as? String ?? "",
                    //                        currentViewedPerson: doc.data()["currentViewedPerson"] as? String ?? "")
                    
                    //                    if (pearedObj.idPearedUser == Auth.auth().currentUser!.uid)
                    //                    {
                    //                        pearedObj.idPearedUser = doc.documentID
                    //                    }
                    userChatDataList.append(userChatData)
                }
                completion(userChatDataList)
                //self.newPresenter.onSuccess(pearedArr: self.pearedArr)
            }
        })
    }
}
