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
    
    let gameChanger = GameManager()
    
    let urlString = Constants.urlString
    
    var lines = GameManager().lines
    
    var verifyButtonState = false
//    var lines = GameManager.shared.lines
    
//    var lines : [Line] = [
//        Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
//        Line(arr: [1,4,3,5], verifyArr: ["⚪️","⚫️","⚫️","⭕️"], buttonCheck: true),
//        Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
//        Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
//        Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
//        Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
//        Line(arr: [8,8,8,8], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
//        Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
//        Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⚪️","⚪️"], buttonCheck: false),
//        Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false)
//    ]
    
    func didTapButton(_ lines: [Line]) {
        print("hhhhhhhhhhhhhhhhhhhhh")
        print(lines)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        //        tableView.register(LineTableViewCell.nib(), forCellReuseIdentifier: LineTableViewCell.identifier)
        
        //        tableView.alwaysBounceVertical = false
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.rowHeight = 60
        
        resetButtonOutlet.showsTouchWhenHighlighted = true
        let url = URL(string: urlString)!
        
        APICaller.shared.fetchData(url) { result in
            print(result)
        }
        
        
    }
    
    
    
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        
//        lines[0].arr[0] = 1
//        lines[0].arr[1] = 2
//
 
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    
    @IBAction func inputButtonTapped(_ sender: UIButton) {
        
        print("Input",sender.tag)
        let number = sender.tag
        
        lines = GameManager.shared.running(number, verifyButtonState)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }

 
        
        
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
        
        cell.viewModel = LineViewModel(lines: lines, row: indexPath.row)
        
//        cell.configureLine(with: model)
        return cell
    }
}



