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
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var toggleOutlet: UISegmentedControl!
    weak var delegate: SettingsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
//        toggleOutlet.selectedSegmentIndex = toggleState
        toggleOutlet.selectedSegmentIndex = defaults.integer(forKey: Constants.gameSettingsState)
    }
    
    @IBAction func toggleStateTapped(_ sender: UISegmentedControl) {
        toggleState = sender.selectedSegmentIndex
        defaults.set(toggleState, forKey: Constants.gameSettingsState)
    }
    
    
    
    func toggleStateShared(){
        delegate?.toggleStateData(defaults.integer(forKey: Constants.gameSettingsState))
    }
    

}
