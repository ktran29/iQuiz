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

        let math = SubjectItem("Mathematics", "This quiz is about math", "math")
        let mathQuestion = QuestionObject(2, "What is 1 + 1?", ["1", "2", "3", "4"])
        math.questions = [mathQuestion]
        
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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
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
        subject = indexPath.row
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let questionView = segue.destination as! QuestionViewController
        questionView.subject = subjects[subject]
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
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
