//
//  ViewController.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 11/30/21.
//

import UIKit

class ViewController: UIViewController {
    let urlString = "https://www.random.org/integers/?num=4&min=0&max=7&col=1&base=10&format=plain&rnd=new"

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: urlString)!

        APICaller.shared.fetchData(url) { result in
            print(result)
        }
    }


}

