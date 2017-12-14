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
    @IBOutlet private weak var ibStackViewVertical: UIStackView!
    private var buttonOptions: [UIButton] = []
    
    var question: Question?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ibLableCategory.text = question?.categoryName
        ibLableQiestion.text = question?.question
        setupButton()
    }
    
    private func setupButton() {
        for (index, option) in (question?.options)!.enumerated() {
            buttonOptions.append(UIButton())
            buttonOptions[index].titleLabel?.textColor = UIColor.black
            buttonOptions[index].titleLabel?.isEnabled = true
            buttonOptions[index].backgroundColor = UIColor.white
            buttonOptions[index].setTitle("\(index). \"" + option + "\"", for: UIControlState.normal)
            ibStackViewVertical.addArrangedSubview(buttonOptions[index])
        }
//        guard let option1 = question?.options[0] else { return }
//        ibButtonOption1.setTitle("A. \"" + option1 + "\"", for: .normal)
//        guard let option2 = question?.options[1] else { return }
//        ibButtonOption2.setTitle("B. \"" + option2 + "\"", for: .normal)
//        guard let option3 = question?.options[2] else { return }
//        ibButtonOption3.setTitle("C. \"" + option3 + "\"", for: .normal)
//        guard let option4 = question?.options[3] else { return }
//        ibButtonOption4.setTitle("D. \"" + option4 + "\"", for: .normal)
    }
    
    private func alertShow(title: String, text: String, currectAnswer: Bool) {
        let alertVC = UIAlertController(title: title, message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] action in
            if currectAnswer {
                self?.navigationController?.popViewController(animated: true)
            }
        }
        alertVC.addAction(okAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction private func buttonOptionsPress(_ sender: UIButton) {
        guard let ansvers = sender.currentTitle else { return }
        guard let indexAnsvers = question?.answers else { return }
        let ansversIsTrue: Bool
        switch indexAnsvers {
        case 1:
            ansversIsTrue = ansvers.first == "A"
        case 2:
            ansversIsTrue = ansvers.first == "B"
        case 3:
            ansversIsTrue = ansvers.first == "C"
        case 4:
            ansversIsTrue = ansvers.first == "D"
        default:
            ansversIsTrue = false
        }
        let textAlert = ansversIsTrue ? "Это правильный ответ!" : "Попробуйте еще раз"
        let titleAlert = ansversIsTrue ? "Поздравляем!" : "Упс!"
        alertShow(title: titleAlert, text: textAlert, currectAnswer: ansversIsTrue)
    }
    
}
