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
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"], buttonCheck: false),
        Line(arr: [8,8,8,8], verifyArr: ["⚪️","⚫️","⭕️","⭕️"], buttonCheck: false)
    ]
    
    
   
    
    
    
    var close = 0
    var exact = 0
    var inputArr = [Int]()
    static let shared = GameManager()
    var row = 0
    var position = 0
    var pattern = [1,2,3,4]
    var buttons:[String] = []
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
            
//            lines[row].verifyArr = ["⚪️","⚫️","⭕️","⭕️"]
            let result = patternMatch(inputArr, pattern)
            for _ in 0..<result[0]{
                buttons.append("⚫️")
            }
            
            for _ in 0..<result[1]{
                buttons.append("⚪️")
            }
            
            for _ in 0..<(4-(result[0]+result[1])){
                buttons.append("⭕️")
            }
            
            lines[row].verifyArr = buttons
            buttons = []
            
            row+=1
            position = 0
            inputArr = []
        }

        return lines
    }

    
    func patternMatch(_ input: [Int], _ pattern: [Int])->[Int]{
        var close = 0
        
        var dictPatter = [Int:Int]()
        for i in pattern{
            dictPatter[i] = (dictPatter[i] ?? 0) + 1
        }

        var dictInput = [Int:Int]()
        for i in input{
            dictInput[i] = (dictInput[i] ?? 0) + 1
        }

//        print(dictPatter, dictInput)

        for key in dictPatter.keys{
            if dictInput[key] != nil{
                close += min(dictInput[key]!,dictPatter[key]!)
            }
        }

//        print(close)
        let exact = Array(zip(pattern,input)).filter{$0.0 == $0.1}.count
        
        return [exact,close-exact]
    }
}
