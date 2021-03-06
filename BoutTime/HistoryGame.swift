//
//  HistoryGame.swift
//  BoutTime
//
//  Created by Marcus Jepsen Klausen on 05/03/2017.
//  Copyright © 2017 Marcus Jepsen Klausen. All rights reserved.
//


// Frameworks
import Foundation
import GameKit
import AudioToolbox

// Initializing sounds
var button: SystemSoundID = 1306


// Model the content of historical events
// An event has a date and a historical statement
protocol HistoricalEvent {
    var date: Date { get } // date
    var statement: String { get } // Historical statement
    var url: String { get }
}

//  Model the functionality of a historical game
protocol HistoricalGame {
    var eventCollection: [HistoricalEvent] { get set } // An array of evnets conforming to HistoricalEvent protocol
    var roundsPlayed: Int { get set }
    var numberOfRounds: Int { get }
    var points: Int { get set }
    var timer: Int { get } // how long is each round the the game type
    init(eventCollection: [HistoricalEvent]) // Should be initialized with an array of historical events as the eventCollection
    func pickRandomEvents(_ amount: Int) -> [HistoricalEvent] // pick (amount) random events and return as [HsitoricalEvents]
    func checkOrder(of array: [HistoricalEvent]) -> Bool
}

// Event structure
struct Event: HistoricalEvent {
    let date: Date
    let statement: String
    let url: String
}

// Error codes
enum PlistImportError: Error {
    case invalidResource
    case conversionFailure
    case invalidSelection
}

// Attempt importing a file and return it as an array of dictionaries -> [[String: AnyObject]]
class PlistImporter {
    static func importDictionaries(fromFile name: String, ofType type: String) throws -> [[String: AnyObject]] {
        
        // Attempt reading the file
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw PlistImportError.invalidResource
        }
        // Attempt casting the NSArray initialization of file as an array of dictionaries String to AnyObject
        guard let arrayOfDictionaries = NSArray.init(contentsOfFile: path) as? [[String: AnyObject]] else {
            throw PlistImportError.conversionFailure
        }
        return arrayOfDictionaries
    }
}

// Attempt unarchiving the contents of the file and return it as an array of HistoricalEvents
class CollectionUnarchiver {
    static func collection(fromArray array: [[String: AnyObject]]) throws -> [HistoricalEvent] {
        
        // Initialize the variable as an empty array of HistoricalEvents
        var collection: [HistoricalEvent] = []
        
        // Iterate over the array passed into the class method
        for dictionary in array {
            
                // Attempt to cast contents of current dictionary
                if  let date = dictionary["date"] as? Date,
                    let statement = dictionary["statement"] as? String,
                    let url = dictionary["url"] as? String {
                    
                        // Create an instance of Event and append it to the collection
                    let event = Event(date: date, statement: statement, url: url)
                        collection.append(event)
                    } else {
                        print("failed")
                    }
        }
        return collection
    }
}

// Modeling a "GameTopic" conforming to HistoricalEvent, this way we could have SpaceTopic, MusicTopic etc with individual settings
class GameTopic: HistoricalGame {
    var eventCollection: [HistoricalEvent]
    var points: Int = 0
    var roundsPlayed: Int = 0
    let numberOfRounds: Int = 6
    var timer: Int = 60
    
    // Initialize the eventCollection property to the passed an array of events
    required init(eventCollection: [HistoricalEvent]) {
        self.eventCollection = eventCollection
    }
    
    // Pick (amount) random events and return them as an array confirming to HistoricalEvent
    func pickRandomEvents(_ amount: Int) -> [HistoricalEvent] {
        
        var eventsPicked: [HistoricalEvent] = []
        var randomNumbersUsed: [Int] = [] // Store which cases have already been picked
        
        // As long as the amount of eventsPicked is less than the amount we chose
        while eventsPicked.count < amount {
            
            // Pick random number
            let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: eventCollection.count)
            
            // Check if randomNumbersUsed contains current random number
            if randomNumbersUsed.contains(randomNumber) == false {
                
                // If not, store both event and random number
                eventsPicked.append(eventCollection[randomNumber])
                randomNumbersUsed.append(randomNumber)
            }
        }
        return eventsPicked
    }
    
    func checkOrder(of array: [HistoricalEvent]) -> Bool {
        if  array[0].date > array[1].date,
            array[1].date > array[2].date,
            array[2].date > array[3].date {
            points += 1
            return true
        } else {
            return false
        }
    }
}

// Function for playback of the loaded sound &button
func buttonPressedSound() {
    AudioServicesPlaySystemSound(button)
}
