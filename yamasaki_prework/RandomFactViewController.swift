//
//  RandomFactViewController.swift
//  yamasaki_prework
//
//  Created by amanda on 5/13/18.
//  Copyright © 2018 amanda. All rights reserved.
//

import UIKit
import CoreData

class RandomFactViewController: UIViewController {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    @IBOutlet weak var random_fact: UILabel!
    
    
    var currentFactIndex : Int = 0
    var facts:[String] = ["Ada had an unusual upbringing for an aristocratic girl in the mid-1800s. At her mother's insistence, tutors taught her mathematics and science.", "In her notes, Ada described how codes could be created for the device to handle letters and symbols along with numbers. She also theorized a method for the engine to repeat a series of instructions, a process known as looping that computer programs use today.", "Ada also offered up other forward-thinking concepts in the article. For her work, Ada is often considered to be the first computer programmer."]
    
    func updateView(){
        random_fact.text = facts[currentFactIndex]
    }
    
    func pullFact(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "FunFacts")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let storedFact = data.value(forKey: "fact") as! String
                facts.contains(storedFact) ? print("no new facts uploaded") : facts.append(storedFact)
            }
            
        } catch {
            print("Failed")
        }
    }
    
    func randomFactIndex(){
        let arrSize : UInt32 = UInt32(facts.count)
        let ranIndex = Int(arc4random_uniform(arrSize))
        if (ranIndex != currentFactIndex){
            currentFactIndex = ranIndex
            updateView()
        } else {
            randomFactIndex()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pullFact()
    }
    
    @IBAction func random_button(_ sender: Any) {
        randomFactIndex()
    }
    
}
