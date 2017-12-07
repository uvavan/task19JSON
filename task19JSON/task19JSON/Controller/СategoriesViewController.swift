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
    //private var datasourse: [Categories] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        loadCategories()
    }
    
    private func loadCategories() {
        DataManager.instance.clearCategories()
        Alamofire.request("http://qriusity.com/v1/categories/").responseJSON { response in
            switch response.result {
            case .success(let value):
                let jsonObj = JSON(value)
                guard let jsonArray = jsonObj.array else { return }
                for jsonObject in jsonArray {
                    guard let category = Categories(json: jsonObject) else { continue }
                    DataManager.instance.addCategory(category)
                }
                self.ibTableCategories.reloadData()
            case .failure(let error) :
                debugPrint(error)
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
}
