//
//  WelcomeViewController.swift
//  Flash Chat
//
//  This is the welcome view controller - the first thign the user sees
//

import UIKit
import Firebase


class WelcomeViewController: UIViewController {

    var refArtists: DatabaseReference!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        //josh firebase practice
        
        //getting info from database
            let rootRef = Database.database().reference()   //get the root of database
        
            let usersRef = rootRef.child("Users")   //get the child reference of root called users
        
            let jvetterRef = usersRef.child("jvetter")    //get the child reference of users
        
            let jvetterChains = jvetterRef.child("myChains")
        
            let firstChain = jvetterChains.child("0")
        
            let firstChainStatus = firstChain.child("status")
        
        firstChainStatus.observe(.value, with: { snapshot in
           // print(snapshot.value as Any)
            let x = snapshot.value
            print("the data value of status is: \(String(describing: x))")
        })
        
        //writing info to firebase
        
    //how to add a new user to firebase
        usersRef.child("AaronDonald99").child("myChains").child("0").setValue(["status": "completed", "timeleft": 0])
        
    //
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
