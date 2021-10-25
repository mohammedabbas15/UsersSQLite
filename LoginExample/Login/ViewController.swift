//
//  ViewController.swift
//  Login
//
//  Created by Field Employee on 10/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var usernameTextfield: UITextField!
    @IBOutlet var idTextfield: UITextField!
    @IBOutlet var ageTextfield: UITextField!
    
    var db: DBHelper = DBHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func store() {
        let username: String = usernameTextfield.text!
        let id: String = idTextfield.text!
        let age: String = ageTextfield.text!
        db.insert(name: username, age: age, id: id)
        print("are we here")
        let main = UIStoryboard(name: "Main", bundle: nil)
        let listVC = main.instantiateViewController(withIdentifier: "listVC")
                navigationController?.pushViewController(listVC, animated: true)
    }
}
