//
//  QuizViewController.swift
//  yamasaki_prework
//
//  Created by amanda on 5/11/18.
//  Copyright © 2018 amanda. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    
    @IBOutlet weak var question: UILabel!
    @IBOutlet weak var answer_0: UIButton!
    @IBOutlet weak var answer_1: UIButton!
    @IBOutlet weak var answer_2: UIButton!
    @IBOutlet weak var answer_3: UIButton!
    @IBOutlet weak var score: UILabel!
    
    @IBAction func answer_0(_ sender: Any) {
        checkA(guess:0)
    }
    @IBAction func answer_1(_ sender: Any) {
        checkA(guess:1)
    }
    @IBAction func answer_2(_ sender: Any) {
        checkA(guess:2)
    }
    @IBAction func answer_3(_ sender: Any) {
        checkA(guess:3)
    }
    
    
    struct Question {
        let question: String
        let answers: [String]
        let correctAnswer: Int
    }

    var questions: [Question] = [
        Question(
            question: "Ada Lovelace is known as the first...",
            answers: ["computer programmer", "scientist", "tailor", "electrician"],
            correctAnswer: 0),
        Question(
            question: "She published the first...",
            answers: ["book", "game", "algorithm", "poem"],
            correctAnswer: 2)
    ]

    var currentQuestion: Question?
    var c_qp: Int = 0
    var correct: Int = 0

    func setQuestion(){
        question.text = currentQuestion!.question
        score.text = String(correct)
        answer_0.setTitle(currentQuestion!.answers[0], for: .normal)
        answer_1.setTitle(currentQuestion!.answers[1], for: .normal)
        answer_2.setTitle(currentQuestion!.answers[2], for: .normal)
        answer_3.setTitle(currentQuestion!.answers[3], for: .normal)
    }
    
    func loadNextQuestion(){
        if(c_qp + 1 < questions.count){
            c_qp += 1
            currentQuestion = questions[c_qp]
            setQuestion()
        } else {
            performSegue(withIdentifier: "showRes", sender: self)
        }
    }
    
    func checkA(guess: Int){
        if(guess == currentQuestion!.correctAnswer){
            correct += 1
        }
        loadNextQuestion();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestion = questions[0]
        setQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "showRes") {
            let vc = segue.destination as! QuizResViewController
            vc.correct = correct
            vc.total = questions.count
        }
    }
}
