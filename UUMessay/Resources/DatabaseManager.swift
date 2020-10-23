//
//  DatabaseManager.swift
//  UUMessay
//
//  Created by Yuyu Qian on 10/11/20.
//

import Foundation
import FirebaseDatabase

//final means no subclass of it will be allowed
final class DatabaseManager {
    
    //singleton method!
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    //    public func test() {
    //
    //        database.child("foo").setValue(["somethig": true])
    //
    //    }
    
}


// MARK: - Account Management

extension DatabaseManager {
    
    ///
    public func userExists(with email: String,
                           completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: {snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        })
    }
    
    /// Inserts new user to database
    public func inserUser(with user: ChatAppUser) {
        database.child(user.safeEmail).setValue([
            "firstName": user.firstName,
            "lastName": user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    //    let profilePictureUrl: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
}
