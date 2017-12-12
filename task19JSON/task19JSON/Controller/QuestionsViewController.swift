//
//  QuestionsViewController.swift
//  task19JSON
//
//  Created by Admin on 06.12.2017.
//  Copyright © 2017 Bioprom. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    @IBOutlet weak private var ibQuestionsTableView: UITableView!
    private var questions: [Question] = []
    var category: Categories?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupData()
    }
    
    private func setupData() {
        guard let category = category else { return }
        DataManager.instance.loadQuestionsCategoryUrl(of: category)
        questions = DataManager.instance.questionsOfCategories[category.name] ?? []
    }
    
    private func setupTable() {
        ibQuestionsTableView.delegate = self
        ibQuestionsTableView.dataSource = self
        ibQuestionsTableView.keyboardDismissMode = .onDrag
        ibQuestionsTableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
    }
    
    func getQuestion(for index: Int) -> String {
        return questions[index].question
    }

}

extension QuestionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier) as? TableViewCell else {
            fatalError("Error: Cell dosn`t exist")
        }
        let item = getQuestion(for: indexPath.row)
        cell.update(text: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: nameId.showQuestions, sender: indexPath)
    }
}
