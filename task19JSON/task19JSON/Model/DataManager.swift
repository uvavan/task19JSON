//
//  DataManager.swift
//  task19JSON
//
//  Created by Admin on 06.12.2017.
//  Copyright © 2017 Bioprom. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

final class DataManager {
    static let instance = DataManager()
    
    private(set) var categories: [Categories] = []
    private(set) var questionsOfCategories: [String : [Question]] = [:]
    
    // MARK: - Categories method
    func loadCategories(url: String, runDidLoad: (() -> Void)?) {
        DataManager.instance.clearCategories()
        Alamofire.request(url).responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                let jsonObj = JSON(value)
                guard let jsonArray = jsonObj.array else { return }
                for jsonObject in jsonArray {
                    guard let category = Categories(json: jsonObject) else { continue }
                    self?.addCategory(category)
                }
                runDidLoad?()
            case .failure(let error) :
                debugPrint(error)
            }
        }
    }
    
    func addCategory(_ category: Categories) {
       categories.append(category)
    }
    
    func clearCategories() {
        categories = []
    }
    
    // MARK: - Question method
    func loadQuestionsCategory(of category: Categories, runDidLoad: (() -> Void)?) {
        if questionsOfCategories[category.name] == nil {
            Alamofire.request("https://qriusity.com/v1/categories/\(category.id)/questions").responseJSON { [weak self] response in
                switch response.result {
                case .success(let value):
                    let jsonObj = JSON(value)
                    guard let jsonArray = jsonObj.array else { return }
                    self?.addQuestionCategories(questionsJson: jsonArray, category: category.name)
                    runDidLoad!()
                case .failure(let error):
                    debugPrint(error)
                }
            }
        } else {
            runDidLoad!()
        }
    }
    
    func addQuestionCategories(questionsJson: [JSON], category name: String) {
        var questions: [Question] = []
        for jsonObject in questionsJson {
            guard let question = Question(json: jsonObject) else { continue }
            questions.append(question)
        }
        questionsOfCategories[name] = questions
    }

}
