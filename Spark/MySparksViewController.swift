//
//  MySparksViewController.swift
//  Spark
//
//  Created by Joshua Vetter on 9/16/18.
//  Copyright © 2018 Joshua Vetter. All rights reserved.
//

import UIKit

class MySparksViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {

    let list = ["hi", "hfgh","dghdh","dfhgdgh"]
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
     public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row]
        
        return(cell)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("my sparks loaded")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
