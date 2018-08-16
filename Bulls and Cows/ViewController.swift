//
//  ViewController.swift
//  Bulls and Cows
//
//  Created by Adrien Maranville on 8/11/18.
//  Copyright © 2018 Adrien Maranville. All rights reserved.
//

import Cocoa
import GameplayKit

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet var tableView: NSTableView!
    @IBOutlet var lblGuess: NSTextField!
    
    var answer = ""
    var guesses = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startNewGame()
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return guesses.count
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func btnSubmitGuess(_ sender: Any) {
        let guessString = lblGuess.stringValue
        guard Set(guessString).count == 4 else { return }
        
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard guessString.rangeOfCharacter(from: badCharacters) == nil else { return }
        
        guesses.insert(guessString, at: 0)
        tableView.insertRows(at: IndexSet(integer: 0), withAnimation: .slideDown)
        
        let resultString = result(for: guessString)
        
        if resultString.contains("4b") {
            let alert = NSAlert()
            alert.messageText = "Winner!"
            if(guesses.count <= 10){
                alert.informativeText = "Wow! You beat the game in \(guesses.count) moves! You are amazing! \r\n\r\nClick OK to go again."

            } else if(guesses.count > 10 && guesses.count <= 20) {
                alert.informativeText = "Pretty good. You beat the game in \(guesses.count) moves. \r\n\r\nClick OK to try getting a lower score."
            } else {
               alert.informativeText = "You can do better than that... You beat the game in \(guesses.count) moves. \r\nClick OK to try again."
            }
            
            alert.runModal()
            startNewGame()
        }
    }
    
    func result(for guess: String) -> String {
        var bulls = 0
        var cows = 0
        
        let guessLetters = Array(guess)
        let answerLetters = Array(answer)
        
        for (index, letter) in guessLetters.enumerated() {
            if letter == answerLetters[index] {
                bulls += 1
            } else if answerLetters.contains(letter){
                cows += 1
            }
        }
        return "\(bulls)b \(cows)c"
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let vw = tableView.makeView(withIdentifier: tableColumn!.identifier, owner: self) as? NSTableCellView else { return nil }
        if tableColumn?.title == "Guess" {
            vw.textField?.stringValue = guesses[row]
        } else {
            vw.textField?.stringValue = result(for: guesses[row])
        }
        return vw
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
    func startNewGame() {
        lblGuess.stringValue = ""
        guesses.removeAll()
        answer = ""
        
        var numbers = Array(0...9)
        numbers = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: numbers) as! [Int]
        
        for _ in 0 ..< 4 {
            answer.append(String(numbers.removeLast()))
        }
        
        tableView.reloadData()
    }
    
}

