//
//  detailViewController.swift
//  Zeiterfassung2
//
//  Created by Christian Baltzer on 31.07.18.
//  Copyright © 2018 Christian Baltzer. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {

    @IBOutlet weak var Datum: UILabel!
    @IBOutlet weak var arbeitszeit: UILabel!
    @IBOutlet weak var textfeld: UITextView!
    @IBOutlet weak var submitAction: UIButton!
    
    
    var data:[String] = ["item1"]
    var timeStamp:[String] = []
    var notiz:[String] = []
    var i:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        load()
        
        //Daten Setzen
        if i != -1{
            Datum.text = timeStamp[i]
            arbeitszeit.text = data[i]
            try? textfeld.text = notiz[i]
        }
        
        //Grafische Schönheit für die Buttons
        submitAction.layer.cornerRadius = 4
        
        textfeld.text = "-keine Notizen-"
    }
    

    //laden aus den UserDefaults
    func load(){
        if let loadedData:[String] = UserDefaults.standard.value(forKey: "Zeiten") as? [String] {
            data = loadedData
        }
        if let loadedTime:[String] = UserDefaults.standard.value(forKey: "time") as? [String] {
            timeStamp = loadedTime
        }
        if let loadedNotiz:[String] = UserDefaults.standard.value(forKey: "notizen") as? [String]{
            notiz = loadedNotiz
        }
        if let selected:Int = UserDefaults.standard.value(forKey: "i") as? Int{
            i = selected
        }
    }
    
    func NotizenSpeichern(){
         UserDefaults.standard.set(notiz, forKey: "notizen")
    }
    
    //Notiz zum Speicher hinzufügen
    @IBAction func submit(_ sender: Any) {
        notiz.insert(textfeld.text, at: i)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
