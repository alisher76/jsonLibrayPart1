//
//  User.swift
//  LibrarayPart1
//
//  Created by Alisher Abdukarimov on 5/5/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import Foundation


class User {
    
    let userName: String
    let firstName: String
    let lastName: String
    let id: Int
    
    init(userName: String, firstName: String, lastName: String, id: Int) {
        self.userName  = userName
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
    }
    
    convenience init?(json: [String: Any]) {
        guard let userName = json[User.userNameKey] as? String,
            let firstName = json[User.firstNameKey] as? String,
            let lastName = json[User.lastNameKey] as? String,
            let id = json[User.idKey] as? Int
            else {
                return nil
        }
        self.init(userName: userName, firstName: firstName, lastName: lastName, id: id)
    }
    
    static func array(json: [[String: Any]]) -> [User]? {
        let back = json.flatMap(User.init(json:))
        guard back.count == json.count else {
            return nil
        }
        
        return back
    }
    static var userNameKey: String = "userName"
    static var firstNameKey: String = "firstName"
    static var lastNameKey: String = "lastName"
    static var idKey: String = "id"
}
