//
//  APICaller.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 11/30/21.
//

import Foundation

class APICaller{
    //https://www.random.org/integers/?num=4&min=0&max=7&col=1&base=10&format=plain&rnd=new
    
    static let shared = APICaller()
    
    func fetchData(_ url: URL, completion: @escaping (Result<[Int],Error>)->Void){
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {
                var arrOffline = [Int]()
                for i in 0..<4{
                    arrOffline.append(Int.random(in: 0...7))
                }
                completion(.success(arrOffline))
                return
            }
    
            //TODO UserDefaults
            if let str = String(data: data, encoding: .utf8){
            let arr = Array(str.filter{!$0.isWhitespace})
                let arrInt = arr.map{Int(String($0))!}
                completion(.success(arrInt))
            }
        }.resume()
    }
}
