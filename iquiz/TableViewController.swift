//
//  TableViewController.swift
//  iquiz
//
//  Created by Kevin Tran on 2/9/18.
//  Copyright © 2018 Kevin Tran. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var subjects : [SubjectItem] = []
    var subject : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

        let math = SubjectItem("Mathematics", "This quiz is about math", "math")
        let mathQuestion = QuestionObject(1, "What is 1 + 1?", ["1", "2", "3", "4"])
        let mathQuestion2 = QuestionObject(2, "What is 1 + 2?", ["1", "2", "3", "4"])
        let mathQuestion3 = QuestionObject(3, "What is 1 + 3?", ["1", "2", "3", "4"])
        math.questions = [mathQuestion, mathQuestion2, mathQuestion3]
        
        let marvel = SubjectItem("Marvel Super Heroes", "This quiz is about Marvel superheroes", "marvel")
        marvel.questions = [mathQuestion]
        let science = SubjectItem("Science", "This quiz is about science", "science")
        science.questions = [mathQuestion]
        
        subjects = [math, marvel, science]
    
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCell", for: indexPath) as! TableViewCell
        
        let subjectItem = self.subjects[indexPath.row]
        cell.subjectText.text = subjectItem.subject
        cell.descriptionText.text = subjectItem.descriptionText
        cell.imageObject.image = UIImage(named: subjectItem.icon)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.subject = indexPath.row
        let questionView = self.storyboard?.instantiateViewController(withIdentifier: "QuestionView") as! QuestionViewController
        questionView.subject = subjects[self.subject]
        questionView.currentQuestion = 0
        questionView.numberOfQuestions = subjects[self.subject].questions.count
        questionView.numCorrect = 0
        self.navigationController?.pushViewController(questionView, animated: true)
    }

    @IBAction func settingsClicked(_ sender: UIButton) {
        let alertVC = UIAlertController(title: "Settings go here",
                                        message: "",
                                        preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            alertVC.dismiss(animated: true)
        }))
        self.present(alertVC, animated: true)
    }
    
}
