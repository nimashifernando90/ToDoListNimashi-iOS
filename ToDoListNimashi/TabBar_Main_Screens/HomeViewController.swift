//
//  HomeViewController.swift
//  ToDoListNimashi
//
//  Created by Nimashi Fernando on 3/5/19.
//  Copyright © 2019 Nimashi Fernando. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var toDoListTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var tasksList: [Task] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //Hide Empty Rows
        toDoListTableView.tableFooterView = UIView()

    }

    override func viewWillAppear(_ animated: Bool) {
        
        //Load all tasks in ToDoList
        getAllTasks()
    }
    

    //Getting all tasks in ToDoList
    func getAllTasks() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Task")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            tasksList = result as! [Task]
            /*for data in result as! [NSManagedObject] {
                print(data.value(forKey: "taskName") as! String)
            }*/
            toDoListTableView.reloadData()
            
        } catch {
            
            print("Get Tasks Failed")
        }
    }
    
    
    // MARK: - TableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tasksList.count
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 75
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        //define cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "toDoCell", for: indexPath) as! ToDoTableViewCell
        let task = tasksList[indexPath.row]
        
        //Name
        if let taskName = task.taskName {
            cell.taskNameLabel?.text = taskName
        }
        //Date And Time
        if let taskDateTime = task.taskDateTime {
            cell.taskDateAndTimeLabel?.text = taskDateTime
        }
        
        //Task Completed Status
        let taskCompletedStaus = task.taskCompletedStatus
        if taskCompletedStaus{
            
            cell.taskStatusView.backgroundColor = Constants.ColourCodes.colorPriorityO1
            
        }else{
            
            cell.taskStatusView.backgroundColor = UIColor.white
            
        }
        
        //Task Priority
        let taskPriority = task.taskPriority
        switch taskPriority {
        case 0:
            cell.taskPriorityStatusView.backgroundColor = UIColor.white
            
        case 1:
            cell.taskPriorityStatusView.backgroundColor = Constants.ColourCodes.colorPriorityO1
            
        case 2:
            cell.taskPriorityStatusView.backgroundColor = Constants.ColourCodes.colorPriorityO2
            
        case 3:
            cell.taskPriorityStatusView.backgroundColor = Constants.ColourCodes.colorPriorityO3
            
        default:
            cell.taskPriorityStatusView.backgroundColor = UIColor.white
            break
        }
       
        return cell
    }
    
}

