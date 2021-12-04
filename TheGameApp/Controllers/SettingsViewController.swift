//
//  SettingsViewController.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 11/30/21.
//

import UIKit



protocol SettingsViewControllerDelegate: AnyObject{
    
    func toggleStateData(_ index:Int)
}

var toggleState = 0

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var toggleOutlet: UISegmentedControl!
    weak var delegate: SettingsViewControllerDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        toggleOutlet.selectedSegmentIndex = toggleState
    }
    
    @IBAction func toggleStateTapped(_ sender: UISegmentedControl) {
        toggleState = sender.selectedSegmentIndex
    }
    
    
    
    func toggleStateShared(){
        delegate?.toggleStateData(toggleState)
    }
    

}
