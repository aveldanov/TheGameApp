//
//  LineTableViewCell.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 12/1/21.
//

import UIKit

class LineTableViewCell: UITableViewCell {

    var imageSet = [ #imageLiteral(resourceName: "0"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "dash")]
    
    let checkLabels = ["⚪️","⚫️","⭕️"]
    
    @IBOutlet var imageLineCollection: [UIImageView]!
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    @IBOutlet var checkLabelCollection: [UILabel]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        checkButtonOutlet.isHidden = true
        checkButtonOutlet.tintColor = .orange
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func configureLine(with model: Line){
        imageLineCollection[0].image = imageSet[model.arr[0]]
        imageLineCollection[1].image = imageSet[model.arr[1]]
        imageLineCollection[2].image = imageSet[model.arr[2]]
        imageLineCollection[3].image = imageSet[model.arr[3]]
        checkLabelCollection[0].text = model.verifyArr[0]
        checkLabelCollection[1].text = model.verifyArr[1]
        checkLabelCollection[2].text = model.verifyArr[2]
        checkLabelCollection[3].text = model.verifyArr[3]
    }
    
    
 
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        print("test")
        checkButtonOutlet.isHidden = true
    }
    
    
    
}
