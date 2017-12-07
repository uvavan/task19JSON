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
    let category: Categories
    let question: String
    let option1: String
    let option2: String
    let option3: String
    let option4: String
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
        guard let categoryJson = json["category"][""] .object as? JSON else {
            return nil
        }
        guard let category = Categories(json: categoryJson) else {
            return nil
        }
        self.category = category
        self.id = id
        self.question = question
        self.option1 = json["option1"].stringValue
        self.option2 = json["option2"].stringValue
        self.option3 = json["option3"].stringValue
        self.option4 = json["option4"].stringValue
        self.answers = answers
        self.createdAt = json["createdAt"].stringValue
        self.updatedAt = json["updatedAt"].stringValue
    }
}
