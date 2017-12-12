//
//  ViewController.swift
//  task19JSON
//
//  Created by Admin on 12.12.2017.
//  Copyright © 2017 Bioprom. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet private weak var ibLableCategory: UILabel!
    @IBOutlet private weak var ibLableQiestion: UILabel!
    var question : Question?

    override func viewDidLoad() {
        super.viewDidLoad()
        ibLableCategory.text = question?.categoryName
        ibLableQiestion.text = question?.question
    }

}
