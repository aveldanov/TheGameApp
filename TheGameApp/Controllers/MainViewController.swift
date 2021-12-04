//
//  MainViewController.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 11/30/21.
//

import UIKit


//TODO Alert - New Game, Exit, Cancel
//TODO Timer -
// TODO Type-in AppNameLabel
// TODO Back-button Warning Game Cancel
// TODO Continue Button
// TODO CONSTANTA!!!


class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var resetButtonOutlet: BounceButton!
    @IBOutlet var inputButtons: [BounceButton]!
    
    let urlString = Constants.urlString
    var lines: [Line]?
    var verifyButtonState = false
    
    var loadedPattern = [Int]()
    var viewModel: GameViewModel?{
        didSet{
            print("GAME")
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.rowHeight = 60
        
        
        resetButtonOutlet.showsTouchWhenHighlighted = true
        let url = URL(string: urlString)!
        
        
        APICaller.shared.fetchData(url) { result in
            switch result{
            case .success(let items):
                self.loadedPattern = items
            case .failure(_):
                break
            }
        }
    }
    
    
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
        print("reset")
        
        lines = GameManager.shared.reset()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func inputButtonTapped(_ sender: UIButton) {
//        print("Input",sender.tag)
        
        
        let number = sender.tag
        let result = GameManager.shared.running(number, verifyButtonState)
        print(result)
        lines = result.0
        
        if result.1.winner{
            print("WIIIIIIIIIINER")
            showWinnerAlert()
        }else if !result.1.ongoingGame{
            print("LOOOOOSER")
            showLooserAlert()
        }
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


 //MARK:  Game Actions Alerts
extension MainViewController{

    func showWinnerAlert(){
        let alert = UIAlertController(title: "Winner", message: "Need to Celebrate", preferredStyle: .alert)
        let action = UIAlertAction(title: "Dismiss", style: .cancel) { action in
            print("TAPPED DISMISS")
        }
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showLooserAlert(){
        let alert = UIAlertController(title: "Loser", message: "Combination was\(lines![0].pattern)])", preferredStyle: .alert)
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
        
//        let model = lines[indexPath.row]
//        print("LINES", lines)
        lines = GameManager.shared.lines
      
        cell.viewModel = LineViewModel(lines: lines!, row: indexPath.row)
        
        return cell
    }
}



