//
//  QuestionObject.swift
//  iquiz
//
//  Created by Kevin Tran on 2/10/18.
//  Copyright © 2018 Kevin Tran. All rights reserved.
//

import UIKit

class QuestionObject: NSObject {

    var correctIndex : Int = 0
    var question : String = ""
    var answers : [String] = []
    
    init(_ correctIndex : Int, _ question : String, _ answers : [String]) {
        self.correctIndex = correctIndex
        self.question = question
        self.answers = answers
    }
    
}
