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
    

    var imageSetButtons = [ #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "black"), #imageLiteral(resourceName: "white"), #imageLiteral(resourceName: "purple"), #imageLiteral(resourceName: "green"), #imageLiteral(resourceName: "blue"), #imageLiteral(resourceName: "yellow"), #imageLiteral(resourceName: "red")]
    var lines: [Line]?
    var verifyButtonState = false
    
    var itemsLoaded = [Int]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.rowHeight = 60
        
        resetButtonOutlet.showsTouchWhenHighlighted = true
        
        fetchNewPattern()
        
        setButtonImage()
    }
    
    
    
    func setButtonImage(){
        for i in 0..<inputButtons.count{
            inputButtons[i].setImage(imageSetButtons[i], for: .normal)
        }
    }
    
    
    
    
    func fetchNewPattern(){
        
        let urlString = Constants.urlString

        let url = URL(string: urlString)!

        APICaller.shared.fetchData(url) { result in
            switch result{
            case .success(let items):
                self.itemsLoaded = items
                DispatchQueue.main.async {
                    GameManager().fetchPattern(items)
                }
            case .failure(_):
                break
            }
        }
    }
    
    
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        print("reset")
        fetchNewPattern()
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
        let alert = UIAlertController(title: "Loser", message: "The combination was \(itemsLoaded)", preferredStyle: .alert)
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



