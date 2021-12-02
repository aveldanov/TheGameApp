//
//  LineViewModel.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 12/2/21.
//

import Foundation


struct LineViewModel{
    
    let lines: [Line]
    
    var numberOfRowsInSection: Int{
        return lines.count
    }
    
    
}
