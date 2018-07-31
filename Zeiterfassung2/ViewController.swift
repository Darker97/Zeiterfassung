//
//  ViewController.swift
//  Zeiterfassung2
//
//  Created by Christian Baltzer on 30.07.18.
//  Copyright © 2018 Christian Baltzer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var DurchschnittAusgabe: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var ZeitenButton: UIButton!
    
    var data:[String] = []
    var zeit:[Double] = []
    var pruf:Bool = false
    var timeStamp:[String] = []
    
    //Start Button
    @IBAction func Start(_ sender: Any) {
        
        var time:Double = round(NSDate().timeIntervalSince1970)
        
        if pruf != true{
            zeit.append(time)
            pruf = true
        }
        save()
        stopButton.isHidden = false
        startButton.isHidden = true
    }
    
    //Stop Button
    @IBAction func Stopß(_ sender: Any) {
        
        var time:Double = round(NSDate().timeIntervalSince1970)
        
        if pruf == true{
            zeit.append(time)
            pruf = false
            rechne()
        }
        stopButton.isHidden = true
        startButton.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stundenlohnAusgabe.text = "\(gehalt) €"
        
        stopButton.layer.cornerRadius = 4
        startButton.layer.cornerRadius = 4
        ZeitenButton.layer.cornerRadius = 4
        
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Zeiterfassung"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        load()
        stopButton.isHidden = true
        durchschnittberechnen()
    }
    
    
    //Speichern und laden aller Daten mit entsprechenden Schlüsseln
    
    func save(){
        UserDefaults.standard.set(zeit, forKey: "zeit")
        UserDefaults.standard.set(data, forKey:"Zeiten")
        UserDefaults.standard.set(pruf, forKey:"pruf")
        UserDefaults.standard.set(timeStamp, forKey: "time")
    }
    
    func load(){
        if let loadedZeit:[Double] = UserDefaults.standard.value(forKey: "zeit") as? [Double] {
            zeit = loadedZeit
        }
        if let loadedZeiten:[String] = UserDefaults.standard.value(forKey: "Zeiten") as? [String] {
            data = loadedZeiten
        }
        if let loadedpruf:Bool = UserDefaults.standard.value(forKey: "pruf") as? Bool {
            pruf = loadedpruf
        }
        if let loadedTime:[String] = UserDefaults.standard.value(forKey: "Time") as? [String] {
            timeStamp = loadedTime
        }
    }
    
    //rechner für die endgültigen Daten
    func rechne(){
        print(zeit[1])
        print(zeit[0])
        
        var neueZeit:Double = zeit[1]-zeit[0]
        
        zeit.removeAll()
        
        print(neueZeit)
        var neueZeitt:String = "\(neueZeit)"
        
        data.append(neueZeitt)
        
        
        let jetzt = Date()
        timeStamp.append (String(describing: jetzt))
        
        save()
    }
    
    //Rechner für den Durchschnitt
    func durchschnittberechnen(){
        var rechner:Double = 0
        
        if data.count != 0{
            for i in 0...data.count-1 {

                rechner = rechner + Double(data[i])!
                
            }
            rechner = rechner / 60.0
            rechner = rechner / 60.0
            rechner = round(rechner)
        }
        stundenlohn(Arbeitsstunden: rechner)
        DurchschnittAusgabe.text = String(rechner)
    }

    
    //Gehalt ausrechnen
    
    @IBOutlet weak var Gehalt: UILabel!
    @IBOutlet weak var stundenlohnAusgabe: UILabel!
    
    @IBOutlet weak var endgültigesGehalt: UILabel!
    var gehalt: Double = 13.40
    
    func stundenlohn(Arbeitsstunden: Double){
        var endgehalt = Arbeitsstunden * gehalt
        endgehalt = round(endgehalt)
        
        endgültigesGehalt.text = "\(round(endgehalt)) €"
    }
}

