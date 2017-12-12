//
//  ViewController.swift
//  task19JSON
//
//  Created by Admin on 06.12.2017.
//  Copyright © 2017 Bioprom. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RootViewController: UIViewController {
    
    @IBOutlet private weak var ibTableCategories: UITableView!
    @IBOutlet private weak var ibViewLoad: UIView!
    @IBOutlet private weak var ibActivLoad: UIActivityIndicatorView!
    //private var datasourse: [Categories] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        loadCategories()
    }
    
    private func loadCategories() {
        ibTableCategories.isHidden = true
        ibViewLoad.isHidden = false
        ibActivLoad.isHidden = false
        ibActivLoad.startAnimating()
        DispatchQueue.global().async {
            DataManager.instance.loadCategories(url: "https://qriusity.com/v1/categories/") {
                DispatchQueue.main.async { [weak self] in
                    self?.ibTableCategories.isHidden = false
                    self?.ibTableCategories.reloadData()
                    self?.ibActivLoad.stopAnimating()
                    self?.ibViewLoad.isHidden = true
                    self?.ibActivLoad.isHidden = true
                }
            }
        }
    }
    
    private func setupTable() {
        ibTableCategories.delegate = self
        ibTableCategories.dataSource = self
        ibTableCategories.keyboardDismissMode = .onDrag
        ibTableCategories.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
    }
    
    private func getCategoryName(for indexPath: IndexPath) -> String? {
       return DataManager.instance.categories[indexPath.row].name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? QuestionsViewController else { return }
        guard let indexPath = sender as? IndexPath else { return }
        destVC.category = DataManager.instance.categories[indexPath.row]
    }
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataManager.instance.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseIdentifier) as? TableViewCell else {
            fatalError("Error: Cell dosn`t exist")
        }
        guard let item = getCategoryName(for: indexPath) else {
            fatalError("Error: Cell not found")
        }
        cell.update(text: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: nameId.showQuestions, sender: indexPath)
    }
}
