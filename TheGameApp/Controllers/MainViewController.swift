//
//  MainViewController.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 11/30/21.
//

import UIKit


// TODO Alert - New Game, Exit, Cancel - Done
// TODO Timer - nah
// TODO Type-in AppNameLabel - Done
// TODO Back-button Warning Game Cancel - Done
// TODO Continue Button  - Done
// TODO CONSTANTS!!! - Done


class MainViewController: UIViewController, SettingsViewControllerDelegate {
    
    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resetButtonOutlet: BounceButton!
    @IBOutlet var inputButtons: [BounceButton]!
    
    var donutButtons = [ #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "black"), #imageLiteral(resourceName: "white"), #imageLiteral(resourceName: "purple"), #imageLiteral(resourceName: "green"), #imageLiteral(resourceName: "blue"), #imageLiteral(resourceName: "yellow"), #imageLiteral(resourceName: "red")]
    var numberButtons = [ #imageLiteral(resourceName: "0input"), #imageLiteral(resourceName: "1input"), #imageLiteral(resourceName: "2input"), #imageLiteral(resourceName: "3input"), #imageLiteral(resourceName: "4input"), #imageLiteral(resourceName: "5input"), #imageLiteral(resourceName: "6input"), #imageLiteral(resourceName: "7input")]
    var circles = ["🟠","⚫️","⚪️","🟣","🟢","🔵","🟡","🔴"]
    
    var lines: [Line]?
    var itemsLoaded = [Int]()
    var itmesLoadedCircles = [String]()
    var settingsVC = SettingsViewController()
    var toggleState = 0
        
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.rowHeight = 60
        settingsVC.delegate = self
        settingsVC.toggleStateShared()
        resetButtonOutlet.accessibilityIdentifier = "reset"
        if let lines = GameManager.shared.fetchLinesCachedData(){
            self.lines = lines
        }
        
        debugPrint("[MainViewController] lines:", lines)
        
        if let patternFromCache = fetchCachedPatternData(){
            itemsLoaded = patternFromCache
            GameManager.shared.fetchPattern(itemsLoaded)
        }else{
            fetchNewPattern()
        }
    }
    
    
    //MARK: Helpers
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
        debugPrint("[MainViewController] itmesLoadedCircles", itmesLoadedCircles, loadedItems)
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
                self.cachePatternData(pattern: items)
                GameManager.shared.fetchPattern(items)
                self.matchToNumbers(items)
            case .failure(_):
                self.noConnectionAlert()
                break
            }
        }
    }
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        debugPrint("[MainViewController] reset tapped")
        fetchNewPattern()
        itmesLoadedCircles = []
        lines = GameManager.shared.reset()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func inputButtonTapped(_ sender: UIButton) {
        
        let number = sender.tag
        let result = GameManager.shared.running(number)

        if result.1.winner{
            debugPrint("[MainViewController] Won")
            showWinnerAlert()
        }else if !result.1.ongoingGame && toggleState == 0{
            debugPrint("[MainViewController] Lost")
            showLostAlertNumbers()
        }else if !result.1.ongoingGame && toggleState == 1{
            debugPrint("[MainViewController] Lost")
            showLostAlertCircles()
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
            debugPrint("[MainViewController] DISMISS TAPPED")
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showLostAlertNumbers(){
        debugPrint(itmesLoadedCircles)
        let alert = UIAlertController(title: "Bad Luck", message: "The combination was \n \(itemsLoaded)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel) { action in
            debugPrint("[MainViewController] DISMISS TAPPED")
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showLostAlertCircles(){
        let alert = UIAlertController(title: "Bad Luck", message: "The combination was \n \(itmesLoadedCircles)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel) { action in
            debugPrint("[MainViewController] DISMISS TAPPED")
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func noConnectionAlert(){
        let alert = UIAlertController(title: "No Internet", message: "Please check your connection", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel) { alert in
            debugPrint("[MainViewController] Dismiss Tapped")
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}



//MARK: UITableViewDataSource
extension MainViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LineTableViewCell
        cell.backgroundColor = .clear
        lines = GameManager.shared.fetchLinesCachedData()
        cell.viewModel = LineViewModel(lines: lines!, row: indexPath.row)
        
        return cell
    }
}


//MARK: User Defaults
extension MainViewController{
    
    func cachePatternData(pattern: [Int]){
        try? UserDefaults.standard.set(pattern, forKey: "pattern")
    }
    
    func fetchCachedPatternData()->[Int]?{
        guard let pattern = UserDefaults.standard.value(forKey: "pattern") as? [Int] else{
            fatalError("No Cached Data")
        }
        return pattern
    }
}



