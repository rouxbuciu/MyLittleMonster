//
//  ViewController.swift
//  mylittlemonster
//
//  Created by roux g. buciu on 2016-07-08.
//  Copyright © 2016 ACME Labs. All rights reserved.
//

import UIKit
import AVFoundation

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
    var monsterHappy = false
    var currentItem: UInt32 = 0 // the item that the monster desires
    
    var musicPlayer: AVAudioPlayer!
    var sfxBite: AVAudioPlayer!
    var sfxHeart: AVAudioPlayer!
    var sfxDeath: AVAudioPlayer!
    var sfxSkull: AVAudioPlayer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        foodImg.dropTarget = monsterImg
        heartImg.dropTarget = monsterImg
        
        skullPenalty1Img.alpha = DIM_ALPHA
        skullPenalty2Img.alpha = DIM_ALPHA
        skullPenalty3Img.alpha = DIM_ALPHA
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ViewController.itemDroppedOnCharacter(_:)), name: "onTargetDropped", object: nil)
        
        do {
            try musicPlayer = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("cave-music", ofType: "mp3")!))
            
            try sfxBite = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("biteSound", ofType: "wav")!))
            
            try sfxDeath = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("deathSound", ofType: "wav")!))
           
            try sfxHeart = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("heartSound", ofType: "wav")!))
            
            try sfxSkull = AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("skullSound", ofType: "wav")!))
            
            musicPlayer.prepareToPlay()
            musicPlayer.play()
            
            sfxBite.prepareToPlay()
            sfxSkull.prepareToPlay()
            sfxDeath.prepareToPlay()
            sfxHeart.prepareToPlay()
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        
        startTimer()
    
    }
    
    func itemDroppedOnCharacter(notif: AnyObject) {
    
        monsterHappy = true
        startTimer()
        
        foodImg.alpha = DIM_ALPHA
        foodImg.userInteractionEnabled = false
        heartImg.alpha = DIM_ALPHA
        heartImg.userInteractionEnabled = false
        
        if currentItem == 0 {
            sfxHeart.play()
        } else {
            sfxBite.play()
        }
    }
    
    func startTimer() {
        
        if timer != nil {
            timer.invalidate()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: "changeGameState", userInfo: nil, repeats: true)
        
    }
    
    func changeGameState() {
        
        if !monsterHappy {
            
            currentPenalties += 1
            sfxSkull.play()
            
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
        
        let rand = arc4random_uniform(2)
        
        if rand == 0 {
            foodImg.alpha = DIM_ALPHA
            foodImg.userInteractionEnabled = false
            
            heartImg.alpha = OPAQUE
            heartImg.userInteractionEnabled = true
        } else {
            heartImg.alpha = DIM_ALPHA
            heartImg.userInteractionEnabled = false
            
            foodImg.alpha = OPAQUE
            foodImg.userInteractionEnabled = true
        }
        
        currentItem = rand
        monsterHappy = false
    }
    
    func gameOver() {
        
        timer.invalidate()
        monsterImg.playDeathAnimation()
        sfxDeath.play()
        
    }
    
 
}

