//
//  TitleManager.swift
//  Networking #1 URLSession ONLY
//
//  Created by Camilo L-Shide on 20/12/23.
//

import UIKit

struct TitleManager {
    
    var titleSelection : String = String()
    
    let titleURL = "https://reddit.com/r/"
    
    func fetchTitle () {
        
        let urlString = "\(titleURL)\(titleSelection)/.json"
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString : String){
        // 1-.Create a URL
        if let url = URL(string: urlString){
            // 2-. Create a URLSession
            let session = URLSession(configuration: .default)
            // 3-. Give a task to the session
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    print(error!)
                }
                if let safeData = data {
                    /*let dataString = String(data: safeData, encoding: .utf8)
                    print(dataString!) */
                    self.parseJSON(titleData: safeData)
                }
            }
            // 4-. Start the task
            task.resume()
        }
        
    }
    
    func parseJSON(titleData : Data){
        let decoder = JSONDecoder()
        do {
            
            let decodedData = try decoder.decode(TitleData.self, from: titleData) //Hiper important to include self in the first parameter so the compiler is not confused if it is a data type or not. (It is)
          
             //print(decodedData.data.children[0].data.title)
            
            var titleArray = fillArray(decodedData: decodedData)
            print("X\(titleArray)")
           //TitleViewController.titleArray = titleArray // why doesn´t it modify the TitleViewController titleArray property?
            
            //print(titleArray)
            
        } catch{
            print(error)
        }
        
    }
    
    func fillArray (decodedData: TitleData) -> [String] {
        
        var titleArray = ["","","","","","","","","","","","","","","","","","","","","","","","",""]
        var currentTitle = String()
        
        for i in 0...24 {
            
            currentTitle = decodedData.data.children[i].data.title
            titleArray[i] = currentTitle
            //print(currentTitle)
        }
        
        return titleArray
    }
}
