//
//  ViewController.swift
//  Bulls and Cows
//
//  Created by Adrien Maranville on 8/11/18.
//  Copyright © 2018 Adrien Maranville. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var lblGuess: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func btnSubmitGuess(_ sender: Any) {
    }
    
}

