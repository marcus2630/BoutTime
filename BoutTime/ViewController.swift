//
//  ViewController.swift
//  BoutTime
//
//  Created by Marcus Jepsen Klausen on 05/03/2017.
//  Copyright © 2017 Marcus Jepsen Klausen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    
    @IBOutlet weak var firstEventDown: UIButton!
    
    @IBOutlet weak var secondEventUp: UIButton!
    @IBOutlet weak var secondEventDown: UIButton!
    
    @IBOutlet weak var thirdEventUp: UIButton!
    @IBOutlet weak var thirdEventDown: UIButton!
    
    @IBOutlet weak var fourthEventUp: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        do {
            let plist = try PlistImporter.importDictionaries(fromFile: "EventCollection", ofType: ".plist")
            let foo = try EventColelctionUnarchiver.eventCollection(fromArray: plist)
            print(foo)
            
        } catch PlistImportError.invalidResource {
            print("Invalid resource")
        } catch PlistImportError.conversionFailure {
            print("Converision failure")
            
        } catch  {
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

