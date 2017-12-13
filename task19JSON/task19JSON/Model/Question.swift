//
//  Question.swift
//  task19JSON
//
//  Created by Admin on 06.12.2017.
//  Copyright © 2017 Bioprom. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Question {
    let categoryName: String
    let categoryId: Int
    let question: String
    var options: [String]
    let answers: Int
    let id: Int
    let createdAt: String
    let updatedAt: String
}

extension Question {
    init?(json: JSON) {
        guard let id = json["id"].int,
              let question = json["question"].string,
              let answers = json["answers"].int else {
                return nil
        }
        guard let categoryName = json["category"]["name"].string else {
            return nil
        }
        guard let categoryId = json["category"]["id"].int else {
            return nil
        }
        self.categoryName = categoryName
        self.categoryId = categoryId
        self.id = id
        self.question = question
        self.options = []
        for index in 1...4 {
            let option = json["option\(index)"].stringValue
            self.options.append(option)
        }
        self.answers = answers
        self.createdAt = json["createdAt"].stringValue
        self.updatedAt = json["updatedAt"].stringValue
    }
}
