//
//  GameSettings.swift
//  Wordle_Game
//
//  Created by Jesse Rosenthal on 6/18/25.
//

import Foundation
import Foundation

struct GameSettings {
    var numLetters: Int = 5
    var numGuesses: Int = 6
    var theme: WordTheme = .standard
    var isAlienWordle: Bool = false
}

enum WordTheme: String, CaseIterable {
    case standard = "Standard"
    case animals = "Animals"
    case colors = "Colors"
    case countries = "Countries"
    case food = "Food"
    
    var displayName: String {
        return self.rawValue
    }
}
