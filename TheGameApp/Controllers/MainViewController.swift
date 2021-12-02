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

    
    
    var lines : [Line] = [
    Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
    Line(arr: [1,4,3,5], verifyArr: ["⚪️","⚫️","⚫️","⭕️"], buttonCheck: true),
    Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
    Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
    Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
    Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
    Line(arr: [8,8,8,8], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
    Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
    Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⚪️","⚪️"], buttonCheck: false),
    Line(arr: [3,4,5,5], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false)
    ]
    
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
        
        print("touchBB")
        
    }
    

    @IBAction func inputButtonTapped(_ sender: UIButton) {
        
        print("Input",sender.tag)
    }
    
    

}



extension MainViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lines.count
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LineTableViewCell
        
        cell.backgroundColor = .clear
        
        let model = lines[indexPath.row]
        cell.configureLine(with: model)
      
        return cell
    }
}
