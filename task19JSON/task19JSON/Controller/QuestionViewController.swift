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
            buttonOptions[index].setTitleColor(.white, for: .normal)
            buttonOptions[index].titleLabel?.isHidden = false
            buttonOptions[index].setTitle("\(index + 1). \"" + option + "\"", for: UIControlState.normal)
            buttonOptions[index].addTarget(self, action: #selector(buttonOptionsPress(_:)), for: UIControlEvents.allTouchEvents)
            ibStackViewVertical.addArrangedSubview(buttonOptions[index])
        }
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
    
    @objc private func buttonOptionsPress(_ sender: UIButton) {
        guard let ansvers = sender.currentTitle else { return }
        guard let indexAnsvers = question?.answers else { return }
        let ansversIsTrue = ansvers.first == String(indexAnsvers).first
        let textAlert = ansversIsTrue ? "Это правильный ответ!" : "Попробуйте еще раз"
        let titleAlert = ansversIsTrue ? "Поздравляем!" : "Упс!"
        alertShow(title: titleAlert, text: textAlert, currectAnswer: ansversIsTrue)
    }
    
}
