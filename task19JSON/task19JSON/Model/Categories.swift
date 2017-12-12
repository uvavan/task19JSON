//
//  Categories.swift
//  task19JSON
//
//  Created by Admin on 06.12.2017.
//  Copyright © 2017 Bioprom. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Categories {
    let name: String
    let questionsCount: Int
    let id: Int
    let createdAt: String
    let updatedAt: String
}

extension Categories {
    init?(json: JSON) {
        guard let id = json["id"].int,
              let name = json["name"].string else {
                return nil
        }
        self.id = id
        self.name = name
        self.questionsCount = json[].intValue
        self.createdAt = json["createdAt"].stringValue
        self.updatedAt = json["updatedAt"].stringValue
    }
}
