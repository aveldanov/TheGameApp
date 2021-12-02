//
//  LineTableViewCell.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 11/30/21.
//

import UIKit

class LineTableViewCellArchived: UITableViewCell {
    
    var arr = [1,2,3,4]
    var colors = ["◆","◇","⊗", "⁉️" ]
    var allColors = ["🟢","🟡","⚪️","🔵","🔴","🟠","🟣","🟤",""]
 
    
    

    static let identifier = "LineTableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    

    static func nib()->UINib{
        return UINib(nibName: "LineTableViewCell", bundle: nil)
    }
    
    func configureCell(with model: Line){
        // dummy array
//        lineLabels[0].text = String(model.arr[0])
//        lineLabels[1].text = String(model.arr[1])
//        lineLabels[2].text = String(model.arr[2])
//        lineLabels[3].text = String(model.arr[3])

    }
    
 
    
}
