//
//  LogInViewController.swift
//  Flash Chat
//
//  This is the view controller where users login


import UIKit
import Firebase

class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

   
    @IBAction func logInPressed(_ sender: AnyObject) {

        
        //TODO: Log in the user
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!){   (user, error) in
            
            if(error != nil){
                print("Login Problem")
                print(error!)
            }else{
                print("Login Successful")
                
                //should call that cool cocoapod that has popup successful
              //  self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
            //    self.navigationController?.navigationBar.backIndicatorImage = nil
            //    self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = nil
                self.navigationController?.setNavigationBarHidden(false, animated: true)
                self.performSegue(withIdentifier: "goToHome", sender: self)
                
            }
            
        }
        
    }
    


    
}  
