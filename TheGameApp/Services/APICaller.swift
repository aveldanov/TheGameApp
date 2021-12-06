//
//  APICaller.swift
//  TheGameApp
//
//  Created by Anton Veldanov on 11/30/21.
//

import Foundation

class APICaller{
    //https://www.random.org/integers/?num=4&min=0&max=7&col=1&base=10&format=plain&rnd=new
    
//    static let shared = APICaller()
    
    private var urlSession: URLSession

    init(urlSession: URLSession = .shared){
        self.urlSession = urlSession
    }
    
    func fetchData(_ url: URL, completion: @escaping (Result<[Int],Error>)->Void){
        
        urlSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            
            //TODO Acivity Indicator
            
            if let str = String(data: data, encoding: .utf8){
                print("datadasjljlskfjlfkj", str)
            let arr = Array(str.filter{!$0.isWhitespace})
                let arrInt = arr.map{Int(String($0))!}
                completion(.success(arrInt))
            }
        }.resume()
    }
}
