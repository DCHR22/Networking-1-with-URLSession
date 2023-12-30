//
//  TitleViewController.swift
//  Networking #1 URLSession ONLY
//
//  Created by Camilo L-Shide on 20/12/23.
//

import UIKit


class TitleViewController : UITableViewController {

    var titleMO = TitleManagerED()
    //TODO: esto es para que asignes en el sigue el tipo de topic
    var titleSelection = ""
    //static var titleArray : [String] = [String]()
    //TODO: se crea el data source intenta no crear casi variables estaticas, recuerda que pueden obtener la info
    var dataSource: [TitleData1] = [TitleData1]()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        //TODO: Aqui se asigna el delgado y se llama al servicio
        self.titleMO.fetchTitle(titleSelection: titleSelection, delegate: self)
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
