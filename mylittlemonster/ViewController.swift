//
//  ViewController.swift
//  mylittlemonster
//
//  Created by roux g. buciu on 2016-07-08.
//  Copyright © 2016 ACME Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: MonsterImg!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    @IBOutlet weak var skullPenalty1Img: UIImageView!
    @IBOutlet weak var skullPenalty2Img: UIImageView!
    @IBOutlet weak var skullPenalty3Img: UIImageView!
    
    let DIM_ALPHA: CGFloat = 0.2
    let OPAQUE: CGFloat = 1.0
    let MAX_PENALTIES = 3
    
    var currentPenalties = 0
    var timer: NSTimer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        skullPenalty1Img.alpha = DIM_ALPHA
        skullPenalty2Img.alpha = DIM_ALPHA
        skullPenalty3Img.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        startTimer()
    
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
        print("Item dropped on character")
    }
    
    func startTimer() {
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
    }
    
    func changeGameState() {
        
        currentPenalties += 1
        
        if currentPenalties == 1 {
            skullPenalty1Img.alpha = OPAQUE
            skullPenalty2Img.alpha = DIM_ALPHA
        
        } else if currentPenalties == 2 {
            skullPenalty2Img.alpha = OPAQUE
            skullPenalty3Img.alpha = DIM_ALPHA
        
        } else if currentPenalties <= 3 {
            skullPenalty3Img.alpha = OPAQUE
            
        } else {            // just safety
            skullPenalty1Img.alpha = DIM_ALPHA
            skullPenalty2Img.alpha = DIM_ALPHA
            skullPenalty3Img.alpha = DIM_ALPHA
            
        }
        
        if currentPenalties >= MAX_PENALTIES {
            gameOver()
        }
    }
    
    func gameOver() {
        
        timer.invalidate()
        monsterImg.playDeathAnimation()
        
    }
    
 
}

