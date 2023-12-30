//
//  ViewController.swift
//  Networking #1 URLSession ONLY
//
//  Created by Camilo L-Shide on 19/12/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var selectTopic: UIButton!
    
    @IBOutlet var topicsCollection: [UIButton]! // This time a collection of outlets is needed since we are changing all of those in conjunction.
    

    @IBAction func selectTopicPressed(_ sender: UIButton) {
        
        topicsCollection.forEach { btn in
            UIView.animate(withDuration: 0.7) {
                btn.isHidden = !btn.isHidden // Remember this one set the value to the oposite boolean.
                btn.alpha = btn.alpha == 0 ? 1 : 0 // This is read as "if btn.alpha is equal to 0, then assign it the value of 1, if not assign it the value of 0.
                btn.layoutIfNeeded()
            }
        }
        
    }
    
    @IBAction func mexicoPressed(_ sender: UIButton) {
        //TODO: esta ya esta de mas

        /*    mTitleManager.titleSelection = "mexico"
        var mTitleManager = TitleManager()
            TitleViewController.titleMO = mTitleManager*/
        
        performSegue(withIdentifier: "SelectionToTitle" , sender: "mexico")
    }
    
    @IBAction func videogamesPressed(_ sender: UIButton) {
        
 
        //TODO: esta ya esta de mas
       /* TitleViewController.titleMO = vgTitleManager
        var vgTitleManager = TitleManager()
        vgTitleManager.titleSelection = "videogames"*/
        performSegue(withIdentifier: "SelectionToTitle" , sender: "videogames")
        
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectTopic.layer.cornerRadius = selectTopic.frame.height / 2
        
        topicsCollection.forEach { btn in
            btn.layer.cornerRadius = btn.frame.height / 2
            btn.isHidden = true
            btn.alpha = 0
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    //TODO: aqui agreggue el prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectionToTitle" {
            let controller = segue.destination as? TitleViewController
            controller?.titleSelection = sender as! String
        }
    }


}

