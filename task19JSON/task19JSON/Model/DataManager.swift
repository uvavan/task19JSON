//
//  DataManager.swift
//  task19JSON
//
//  Created by Admin on 06.12.2017.
//  Copyright © 2017 Bioprom. All rights reserved.
//

import Foundation
import SwiftyJSON

final class DataManager {
    static let instance = DataManager()
    
    private(set) var categories: [Categories] = []
    private(set) var questionsOfCategories: [String : [Question]] = [:]
    
    func addCategory(_ category: Categories) {
       categories.append(category)
    }
    
    func clearCategories() {
        categories = []
    }

}
