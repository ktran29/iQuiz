//
//  QuestionViewController.swift
//  iquiz
//
//  Created by Kevin Tran on 2/10/18.
//  Copyright © 2018 Kevin Tran. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    
    var subject : SubjectItem?
    var selectedAnswer : Int = 0
    var question : String = ""
    var currentQuestion : Int?
    var numberOfQuestions : Int?
    var numCorrect : Int?
    var answerSelected : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "\((subject?.subject)!) Quiz"
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleGesture(gesture:)))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        question = (subject?.questions[currentQuestion!].question)!
        questionText.text = question
        setAnswers()
        resetButtonColors()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func answerOnClick(_ sender: UIButton) {
        resetButtonColors()
        sender.setTitleColor(UIColor.black, for: .normal)
        submitButton.isEnabled = true
        selectedAnswer = sender.tag
        answerSelected = true
    }
    
    func setAnswers() {
        answerButton1.setTitle(subject?.questions[0].answers[0], for: .normal)
        answerButton2.setTitle(subject?.questions[0].answers[1], for: .normal)
        answerButton3.setTitle(subject?.questions[0].answers[2], for: .normal)
        answerButton4.setTitle(subject?.questions[0].answers[3], for: .normal)
    }
    
    func resetButtonColors() {
        answerButton1.setTitleColor(UIColor.lightGray, for: .normal)
        answerButton2.setTitleColor(UIColor.lightGray, for: .normal)
        answerButton3.setTitleColor(UIColor.lightGray, for: .normal)
        answerButton4.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.left {
            if answerSelected {
                performSegue(withIdentifier: "AnswerSegue", sender: self)
            }
        } else if gesture.direction == UISwipeGestureRecognizerDirection.right {
            performSegue(withIdentifier: "QuestionToMain", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AnswerSegue" {
            let answerView = segue.destination as! AnswerViewController
            answerView.subject = self.subject
            answerView.selectedAnswer = self.selectedAnswer
            answerView.question = self.question
            answerView.currentQuestion = self.currentQuestion
            answerView.numberOfQuestions = self.numberOfQuestions
            answerView.numCorrect = self.numCorrect
        }
    }

}
