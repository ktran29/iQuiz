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
        self.downloadData(urlToRequest: "https://tednewardsandbox.site44.com/questions.json")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func downloadData(urlToRequest: String) -> Void {
        let requestURL : NSURL = NSURL(string: urlToRequest)!
        let urlRequest : NSMutableURLRequest = NSMutableURLRequest(url: requestURL as URL)
        
        URLSession.shared.dataTask(with: urlRequest as URLRequest, completionHandler: {(data, response, error) -> Void in
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: []) as! NSArray
            
            if (jsonData != nil) {
                
                for index in 0...jsonData!.count - 1 {
                    let subjectData = jsonData![index] as! NSDictionary
                    let title = subjectData.value(forKey: "title") as! String
                    let desc = subjectData.value(forKey: "desc") as! String
                    let subjectObject = SubjectItem(title, desc, "icon\(index)")
                    let questionData = subjectData.value(forKey: "questions") as! NSArray
                    var questions : [QuestionObject] = []
                    
                    for questionIndex in 0...questionData.count - 1{
                        let question = questionData[questionIndex] as! NSDictionary
                        let answer = Int(question.value(forKey: "answer") as! String)
                        let text = question.value(forKey: "text") as! String
                        let answers = question.value(forKey: "answers") as! [String]
                        let questionObject = QuestionObject(answer!, text, answers)
                        questions.append(questionObject)
                    }
                    subjectObject.questions = questions
                    self.subjects.append(subjectObject)
                }
            } else {
                let math = SubjectItem("Mathematics", "This quiz is about math", "icon2")
                let mathQuestion = QuestionObject(1, "What is 1 + 1?", ["1", "2", "3", "4"])
                let mathQuestion2 = QuestionObject(2, "What is 1 + 2?", ["1", "2", "3", "4"])
                let mathQuestion3 = QuestionObject(3, "What is 1 + 3?", ["1", "2", "3", "4"])
                math.questions = [mathQuestion, mathQuestion2, mathQuestion3]
                
                let marvel = SubjectItem("Marvel Super Heroes", "This quiz is about Marvel superheroes", "icon1")
                marvel.questions = [mathQuestion]
                let science = SubjectItem("Science", "This quiz is about science", "icon0")
                science.questions = [mathQuestion]
                
                self.subjects = [math, marvel, science]
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }).resume()
    }

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
