//
//  MainViewController.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 11/30/21.
//

import UIKit


// TODO Alert - New Game, Exit, Cancel - Done
// TODO Timer -
// TODO Type-in AppNameLabel - Done
// TODO Back-button Warning Game Cancel - Done
// TODO Continue Button  - Done
// TODO CONSTANTS!!! - Done




class MainViewController: UIViewController, SettingsViewControllerDelegate {

    

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resetButtonOutlet: BounceButton!
    @IBOutlet var inputButtons: [BounceButton]!
    

    var donutButtons = [ #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "black"), #imageLiteral(resourceName: "white"), #imageLiteral(resourceName: "purple"), #imageLiteral(resourceName: "green"), #imageLiteral(resourceName: "blue"), #imageLiteral(resourceName: "yellow"), #imageLiteral(resourceName: "red")]
    var numberButtons = [ #imageLiteral(resourceName: "0input"), #imageLiteral(resourceName: "1input"), #imageLiteral(resourceName: "2input"), #imageLiteral(resourceName: "3input"), #imageLiteral(resourceName: "4input"), #imageLiteral(resourceName: "5input"), #imageLiteral(resourceName: "6input"), #imageLiteral(resourceName: "7input")]
    var circles = ["🟠","⚫️","⚪️","🟣","🟢","🔵","🟡","🔴"]

    var lines: [Line]?
    var verifyButtonState = false
    var itemsLoaded = [Int]()

    var itmesLoadedCircles = [String]()

    var settingsVC = SettingsViewController()
    
    var toggleState = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.rowHeight = 60
        
        settingsVC.delegate = self
        settingsVC.toggleStateShared()
       
        
//        resetButtonOutlet.showsTouchWhenHighlighted = true
        
        fetchNewPattern()
    }
    
    
    
    func setButtonImage(_ index: Int){
        if index == 1{
            for i in 0..<inputButtons.count{
                inputButtons[i].setImage(donutButtons[i], for: .normal)
            }

        }else{
            for i in 0..<inputButtons.count{
                inputButtons[i].setImage(numberButtons[i], for: .normal)
            }


        }
    }
    
    
    func matchToNumbers(_ loadedItems: [Int]){
        for i in loadedItems {
            itmesLoadedCircles.append(circles[i])
        }
        print(itmesLoadedCircles)
    }
    
    
    
    func toggleStateData(_ index: Int) {
        setButtonImage(index)
        toggleState = index
    }
    
    
    
    func fetchNewPattern(){
        let urlString = Constants.urlString

        let url = URL(string: urlString)!

        APICaller().fetchData(url) { result in
            switch result{
            case .success(let items):
                self.itemsLoaded = items
                DispatchQueue.main.async {
                    GameManager().fetchPattern(items)
                }
                self.matchToNumbers(items)
            case .failure(_):
                break
            }
        }
    }
    
    
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        print("reset")
        fetchNewPattern()
        itmesLoadedCircles = []
        lines = GameManager.shared.reset()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func inputButtonTapped(_ sender: UIButton) {
        
        let number = sender.tag
        let result = GameManager.shared.running(number, verifyButtonState)
        lines = result.0
        if result.1.winner{
            print("WIIIIIIIIIINER")
            showWinnerAlert()
        }else if !result.1.ongoingGame && toggleState == 0{
            print("LOOOOOSER")
            showLooserAlertNumbers()
        }else if !result.1.ongoingGame && toggleState == 1{
            showLooserAlertCircles()
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


 //MARK:  Game Actions Alerts
extension MainViewController{

    func showWinnerAlert(){
    
        let alert = UIAlertController(title: "Winner", message: "Need to Celebrate 🎉", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel) { action in
            print("TAPPED DISMISS")
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func showLooserAlertNumbers(){
        
        print(itmesLoadedCircles)
        let alert = UIAlertController(title: "Loser", message: "The combination was \n \(itemsLoaded)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel) { action in
            print("TAPPED DISMISS")
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showLooserAlertCircles(){
        
        let alert = UIAlertController(title: "Loser", message: "The combination was \n \(itmesLoadedCircles)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel) { action in
            print("TAPPED DISMISS")
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

}




extension MainViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LineTableViewCell
        cell.backgroundColor = .clear
        lines = GameManager.shared.lines
        
        cell.viewModel = LineViewModel(lines: lines!, row: indexPath.row)
        
        return cell
    }
}



