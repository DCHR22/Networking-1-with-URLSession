//
//  TitleViewController.swift
//  Networking #1 URLSession ONLY
//
//  Created by Camilo L-Shide on 20/12/23.
//

import UIKit


class TitleViewController : UITableViewController {

    var titleMO = TitleManagerED()
    var titleSelection = "" // This titleSelection is equal to the sender parameter from the performSegue Method.
    var dataSource: [TitleData1] = [TitleData1]() // This data source is super important since it is indeed what we will be using to populate the table view cells. 
    

    override func viewDidLoad() {

        super.viewDidLoad()
        self.titleMO.fetchTitle(titleSelection: titleSelection, delegate: self) // On this one we initiate the service. 
    }
    
    
    
}


//TODO: se asignan los datos y se actualiza la tabla
extension TitleViewController : ServiceDelegate {
    func onSuccess(data: [TitleData1]) {
        self.dataSource = data
        //print(data)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func onError(error: String) {
        print("error")
    }
    
    
}

extension TitleViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
        let item = self.dataSource[indexPath.row]
        print("title: " + item.data.title)
        cell.textLabel?.text = item.data.title
        return cell
    }
}
