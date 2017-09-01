//
//  ToDoItem.swift
//  Gesture-Driven-ToDo
//
//  Created by Parulsha on 9/1/17.
//  Copyright © 2017 Parulsha. All rights reserved.
//

import Foundation

class ToDoItem {
    
    var text: String
    var completed: Bool
    
    init(text: String) {
        self.text = text
        self.completed = false
    }
}
