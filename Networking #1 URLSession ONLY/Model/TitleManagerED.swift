import Foundation

//This service delegate does help to transport the decoded data to the TitleViewController from the parseJSON method on this class

public protocol ServiceDelegate {
    func onSuccess(data: [TitleData1]) //1 This two functions will be implemented on the TitleViewController class
    func onError(error: String) //
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
            
            self.delegate?.onSuccess(data: decodedData.data.children) // In this line, what we strive to pass to the TitleViewController is the JSON children array because that is indeed the array that contains all of the Data1 objects that contain the title inside them. By pasing this chlidren array we won't have to use an array to get a hold of every title since the indexPath.row property from the cellForRowAt method will help us to populate each cell by diving into the children object property until we get to the title.
        } catch{
            print(error.localizedDescription)
            
            self.delegate?.onError(error: error.localizedDescription) // We do sent an explanation of the error that could be used to show an alert
            
        }
        
    }
}

