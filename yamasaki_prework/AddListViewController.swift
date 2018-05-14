//
//  AddListViewController.swift
//  yamasaki_prework
//
//  Created by amanda on 5/13/18.
//  Copyright © 2018 amanda. All rights reserved.
//

import UIKit
import CoreData

class AddListViewController: UIViewController {
    
    // MARK: - Navigation
    @IBOutlet weak var input_text: UITextField!
    @IBOutlet weak var submit_button: UIButton!
    @IBOutlet weak var res_text: UILabel!
    
    
    func addFact(fact:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FunFacts", in: context)
        let newFact = NSManagedObject(entity: entity!, insertInto: context)
        
        newFact.setValue(fact, forKey: "fact")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
    }
    
    @IBAction func submit_button(_ sender: Any) {
        let userInput : String = input_text.text!
        addFact(fact:userInput)
        input_text.text = ""
        res_text.text = "Thanks! Add Another!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
