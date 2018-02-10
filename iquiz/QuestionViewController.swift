//
//  QuestionViewController.swift
//  iquiz
//
//  Created by Kevin Tran on 2/10/18.
//  Copyright © 2018 Kevin Tran. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    var subject : SubjectItem?
    var selectedAnswer : Int = 0
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = subject?.subject
        questionText.text = subject?.questions[0].question
        setAnswers()
        resetButtonColors()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func answerOnClick(_ sender: UIButton) {
        resetButtonColors()
        sender.setTitleColor(UIColor.blue, for: .normal)
        
        submitButton.isEnabled = true
        selectedAnswer = sender.tag
    }
    
    func setAnswers() {
        answerButton1.setTitle(subject?.questions[0].answers[0], for: .normal)
        answerButton2.setTitle(subject?.questions[0].answers[1], for: .normal)
        answerButton3.setTitle(subject?.questions[0].answers[2], for: .normal)
        answerButton4.setTitle(subject?.questions[0].answers[3], for: .normal)
    }
    
    func resetButtonColors() {
        answerButton1.setTitleColor(UIColor.gray, for: .normal)
        answerButton2.setTitleColor(UIColor.gray, for: .normal)
        answerButton3.setTitleColor(UIColor.gray, for: .normal)
        answerButton4.setTitleColor(UIColor.gray, for: .normal)
    }

}
