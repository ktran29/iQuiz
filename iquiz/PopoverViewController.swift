//
//  PopoverViewController.swift
//  iquiz
//
//  Created by Kevin Tran on 2/17/18.
//  Copyright © 2018 Kevin Tran. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController {
    
    @IBOutlet weak var urlText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkURL(_ sender: UIButton) {
        let tableViewController = storyboard?.instantiateViewController(withIdentifier: "tableViewController") as! TableViewController
        AppData.shared.urlToRequest = urlText.text!
        tableViewController.viewDidLoad()
    
        
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }

}
