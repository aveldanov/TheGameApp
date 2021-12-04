//
//  GameManager.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 12/2/21.
//

import Foundation


protocol GameManagerDelegate: AnyObject{
    
    func gameStart(_ status: Game )
}


class GameManager{
    
    
        
    var delegate: GameManagerDelegate?
    
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
    var gameResult = Game(ongoingGame: true, winner: false)
    
    
    
    func running(_ input:Int?, _ verify: Bool)->([Line],Game){
        // 1234
        // 4563
        
        guard let input = input else {
            return (lines,gameResult)
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
            
            if result[0] == 4{
                gameResult = Game(ongoingGame: false, winner: true)
            }
            
            lines[row].verifyArr = buttons
            buttons = []
            
            row+=1
            position = 0
            inputArr = []
        }
        
        if row == 3{
            gameResult = Game(ongoingGame: false, winner: false)
        }
        
        return (lines,gameResult)

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
                
        for key in dictPatter.keys{
            if dictInput[key] != nil{
                close += min(dictInput[key]!,dictPatter[key]!)
            }
        }
        
        let exact = Array(zip(pattern,input)).filter{$0.0 == $0.1}.count
        return [exact,close-exact]
    }
    

    func reset()->[Line]{
        buttons = []
        row = 0
        position = 0
        close = 0
        exact = 0
        inputArr = []
        lines = [
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
        return lines
    }
}

