//
//  LineTableViewCell.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 12/1/21.
//

import UIKit

//
//protocol LineTableViewCellProtocol: AnyObject{
//    func refreshViewModel()
//}

class LineTableViewCell: UITableViewCell, SettingsViewControllerDelegate {

    private var imageSet = [UIImage]()

//   private let imageSet = [ #imageLiteral(resourceName: "0"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "dash")]
    
//   private let imageSet1 = [ #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "black"), #imageLiteral(resourceName: "white"), #imageLiteral(resourceName: "purple"), #imageLiteral(resourceName: "green"), #imageLiteral(resourceName: "blue"), #imageLiteral(resourceName: "yellow"), #imageLiteral(resourceName: "red"), #imageLiteral(resourceName: "dash")]
    
    
    let checkLabels = ["⚪️","⚫️","⭕️"]
    var settingsVC = SettingsViewController()


    @IBOutlet var imageLineCollection: [UIImageView]!
    @IBOutlet weak var checkButtonOutlet: UIButton!
    
    @IBOutlet var checkLabelCollection: [UILabel]!
    
    
//    var delegate: LineTableViewCellProtocol?
    
    var viewModel: LineViewModel?{
        didSet{
//            print("BOOOOOOOOm")
            configure()
        }
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkButtonOutlet.isHidden = true
        checkButtonOutlet.tintColor = .orange
        settingsVC.delegate = self
        settingsVC.toggleStateShared()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func toggleStateData(_ index: Int) {
        
        if index == 0{
            imageSet = [ #imageLiteral(resourceName: "0"), #imageLiteral(resourceName: "1"), #imageLiteral(resourceName: "2"), #imageLiteral(resourceName: "3"), #imageLiteral(resourceName: "4"), #imageLiteral(resourceName: "5"), #imageLiteral(resourceName: "6"), #imageLiteral(resourceName: "7"), #imageLiteral(resourceName: "dash")]
        }else{
            imageSet = [ #imageLiteral(resourceName: "orange"), #imageLiteral(resourceName: "black"), #imageLiteral(resourceName: "white"), #imageLiteral(resourceName: "purple"), #imageLiteral(resourceName: "green"), #imageLiteral(resourceName: "blue"), #imageLiteral(resourceName: "yellow"), #imageLiteral(resourceName: "red"), #imageLiteral(resourceName: "dash")]
        }
    }
    
    
    
    func configure(){
//        delegate?.refreshViewModel()

        guard let viewModel = viewModel else{
            return
        }
        
        let row = viewModel.row
        
        imageLineCollection[0].image = imageSet[viewModel.lines[row].arr[0]]
        imageLineCollection[1].image = imageSet[viewModel.lines[row].arr[1]]
        imageLineCollection[2].image = imageSet[viewModel.lines[row].arr[2]]
        imageLineCollection[3].image = imageSet[viewModel.lines[row].arr[3]]

        checkLabelCollection[0].text = viewModel.lines[row].verifyArr[0]
        checkLabelCollection[1].text = viewModel.lines[row].verifyArr[1]
        checkLabelCollection[2].text = viewModel.lines[row].verifyArr[2]
        checkLabelCollection[3].text = viewModel.lines[row].verifyArr[3]
        
//        checkButtonOutlet.isHidden = viewModel.isButtonCheck
    }
    
    
 
    @IBAction func checkButtonTapped(_ sender: UIButton) {
//        checkButtonOutlet.isHidden = true
    }
    
    
    
}
