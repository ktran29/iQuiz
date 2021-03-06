//
//  TableViewController.swift
//  iquiz
//
//  Created by Kevin Tran on 2/9/18.
//  Copyright © 2018 Kevin Tran. All rights reserved.
//

import UIKit
import SystemConfiguration

class TableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    let defaults = UserDefaults.standard
    var refresher = UIRefreshControl()
    var url = "https://tednewardsandbox.site44.com/questions.json"
    var subjects : [SubjectItem] = []
    var subject : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        defaults.register(defaults: [String : Any]())
        
        refresher.addTarget(self, action: #selector(refreshTable), for: UIControlEvents.valueChanged)
        tableView.addSubview(refresher)
        
        if !self.isConnectedToNetwork() {
            self.notifyUser("Network is currently unavailable")
        }
        
        self.downloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func downloadData() -> Void {
        
        // checks to see if user has a stored URL
        if defaults.value(forKey: "urlToRequest") != nil {
            url = defaults.value(forKey: "urlToRequest") as! String
        }
        let urlString = URL(string: url)
        let config = URLSessionConfiguration.default
        let session = URLSession.init(configuration: config, delegate: nil, delegateQueue: OperationQueue.current)
        
        let task = session.dataTask(with: urlString!) { (data, response, error) in
            var jsonData : NSArray = []
            let fileManager = FileManager.default
            let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("questions.json")
            let content = NSData(contentsOf: path)
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    do {
                        jsonData = (try JSONSerialization.jsonObject(with: data!, options: []) as? NSArray)!
                        do {
                            try jsonData.write(to: path)
                        } catch {
                            if content != nil {
                                jsonData = NSArray(contentsOf: path)!
                            }
                        }
                    } catch {
                        self.notifyUser("Unable to write to file")
                    }
                } else {
                    if let error = error {
                        self.notifyUser(error.localizedDescription)
                    } else {
                        self.notifyUser("Request not successful. Status code: \(response.statusCode)")
                    }
                }
            } else if let error = error {
                self.notifyUser(error.localizedDescription)
            }
            
            if (jsonData.count > 0) {
                for index in 0...jsonData.count - 1 {
                    let subjectData = jsonData[index] as! NSDictionary
                    let title = subjectData.value(forKey: "title") as! String
                    let desc = subjectData.value(forKey: "desc") as! String
                    let subjectObject = SubjectItem(title, desc, "icon\(index)")
                    let questionData = subjectData.value(forKey: "questions") as! NSArray
                    var questions : [QuestionObject] = []
                    
                    for questionIndex in 0...questionData.count - 1 {
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
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            // terminates all outstanding tasks i.e. failed HTTP requests
            session.invalidateAndCancel()
        }
        
        task.resume()
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
    
    @IBAction func settingsClicked(_ sender: UIBarButtonItem) {
        
        let popoverVC = self.storyboard?.instantiateViewController(withIdentifier: "popoverViewController") as! PopoverViewController
        popoverVC.modalPresentationStyle = UIModalPresentationStyle.popover
        popoverVC.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: 150)
        let popover = popoverVC.popoverPresentationController
        popover!.delegate = self
        popover!.barButtonItem = sender
        self.present(popoverVC, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    @objc func refreshTable() {
        subjects = []
        self.refresher.endRefreshing()
        if !isConnectedToNetwork() {
            self.notifyUser("Network is currently unavailable")
        } else {
            self.downloadData()
        }
    }
    
    // checks network connection, found here: https://stackoverflow.com/questions/39558868/check-internet-connection-ios-10
    func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
        
    }
    
    func notifyUser(_ message : String) {
        let alert = UIAlertController(title: "Notification",
                                      message: message,
            preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
