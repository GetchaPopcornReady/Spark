//
//  MySparksViewController.swift
//  Spark
//
//  Created by Joshua Vetter on 9/16/18.
//  Copyright © 2018 Joshua Vetter. All rights reserved.
//

import UIKit
import Firebase

class MySparksViewController: UITableViewController {

    var rootRef : DatabaseReference!
    var usersRef : DatabaseReference!
    var refHandle: UInt!
    var chainList = [ChainItem]()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 
        
        print("made it to mySparksViewControllerrr")
        
        rootRef = Database.database().reference()
        
        usersRef = rootRef.child("Users")   //get the child reference of root called users
        
        let jvetterRef = usersRef.child("jvetter")    //get the child reference of users
        
        let jvetterChains = jvetterRef.child("myChains")
        
        let firstChain = jvetterChains.child("0")
        
        let firstChainStatus = firstChain.child("status")   //get the status value
        
        
        firstChainStatus.observe(.value, with: { snapshot in
            print(snapshot.value as Any)
        })
        
        
        fetchChains()
        
        
    }

    func fetchChains(){
        print("here")
        
        refHandle = rootRef.child("Users").observe(.childAdded, with: { (snapshot) in
            if let dictionary = snapshot.value as?  [String : Any]{
                
                print("printing dictionary below...")
                print(dictionary)
                
                let chainItem = ChainItem(dictionary: dictionary)
                
               // chainItem.setValuesForKeys(dictionary)
                self.chainList.append(chainItem)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
    
            }
            
        })
    }
    
    //the number of cells inside the table view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         print("count")
        return chainList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        print("cell")
        
        
        //try to loop through chain list and get info out
        //print(chainList)
        
       let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = chainList[indexPath.row].status
        print(chainList[indexPath.row].status)
        //set cell contents here
        
        return cell
    }
    
    
    
}


