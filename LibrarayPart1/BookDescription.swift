//
//  BookDescription.swift
//  LibrarayPart1
//
//  Created by Alisher Abdukarimov on 5/3/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class Book {
    
    let title: String
    let genre: String
    let author: String
    let user: User?
    
    init(title: String, genre: String, author: String, user: User?) {
        self.title = title
        self.genre = genre
        self.author = author
        self.user = user
    }
    
    convenience init?(json: [String: Any]) {
        guard let title = json[Book.titleKey] as? String,
            let genre = json[Book.genreKey] as? String,
            let author = json[Book.authorKey] as? String
            else {
                return nil
        }
        
        let userInfo = json[Book.userKey] as? [String: Any]
        let user = userInfo.flatMap(User.init(json:))
        
        
        self.init(title: title, genre: genre, author: author, user: user)
    }
    
    static func array(json: [[String: Any]]) -> [Book]? {
        let back = json.flatMap(Book.init(json:))
        guard back.count == json.count else {
            return nil
        }
        return back
    }
    static var titleKey: String = "title"
    static var genreKey: String = "genre"
    static var authorKey: String = "author"
    static var userKey: String = "user"
}
