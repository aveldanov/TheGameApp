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
    
    let urlString = Constants.urlString

    
    var lines : [Line] = [
    Line(arr: [3,4,5,5], verifyArr: ["white", "black","none","none"], buttonCheck: false),
    Line(arr: [3,4,3,5], verifyArr: ["black", "black","none","none"], buttonCheck: true)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "LineTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        
        let url = URL(string: urlString)!

        APICaller.shared.fetchData(url) { result in
            print(result)
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
        return cell
    }
    
    
    
    
    
    
    
    
    
}
