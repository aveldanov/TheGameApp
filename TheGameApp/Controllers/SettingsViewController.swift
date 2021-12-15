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
    
    //MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        toggleOutlet.selectedSegmentIndex = defaults.integer(forKey: Constants.gameSettingsState)
    }
    
     //MARK: Actions
    @IBAction func toggleStateTapped(_ sender: UISegmentedControl) {
        toggleState = sender.selectedSegmentIndex
        defaults.set(toggleState, forKey: Constants.gameSettingsState)
    }
    
    func toggleStateShared(){
        delegate?.toggleStateData(defaults.integer(forKey: Constants.gameSettingsState))
    }
}
