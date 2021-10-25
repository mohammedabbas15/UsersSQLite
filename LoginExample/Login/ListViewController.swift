//
//  ListViewController.swift
//  Login
//
//  Created by Field Employee on 10/17/21.
//
import SQLite3
import UIKit

class ListViewController: UIViewController, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var persons: [Person] = []
    var db: DBHelper = DBHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self

        persons = db.read()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        persons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        cell.textLabel?.text = persons[indexPath.row].name + " " + String(describing: persons[indexPath.row].age) + " " + String(describing: persons[indexPath.row].id)
        return cell
    }
}
