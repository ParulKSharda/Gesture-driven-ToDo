//
//  ViewController.swift
//  Gesture-Driven-ToDo
//
//  Created by Parulsha on 9/1/17.
//  Copyright © 2017 Parulsha. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TableViewCellDelegate {

    var toDoItems = [ToDoItem]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addToDoTask: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var taskTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        styling()
        peekaboo()
        
        toDoItems.append(ToDoItem(text: "feed the cat"))
        toDoItems.append(ToDoItem(text: "buy eggs"))
        toDoItems.append(ToDoItem(text: "watch WWDC videos"))
        toDoItems.append(ToDoItem(text: "rule the Web"))
        toDoItems.append(ToDoItem(text: "buy a new iPhone"))
        toDoItems.append(ToDoItem(text: "darn holes in socks"))
        toDoItems.append(ToDoItem(text: "write this tutorial"))
        toDoItems.append(ToDoItem(text: "master Swift"))
        toDoItems.append(ToDoItem(text: "learn to draw"))
        toDoItems.append(ToDoItem(text: "get more exercise"))
        toDoItems.append(ToDoItem(text: "catch up with Mom"))
        toDoItems.append(ToDoItem(text: "get a hair cut"))
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.black
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 50.0
    }
    
    func styling() {
        let myGreen = UIColor(red: 75.00/255.00, green: 190.00/255.00, blue: 102.00/255.00, alpha: 1.00)
        taskTextField.layer.borderWidth = 2.0
        taskTextField.layer.borderColor = myGreen.cgColor
        addButton.backgroundColor = myGreen
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.titleLabel?.textAlignment = .center
    }
    
    func peekaboo() {
        addToDoTask.isHidden = false
        taskTextField.isHidden = true
        addButton.isHidden = true
    }
    
    @IBAction func addTask(_ sender: Any) {
        addToDoTask.isHidden = true
        taskTextField.isHidden = false
        addButton.isHidden = false
    }
    
    
    @IBAction func didSelectAdd(_ sender: Any) {
        peekaboo()
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath as IndexPath) as! TableViewCell
        cell.textLabel?.backgroundColor = UIColor.clear
        let item = toDoItems[indexPath.row]
        cell.textLabel?.text = item.text
        cell.selectionStyle = .none
        cell.delegate = self
        cell.toDoItem = item
        return cell
    }
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = toDoItems.count - 1
        let val = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 1.0, green: val, blue: 0.0, alpha: 1.0)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
        cell.backgroundColor = colorForIndex(index: indexPath.row)
    }
    
    func toDoItemDeleted(todoItem toDoItem: ToDoItem) {
        let index = (toDoItems as NSArray).index(of: toDoItem)
        if index == NSNotFound { return }
        toDoItems.remove(at: index)
        
        tableView.beginUpdates()
        let indexPathForRow = NSIndexPath(row: index, section: 0)
        tableView.deleteRows(at: [indexPathForRow as IndexPath], with: .fade)
        tableView.endUpdates()    
    }
}

