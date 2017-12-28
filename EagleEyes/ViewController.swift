//
//  ViewController.swift
//  EagleEyes
//
//  Created by BaiJie on 12/27/17.
//  Copyright © 2017 BaiJie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    var currentValue: Int = 50
    var targetValue: Int = 0
    var diffValue: Int = 0
    var score = 0
    var round = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewgame()
    }
    
    @IBAction func startNewgame() {
        scoreLabel.text = "0"
        roundLabel.text = "0"
        currentValue = 50
        score = 0
        round = 0
        genTargetvalue()
    }
    
    
    func genTargetvalue(){
        targetValue = 1 + Int(arc4random_uniform(100))
        slider.value = Float(currentValue)
        targetLabel.text = String(targetValue)
    }

    func calcDiff(){
        diffValue = 100 - (currentValue - targetValue) * (currentValue - targetValue)
        if diffValue < 0 {
            diffValue = 0
        }
        score += diffValue
        round += 1
        scoreLabel.text = String(score)
        roundLabel.text = String(round)
        if score > 1000 {
            showCongrat()
        }
    }
    
    func showCongrat(){
        let alert = UIAlertController(title:"Congradulations!", message:"You've reached 1k score in \(round) rounds", preferredStyle: .alert)
        let action =  UIAlertAction(title:"Play Again", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        score = 0
        round = 0
        viewDidLoad()
    }
    
    
    @IBAction func showAlert(){
        var alertTitle : String = "Bingo"
        calcDiff()
        
        if diffValue == 100 {
            alertTitle = "Home Run!!!"
        } else if diffValue >= 90 {
            alertTitle = "Perfect!!!"
        } else if diffValue >= 60 {
            alertTitle = "Welldone!!!"
        } else if diffValue > 0 {
            alertTitle = "Not Bad!!!"
        } else {
            alertTitle = "Wake Up!!!"
        }
        
        let alert = UIAlertController(title: alertTitle, message:"the slider value is \(currentValue) " + "\nthe target value is \(targetValue) " + "\nScore of this round is \(diffValue) ", preferredStyle: .alert)
        let action1 = UIAlertAction(title:"Back", style: .default, handler: {
            action in self.genTargetvalue()
        })
        
        alert.addAction(action1)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sliderMoved(slider: UISlider){
        currentValue = lroundf(slider.value)
    }

}

