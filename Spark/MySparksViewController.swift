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
    var specificUserRef : DatabaseReference!
    var refHandle: UInt!
    var handle: DatabaseHandle!
    var chainList = [ChainItem]()
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("made it to mySparksViewControllerrr")
        
        rootRef = Database.database().reference()
        
        usersRef = rootRef.child("Users")   //get the child reference of root called users
        
        specificUserRef = usersRef.child("josh")    //get the child reference of users
        
        let x = specificUserRef.child("status")
//        let jvetterChains = jvetterRef.child("myChains")
//
//        let firstChain = jvetterChains.child("0")
//
//        let firstChainStatus = firstChain.child("status")   //get the status value
        
        
        x.observe(.value, with: { snapshot in
            let z = snapshot.value as Any
            print("retrieved manually status was: \(z)")
        })
        
        
        fetchChains()
        
        
    }

    func fetchChains(){
        print("here")
        
        handle = rootRef.child("Users").child("josh").observe(.value, with: { (snapshot) in
            
            //theres 2 different ways to get data from firebase
            //get 1 value (this is easier to manipulate)
            //get the entire list (and then you have to do some parsing), but sometimes this is better actually...less DB calls
            
//        handle = rootRef.child("Users").observe(.childAdded, with: { (snapshot) in
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
        print(chainList[indexPath.row].status ?? "default value")
        //set cell contents here
        
        return cell
    }
    
    
    
}


