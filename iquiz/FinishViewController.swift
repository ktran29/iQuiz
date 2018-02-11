//
//  FinishViewController.swift
//  iquiz
//
//  Created by Kevin Tran on 2/10/18.
//  Copyright © 2018 Kevin Tran. All rights reserved.
//

import UIKit

class FinishViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var numCorrect : Int?
    var numberOfQuestions : Int?
    var subject : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "\(subject!) Quiz"
        
        let score : Double = Double(numCorrect!) / Double(numberOfQuestions!)
        
        scoreLabel.text = "You got \(numCorrect!) of \(numberOfQuestions!) questions correct"
        
        if score == 1.0 {
            descriptionLabel.text = "Perfect!"
        } else if score >= 0.75 {
            descriptionLabel.text = "Almost!"
        } else if score >= 0.5 {
            descriptionLabel.text = "Better luck next time!"
        } else {
            descriptionLabel.text = "You suck!"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
