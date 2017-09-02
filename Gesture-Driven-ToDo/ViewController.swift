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
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var labelButtonContainer: UIStackView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        styling()
        peekaboo()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorStyle = .none
    }
    
    func styling() {
        let myGreen = UIColor(red: 75.00/255.00, green: 190.00/255.00, blue: 102.00/255.00, alpha: 1.00)
        taskTextField.sizeToFit()
        taskTextField.layer.borderWidth = 2.0
        taskTextField.layer.borderColor = myGreen.cgColor
        taskTextField.clearButtonMode = .whileEditing
        addButton.backgroundColor = myGreen
        addButton.setTitleColor(UIColor.white, for: .normal)
        addButton.titleLabel?.textAlignment = .center
    }
    
    func peekaboo() {
        addToDoTask.isHidden = false
        labelButtonContainer.isHidden = true
    }
    
    @IBAction func addTask(_ sender: Any) {
        addToDoTask.isHidden = true
        labelButtonContainer.isHidden = false
    }
    
    
    @IBAction func didSelectAdd(_ sender: Any) {
        if let task = taskTextField.text {
            if task.characters.count == 0 {
                taskTextField.placeholder = "Please enter valid data"
            }
            else {
               taskTextField.placeholder = "ex: Buy Chocolate"
               addTaskToTheList(task: task)
               clearField()
               peekaboo()
        }
    }
    }
    
    
    @IBAction func cancelClicked(_ sender: Any) {
        clearField()
        peekaboo()
    }
    
    func clearField() {
        taskTextField.text = ""
        taskTextField.resignFirstResponder()
    }
    
    func addTaskToTheList(task: String) {
        toDoItems.append(ToDoItem(text: task))
        tableView.reloadData()
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if toDoItems.count == 0 {
            tableView.backgroundView = UIImageView(image: UIImage(named: "No-task"))
        }
        else {
            tableView.backgroundView?.isHidden = true
        }
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

