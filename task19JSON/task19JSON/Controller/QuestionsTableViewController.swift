//
//  QuestionsViewController.swift
//  task19JSON
//
//  Created by Admin on 06.12.2017.
//  Copyright © 2017 Bioprom. All rights reserved.
//

import UIKit

class QuestionsTableViewController: UIViewController {
    
    @IBOutlet private weak var ibQuestionsTableView: UITableView!
    @IBOutlet private weak var ibLabelLoad: UILabel!
    @IBOutlet private weak var ibActivLoad: UIActivityIndicatorView!
    private var questionsCategory: [Question] = []
    var category: Categories?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupData()
    }
    
    private func setupData() {
        guard let category = category else { return }
        ibQuestionsTableView.isHidden = true
        ibLabelLoad.isHidden = false
        ibActivLoad.isHidden = false
        ibActivLoad.startAnimating()
        DispatchQueue.global().async {
            DataManager.instance.loadQuestionsCategory(of: category) {
                DispatchQueue.main.async { [weak self] in
                    self?.questionsCategory = DataManager.instance.questionsOfCategories[category.name] ?? []
                    self?.ibQuestionsTableView.isHidden = false
                    self?.ibQuestionsTableView.reloadData()
                    self?.ibLabelLoad.isHidden = true
                    self?.ibActivLoad.isHidden = true
                    self?.ibActivLoad.stopAnimating()
                }
            }
        }
    }
    
    private func setupTable() {
        ibQuestionsTableView.delegate = self
        ibQuestionsTableView.dataSource = self
        ibQuestionsTableView.keyboardDismissMode = .onDrag
        ibQuestionsTableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
    }
    
    private func getQuestion(for index: Int) -> String {
        return questionsCategory[index].question
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? QuestionViewController else { return }
        guard let indexPath = sender as? IndexPath else { return }
        destVC.question = questionsCategory[indexPath.row]
    }
    
}

extension QuestionsTableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsCategory.count
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
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: nameId.showDetailsQuestion, sender: indexPath)
    }
}
