//
//  GameManager.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 12/2/21.
//

import Foundation


class GameManager{

    

    
    // combination
    // user input
    
    
    var lines : [Line] = [
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["⚪️","⚫️","⚫️","⭕️"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["⚪️","⚫️","⚪️","⚪️"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false)
    ]
    
    
   
    
    
    
    var close = 0
    var exact = 0
    var inputArr = [Int]()
    static let shared = GameManager()
    var row = 0
    var position = 0
 
    var code = [1,4,5,5]
    
    
    func running(_ input:Int?, _ verify: Bool)->[Line]{
        // 1234
        // 4563
        
        
        guard let input = input else {
            return lines
        }

        inputArr.append(input) // 0 4 5
        lines[row].arr[position] = input

        position+=1

        if inputArr.count == 4{
            lines[row].verifyArr = ["⚪️","⚫️","⭕️","⭕️"]

            row+=1
            position = 0
            inputArr = []
        }
        
    
        
        return lines
    }

    
    func verifyButtons(_ inpArr: [Int]){
        for item in inputArr{
            
            if code.contains()
            
        }
        
        
    }
    

    
}
