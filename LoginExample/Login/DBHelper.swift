//
//  DBHelper.swift
//  Login
//
//  Created by Field Employee on 10/25/21.
//

import Foundation
import SQLite3

class DBHelper {
    init() {
        db = openDatabase()
        createTable()
    }
    //let dbPath: String = "LearningDB.sqlite"
    let dbPath: String = "Users.sqlite"
    // opaque pointers are used to represent C pointers
    var db: OpaquePointer?
    
    func openDatabase() -> OpaquePointer?{
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(dbPath)
        //var db:OpaquePointer? = nil
        print(fileURL)
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("Error opening database")
        }
        else {
            print("Successfully opened connection at \(dbPath)")
        }
        return db
    }
    
    func createTable() {
        let createTableQuery = "CREATE TABLE IF NOT EXISTS person (id TEXT PRIMARY KEY, name TEXT, age TEXT)"
        var createTableStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, createTableQuery, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("person table created")
            }
            else {
                print("Not able to create person table")
            }
        }
        else {
            print("Create table failed")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insert(name: String, age: String, id: String) {
        let insertQuery = "INSERT INTO person (name, age, Id) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertQuery, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (age as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (id as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("successfully inserted")
            }
            else {
                print("could not insert")
            }
        }
        else {
            print("insert statements failed")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [Person] {
        let queryStatementString = "SELECT * FROM person"
        var queryStatement: OpaquePointer? = nil
        var psns: [Person] = []
        
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                //1
                //2
                //0
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let age = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))

                //let age = sqlite3_column_int(queryStatement, 2)
                //let id = sqlite3_column_int(queryStatement, 0)
                
                psns.append(Person(name: name, age: age, id: id))
                print("Query results")
                print("\(name)")
                print("\(age)")
                print("\(id)")
            }
                
        }
        else {
            print("Operation failed")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
}
