//
//  LineViewModel.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 12/2/21.
//

import Foundation


struct LineViewModel{
    
    var lines: [Line]
    var numberOfRowsInSection: Int{
        return lines.count
    }
    
    var row: Int
    var arrNumbersVM: [Int]{
        return lines[row].arr
    }
    
    var verifyArrVM: [String]{
        return lines[row].verifyArr
    }
}
