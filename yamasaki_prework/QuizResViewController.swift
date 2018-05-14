//
//  QuizResViewController.swift
//  yamasaki_prework
//
//  Created by amanda on 5/11/18.
//  Copyright © 2018 amanda. All rights reserved.
//

import UIKit

class QuizResViewController: UIViewController {
    // MARK: - Navigation
    
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var score_percent: UILabel!
    
    var correct = 0
    var total = 0
    
    func updateScore(tot:Int, corr:Int){
        let percentagecorrect = (corr * 200 + corr)/(2 * corr)
        score.text = String(corr)
        score_percent.text = String(percentagecorrect) + " %"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateScore(tot:total, corr:correct)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
