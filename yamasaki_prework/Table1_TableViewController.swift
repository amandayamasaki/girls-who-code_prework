//
//  Table1_TableViewController.swift
//  yamasaki_prework
//
//  Created by amanda on 5/13/18.
//  Copyright © 2018 amanda. All rights reserved.
//

import UIKit
import CoreData

class Table1_TableViewController: UITableViewController {
    // MARK: - Navigation
    
    var facts:[String] = []
    
    @IBOutlet var table1: UITableView!
    
    func pullFact(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FunFacts")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let storedFact = data.value(forKey: "fact") as! String
                facts.contains(storedFact) ? nil : facts.append(storedFact)
            }
        } catch {
            print("Failed")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        pullFact()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return facts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let row = indexPath.row
        cell.textLabel?.text = facts[row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete") { (action, indexPath) in
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fact = self.facts[indexPath.row]
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FunFacts")
            request.includesPropertyValues = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    let options : String = data.value(forKey: "fact")! as! String
                    options == fact ? context.delete(data) : nil
                }
                try context.save()
            } catch {
                print("Failed saving")
            }
            self.facts.remove(at: indexPath.row)
            self.table1.deleteRows(at: [indexPath], with: .fade)
        }
        return[delete]
    }

}
