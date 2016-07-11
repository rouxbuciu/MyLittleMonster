//
//  ViewController.swift
//  mylittlemonster
//
//  Created by roux g. buciu on 2016-07-08.
//  Copyright © 2016 ACME Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var monsterImg: UIImageView!
    @IBOutlet weak var foodImg: DragImg!
    @IBOutlet weak var heartImg: DragImg!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var imgArray = [UIImage]()
        var x = 1
        
        while x <= 4 {
            let img = UIImage(named: "idle\(x).png")
            imgArray.append(img!)
            x += 1
        }
        
        monsterImg.animationImages = imgArray
        monsterImg.animationDuration = 0.8
        monsterImg.animationRepeatCount = 0
        monsterImg.startAnimating()
    
    }
    
    
 
}

