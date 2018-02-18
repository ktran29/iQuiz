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
        
        let urlToRequest = UserDefaults.standard.value(forKey: "urlToRequest")
        
        if (urlToRequest != nil) {
            urlText.text = urlToRequest as! String
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func reloadData(_ sender: UIButton) {
        
        UserDefaults.standard.setValue(self.urlText.text!, forKey: "urlToRequest")
        
        let tableViewController = self.storyboard?.instantiateViewController(withIdentifier: "tableViewController") as! TableViewController
        tableViewController.url = self.urlText.text!
        tableViewController.downloadData()
        self.presentingViewController!.dismiss(animated: true, completion: nil)
    }

}
