//
//  SubjectItem.swift
//  iquiz
//
//  Created by Kevin Tran on 2/9/18.
//  Copyright © 2018 Kevin Tran. All rights reserved.
//

import UIKit

class SubjectItem: NSObject {

    var subject : String = ""
    var descriptionText : String = ""
    var icon : String = ""
    var questions : [QuestionObject] = []
    
    init(_ subject : String, _ description : String, _ icon : String) {
        self.subject = subject
        descriptionText = description
        self.icon = icon
    }
    
}
