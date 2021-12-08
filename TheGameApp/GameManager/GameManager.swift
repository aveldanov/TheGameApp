//
//  GameManager.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 12/2/21.
//

import Foundation

var pattern = [Int]()

class GameManager{
    
    static let shared = GameManager()
    
    func fetchPattern(_ items: [Int]){
        pattern = items
    }
    
    var lines : [Line] = [
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
        Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"])
    ]
    
    var close = 0
    var exact = 0
    var inputArr = [Int]()
    var row = 0
    var position = 0
    var buttons:[String] = []
    var gameResult = Game(ongoingGame: true, winner: false, pattern: pattern)
    
    // The running method takes user input and return updateLines and Game State
    func running(_ input:Int?)->([Line],Game){
        if let lines = fetchLinesCachedData(){
            self.lines = lines
        }
        guard let positions = fetchCachedData() else {
            return (lines,gameResult)
        }
        
        row = positions.row
        position = positions.position
        print(pattern)
        guard let input = input else {
            return (lines,gameResult)
        }
        
        inputArr.append(input) // 0 4 5
        lines[row].arr[position] = input
        
        position+=1
        
        if inputArr.count == 4{
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
            
            if result[0] == Constants.rowLength{
                gameResult = Game(ongoingGame: false, winner: true,pattern: pattern)
            }
            
            lines[row].verifyArr = buttons
            buttons = []
            
            row+=1
            position = 0
            inputArr = []
        }
        
        if row == Constants.guesses{
            gameResult = Game(ongoingGame: false, winner: false, pattern: pattern)
        }
        
        cacheData(position: Position(row: row, position: position))
        cacheLines(lines: lines)
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
    
    // reset method resets the game
    func reset()->[Line]{
        buttons = []
        row = 0
        position = 0
        close = 0
        exact = 0
        inputArr = []
        lines = [
            Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
            Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
            Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
            Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
            Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
            Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
            Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
            Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
            Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"]),
            Line(arr: [8,8,8,8], verifyArr: ["🟠","🟠","🟠","🟠"])
        ]
        gameResult = Game(ongoingGame: true, winner: false, pattern: [1,2,3,4])
        
        cacheData(position: Position(row: row, position: position))
        cacheLines(lines: lines)
        return lines
    }
}


//MARK: UserDefaults Caching

extension GameManager{
    
    func cacheLines(lines: [Line]){
        try? UserDefaults.standard.set(PropertyListEncoder().encode(lines), forKey: "array")
    }
    
    func fetchLinesCachedData()->[Line]?{
        guard let data = UserDefaults.standard.value(forKey: "array") as? Data else{
            fatalError("No Cached Data")
        }
        
        guard let lines = try? PropertyListDecoder().decode([Line].self, from: data) else {
            fatalError("Items Decod Error")
        }
        return lines
    }

    func cacheData(position: Position){
        try? UserDefaults.standard.set(PropertyListEncoder().encode(position), forKey: "position")
    }
    
    func fetchCachedData()->Position?{
        guard let data = UserDefaults.standard.value(forKey: "position") as? Data else{
            fatalError("No Cached Data")
        }
        
        guard let position = try? PropertyListDecoder().decode(Position.self, from: data) else {
            fatalError("Items Decod Error")
        }
        return position
    }
}
