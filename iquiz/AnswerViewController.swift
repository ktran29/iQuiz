//
//  AnswerViewController.swift
//  iquiz
//
//  Created by Kevin Tran on 2/10/18.
//  Copyright © 2018 Kevin Tran. All rights reserved.
//

import UIKit

class AnswerViewController: UIViewController {

    @IBOutlet weak var questionText: UILabel!
    @IBOutlet weak var answerButton1: UIButton!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var answerButton4: UIButton!
    
    var subject : SubjectItem?
    var selectedAnswer : Int?
    var question : String?
    var currentQuestion : Int?
    var numberOfQuestions : Int?
    var numCorrect : Int?
    
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
        
        let answer = (subject?.questions[currentQuestion!].correctIndex)! - 1
        questionText.text = question
        setAnswers()
        setButtonColors()
        
        if selectedAnswer != answer {
            self.view.viewWithTag(selectedAnswer! + 1)?.backgroundColor = UIColor.red
        } else {
            numCorrect! += 1
        }
        self.view.viewWithTag(answer + 1)?.backgroundColor = UIColor.green
        currentQuestion! += 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setAnswers() {
        answerButton1.setTitle(subject?.questions[0].answers[0], for: .normal)
        answerButton2.setTitle(subject?.questions[0].answers[1], for: .normal)
        answerButton3.setTitle(subject?.questions[0].answers[2], for: .normal)
        answerButton4.setTitle(subject?.questions[0].answers[3], for: .normal)
    }
    
    func setButtonColors() {
        answerButton1.setTitleColor(UIColor.black, for: .normal)
        answerButton2.setTitleColor(UIColor.black, for: .normal)
        answerButton3.setTitleColor(UIColor.black, for: .normal)
        answerButton4.setTitleColor(UIColor.black, for: .normal)
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        if currentQuestion! >= numberOfQuestions! {
            performSegue(withIdentifier: "FinishSegue", sender: self)
        } else {
            performSegue(withIdentifier: "QuestionSegue", sender: self)
        }
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.left {
            if currentQuestion! >= numberOfQuestions! {
                performSegue(withIdentifier: "FinishSegue", sender: self)
            } else {
                performSegue(withIdentifier: "QuestionSegue", sender: self)
            }
        } else if gesture.direction == UISwipeGestureRecognizerDirection.right {
            performSegue(withIdentifier: "AnswerToMain", sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FinishSegue" {
            let finishView = segue.destination as! FinishViewController
            finishView.numCorrect = self.numCorrect
            finishView.numberOfQuestions = self.numberOfQuestions
            finishView.subject = self.subject?.subject
        } else if segue.identifier == "QuestionSegue" {
            let questionView = segue.destination as! QuestionViewController
            questionView.subject = self.subject
            questionView.currentQuestion = self.currentQuestion!
            questionView.numberOfQuestions = self.numberOfQuestions
            questionView.numCorrect = self.numCorrect
        }
    }
    

}
