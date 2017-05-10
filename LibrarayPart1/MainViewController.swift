//
//  MainViewController.swift
//  LibrarayPart1
//
//  Created by Alisher Abdukarimov on 5/3/17.
//  Copyright © 2017 MrAliGorithm. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var checkedOutInfoLabel: UILabel!
    
    @IBOutlet weak var userEmailLabel: UILabel!
    
    
    var library = [Book]()
    var index = 0
    func fetchData() {
        
        guard let libraryURL = URL(string: "https://tiy-todo-angular.herokuapp.com/get-all-books.json") else {
            fatalError("failed to create URL")
        }
        
        var request = URLRequest(url: libraryURL)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, responce, error) in
            if error != nil {
                print("error")
                return
            }else{
                
                if let data = data {
                    self.library = self.parseJsonData(data: data)
                    
                    OperationQueue.main.addOperation {
                        self.updateUI()
                    }
                }
            }
        })
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [Book]{
        
        var books = [Book]()
        
        do {
            let jsonResult = try! JSONSerialization.jsonObject(with: data, options: []) as? [[String:Any]]
            guard let dictionary = Book.array(json: jsonResult!) else {
                fatalError("Bad thing happened here")
            }
            books = dictionary
        }
        return books
    }
    
    @IBAction func nextTapped(_ sender: Any) {
        index += 1
        if index == library.count {
            index = 0
        }
        updateUI()
    }
    
    func updateUI(){
        
        self.titleLabel.text = "\(self.library[self.index].title)"
        self.genreLabel.text = self.library[self.index].genre
        self.authorLabel.text = self.library[self.index].author
        if self.library[self.index].user == nil{
            userEmailLabel.alpha = 0
            userLabel.alpha = 0
            self.checkedOutInfoLabel.text = "No one checked out the book yet."
        }else{
            userEmailLabel.alpha = 1
            userLabel.alpha = 1
            self.checkedOutInfoLabel.text = "Person Who Checked out the book!"
        }
        self.userLabel.text = "User Name: \(String(describing: self.library[self.index].user?.firstName))"
        self.userEmailLabel.text = "User Id: \(String(describing: self.library[self.index].user?.id))"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
}
