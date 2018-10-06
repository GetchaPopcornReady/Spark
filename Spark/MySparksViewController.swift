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
    let userID = Auth.auth().currentUser?.uid
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
        
        
        
        //printing the current users ID
        print("printing current user from firebase: \(userID)")
        
        
        x.observe(.value, with: { snapshot in
            let z = snapshot.value as Any
            print("retrieved manually status was: \(z)")
        })
        
        
        fetchChains()
        
        
    }

    func fetchChains(){
        
     //   while(count < 3){   using the while and counting does actually work, but you have no way of telling the loop when to stop as it skips still
        
        //this will not enter if there are no children that have values!
        handle = rootRef.child("Users").child(userID!).child("chains").observe(.value, with: { (snapshot) in
            print("entered")
              //we will enter this block if another chain exists (i think)
            
             print(snapshot.childrenCount)
            
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
              //  print("children value: \(String(describing: rest.value))")
                //can we get the status from each of these and add it to the array that will populate the data cells?? try line 81
                
                
//                if let dictionary = rest.value as? [String: Any] {
//                    if let number = dictionary["someKey"] as? Double {
//                        // access individual value in dictionary
//                    }
//                }
                
                if let dictionary = rest.value as?  [String : Any]{
                    
                    print("printing dictionary below...")
                    print(dictionary)
                    print("after dictionary")
                    let chainItem = ChainItem(dictionary: dictionary)
                    print(chainItem.timeleft ?? "default")
                    // chainItem.setValuesForKeys(dictionary)
                    self.chainList.append(chainItem)
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
                
            }
            
            //theres 2 different ways to get data from firebase
            //get 1 value (this is easier to manipulate)
            //get the entire list (and then you have to do some parsing), but sometimes this is better actually...less DB calls, this way is doing
            //1 value and i will have multiple, so need to figure out how to get the multiple...or put it in a loop
            
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
        return chainList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        //try to loop through chain list and get info out
        //print(chainList)
        
       let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomMessageCell
    
        let fullCellLabel = chainList[indexPath.row].status! + " | \(chainList[indexPath.row].timeleft!)"//there will be an error if no status or time was created in firebase
        
       // cell.textLabel?.text = fullCellLabel
        cell.title?.text = fullCellLabel
        cell.timeRemaining?.text = "time remaining: \(String(describing: chainList[indexPath.row].timeleft))"
        
        cell.statusImage.image = UIImage(named: "success.png")
        //were gunna have to add title to the chainitem object
        
        //put correct image
        if(chainList[indexPath.row].status == "Complete"){
            print("made it here!!")
            cell.statusImage.image = UIImage(named: "success")
        }
        
        print(chainList[indexPath.row].status ?? "default value")
        print(chainList[indexPath.row].timeleft ?? "default value")
        //set cell contents here
        
        return cell
    }
    
    
    
}


