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
    
    
    @IBAction func butt(_ sender: Any) {
        data.append("36000")
        timeStamp.append("")
        notiz.append("")
        save()
    }
    
    var data:[String] = []
    var zeit:[Double] = []
    var pruf:Bool = false
    var timeStamp:[String] = []
    var notiz:[String] = []
    
    var fileURL: URL!
    
    //erstes Laden
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //URL fürs DatenSpeichern
        let baseURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        fileURL = baseURL.appendingPathComponent("notes.txt")
        
        ZeitenButton.isHidden = true
        
        stundenlohnAusgabe.text = "\(gehalt) €"
        
        //Grafische Schönheit für die Buttons
        stopButton.layer.cornerRadius = 4
        startButton.layer.cornerRadius = 4
        ZeitenButton.layer.cornerRadius = 4
        
        // laden aller DatenAusgaben
        self.title = "Zeiterfassung"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        load()
        stopButton.isHidden = true
        durchschnittberechnen()
        
        if data.count != 0{
            ZeitenButton.isHidden = false
        }
    }
    
    
    //Start Button
    @IBAction func Start(_ sender: Any) {
        
        let time:Double = round(NSDate().timeIntervalSince1970)
        
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
        
        let time:Double = round(NSDate().timeIntervalSince1970)
        
        if pruf == true{
            zeit.append(time)
            pruf = false
            rechne()
        }
        stopButton.isHidden = true
        startButton.isHidden = false
        
        if data.count != 0{
            ZeitenButton.isHidden = false
        }
    }
    
    //Speichern und laden aller Daten mit entsprechenden Schlüsseln
    
    func save(){
        UserDefaults.standard.set(zeit, forKey: "zeit")
        UserDefaults.standard.set(data, forKey:"Zeiten")
        UserDefaults.standard.set(pruf, forKey:"pruf")
        UserDefaults.standard.set(timeStamp, forKey: "time")
        UserDefaults.standard.set(notiz, forKey: "notizen")
        speichernInDatei()
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
        if let loadedTime:[String] = UserDefaults.standard.value(forKey: "time") as? [String] {
            timeStamp = loadedTime
        }
        if let loadedNotiz:[String] = UserDefaults.standard.value(forKey: "notizen") as? [String]{
            notiz = loadedNotiz
        }
    }
    
    //Speichern als Datei
    func speichernInDatei(){
        let a = NSArray(object: data)
        let b = NSArray(object: timeStamp)
        do {
            try a.write(to: fileURL)
            try b.write(to: fileURL)
        }catch{
            print("Error writing save")
        }
    }
    
    //Laden aus Datei
    func ladenAlsDatei(){
        if let loadedZeiten:[String] = NSArray(contentsOf:fileURL) as? [String] {
            data = loadedZeiten
        }
    }
    
    
    //rechner für die endgültigen Daten
    func rechne(){
        print(zeit[1])
        print(zeit[0])
        
        let neueZeit:Double = zeit[1]-zeit[0]
        
        zeit.removeAll()
        
        print(neueZeit)
        let neueZeitt:String = "\(neueZeit)"
        
        data.append(neueZeitt)
        
        
        let jetzt = Date()
        timeStamp.append (String(describing: jetzt))
        notiz.append("--keine Notizen--")
        
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
    var gehalt: Double = 0.0
    //Hier das entsprechende Gehalt eintragen
    
    func stundenlohn(Arbeitsstunden: Double){
        let temp1:Double = gehalt/2
        let temp:Double = Double(data.count) * temp1
        var endgehalt = Arbeitsstunden * gehalt-temp
        endgehalt = round(endgehalt)
        
        endgültigesGehalt.text = "\(round(endgehalt)) €"
    }
}

