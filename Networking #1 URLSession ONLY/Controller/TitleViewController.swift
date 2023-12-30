//
//  TitleViewController.swift
//  Networking #1 URLSession ONLY
//
//  Created by Camilo L-Shide on 20/12/23.
//

import UIKit


class TitleViewController : UITableViewController {

    static var titleMO : TitleManager = TitleManager()
    static var titleArray : [String] = [String]()
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        TitleViewController.titleMO.fetchTitle()
        print("Y\(TitleViewController.titleArray)")
        
        //MARK: - TableView DataSource Methods
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            
            return TitleViewController.titleArray.count
            
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath)
            cell.textLabel?.text = TitleViewController.titleArray[indexPath.row]
            return cell
        }
    }
    
    
    
}
