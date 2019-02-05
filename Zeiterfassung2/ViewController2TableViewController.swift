//
//  ViewController2TableViewController.swift
//  Zeiterfassung2
//
//  Created by Christian Baltzer on 30.07.18.
//  Copyright © 2018 Christian Baltzer. All rights reserved.
//

import UIKit

class ViewController2TableViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    @IBAction func zurck(_ sender: Any) {
        save()
    }
    
    var data:[String] = ["item1"]
    var timeStamp:[String] = []
    
    var selectedRow: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Alle Zeiten"
        
        self.navigationItem.rightBarButtonItem = editButtonItem
        
        table.dataSource = self
        load()
        
        print("---------")
        print (data)
        print (timeStamp)
        print("---------")
    }
    
    
    //Editieren (Knopf + code)
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        timeStamp.remove(at: indexPath.row)
        table.deleteRows(at:[indexPath], with: .fade)
        save()
    }
 
    

    //Anzahl der Cellen erstellen
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    //bauen der Zelle (cell)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell:UITableViewCell = table.dequeueReusableCell(withIdentifier: "cell")!
        
        var AugabeZeit:Double = Double (data[indexPath.row])!
        AugabeZeit = AugabeZeit / 60
        cell.textLabel?.text = "\( Int ( AugabeZeit / 60 )) : \( Int(round(AugabeZeit.truncatingRemainder(dividingBy: 60.0))) )"
        
        cell.detailTextLabel?.text = timeStamp [indexPath.row]
        
        // Configure the cell...
        return cell
    }
    
    //Speichern in den Userdefaults
    func save(){
        UserDefaults.standard.set(data, forKey: "Zeiten")
        UserDefaults.standard.set(timeStamp, forKey: "time")
    }
    
    //laden aus den UserDefaults
    func load(){
        if let loadedData:[String] = UserDefaults.standard.value(forKey: "Zeiten") as? [String] {
            data = loadedData
            table.reloadData()
        }
        if let loadedTime:[String] = UserDefaults.standard.value(forKey: "time") as? [String] {
            timeStamp = loadedTime
            table.reloadData()
        }
    }
    
    //weiter zu mehr Infos
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        NSLog("You selected cell number: \(indexPath.row)!")
        selectedRow = indexPath.row
        UserDefaults.standard.set(selectedRow, forKey:"i")
        self.performSegue(withIdentifier: "detail", sender: nil)
    }
    
    /*@IBAction func weiterInfos(_ sender: Any) {
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        
        selectedRow = indexPath.row
        
        UserDefaults.standard.set(selectedRow, forKey:"i")
        
        self.performSegue(withIdentifier: "detail", sender: nil)
    }*/
    
}
