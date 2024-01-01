//
//  TitleManagerED.swift
//  Networking #1 URLSession ONLY
//
//  Created by Jose Eduardo Rodriguez Pacheco on 30/12/23.
//

import Foundation

//This service delegate does help to transport the decoded data to the TitleViewController from the parseJSON method on this class

public protocol ServiceDelegate {
    func onSuccess(data: [TitleData1]) //1 This two functions will be implemented on the TitleViewController class
    func onError(error: String) //2
}


struct TitleManagerED {
    
    var titleSelection = "" // This prperty is indeed filled by the 
    var delegate : ServiceDelegate?
    
    let titleURL = "https://reddit.com/r/"
    
    mutating func fetchTitle (titleSelection: String, delegate : ServiceDelegate) {
        
        let urlString = "\(titleURL)\(titleSelection)/.json"
        self.titleSelection = titleSelection
        self.delegate = delegate
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
            let decodedData = try decoder.decode(TitleData.self, from: titleData)
            //TODO: se manda la info de la data
            self.delegate?.onSuccess(data: decodedData.data.children)
        } catch{
            print(error.localizedDescription)
            //TODO: si ocurrio algun error se manda el error
            self.delegate?.onError(error: error.localizedDescription)
        }
        
    }
}

