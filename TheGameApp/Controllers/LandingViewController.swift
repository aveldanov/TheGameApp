//
//  LandingViewController.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 11/30/21.
//

import UIKit
import CLTypingLabel

class LandingViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "🟠Anton Veldanov - 2021🟠"

// TO DELETE ONCE PRESENTED
//        titleLabel.text = ""
//        let titleText = "🟠The Game"
//        var charIndex = 0.0
//        for item in titleText{
//            Timer.scheduledTimer(withTimeInterval: 0.2*charIndex, repeats: false) { timer in
//                self.titleLabel.text?.append(item)
//            }
//            charIndex+=1
//        }
    }
}
