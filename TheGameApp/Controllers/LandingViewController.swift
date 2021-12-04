//
//  LandingViewController.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 11/30/21.
//

import UIKit

class LandingViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = ""
        let titleText = "🟠The Game"
        var charIndex = 0.0
        for item in titleText{
            Timer.scheduledTimer(withTimeInterval: 0.2*charIndex, repeats: false) { timer in
                self.titleLabel.text?.append(item)
            }
            charIndex+=1
        }
        
    }
    

}
