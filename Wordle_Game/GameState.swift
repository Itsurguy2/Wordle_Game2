//
//  GameState.swift
//  Wordle_Game
//
//  Created by Jesse Rosenthal on 6/15/25.
//


import SwiftUI
import Foundation

// MARK: - Letter State Enum
enum LetterState {
    case empty
    case filled
    case correct
    case wrongPosition
    case notInWord
}

// MARK: - Game State
class GameState: ObservableObject {
    @Published var currentRow = 0
    @Published var currentColumn = 0
    @Published var gameBoard: [[Character]] = []
    @Published var letterStates: [[LetterState]] = []
    @Published var keyboardStates: [Character: LetterState] = [:]
    @Published var gameOver = false
    @Published var hasWon = false
    @Published var showingAlert = false
    @Published var alertMessage = ""
    @Published var settings = GameSettings()
    @Published var lastGuessWasIncorrect = false
    @Published var showAlienPopup = false // New dedicated flag for alien popup

    
    private var targetWord: String = ""
    private let wordGenerator = WordGenerator()
    
    init() {
        initializeGame()
    }
    
    // MARK: - Exercise 1: Apply Number of Letters Settings
    func applyNumLettersSettings() {
        // Reset the game board and letter states with new dimensions
        gameBoard = Array(repeating: Array(repeating: " ", count: settings.numLetters), count: settings.numGuesses)
        letterStates = Array(repeating: Array(repeating: .empty, count: settings.numLetters), count: settings.numGuesses)
        
        // Generate new target word with correct length
        targetWord = wordGenerator.getRandomWord(theme: settings.theme, length: settings.numLetters).uppercased()
        print("New target word (\(settings.numLetters) letters): \(targetWord)")
        
        // Reset game state
        resetGameState()
    }
    
    // MARK: - Exercise 2: Apply Number of Guesses Settings
    func applyNumGuessesSettings() {
        // Resize the game board to accommodate new number of guesses
        gameBoard = Array(repeating: Array(repeating: " ", count: settings.numLetters), count: settings.numGuesses)
        letterStates = Array(repeating: Array(repeating: .empty, count: settings.numLetters), count: settings.numGuesses)
        
        // Reset game state
        resetGameState()
    }
    
    // MARK: - Exercise 3: Apply Theme Settings
    func applyThemeSettings() {
        // Generate new word based on selected theme
        targetWord = wordGenerator.getRandomWord(theme: settings.theme, length: settings.numLetters).uppercased()
        print("New themed word: \(targetWord) (Theme: \(settings.theme.displayName))")
        
        // Reset the game with new word
        resetGame()
    }
    
    // MARK: - Exercise 4: Apply Alien Wordle Settings
    func applyIsAlienWordleSettings() {
        // This setting affects the game behavior in submitWord()
        // When alien mode is on, wrong guesses reset the game
        print("Alien Wordle mode: \(settings.isAlienWordle ? "ON" : "OFF")")
    }
    
    func initializeGame() {
        applyNumLettersSettings()
    }
    
    func updateSettings(_ newSettings: GameSettings) {
        let oldSettings = settings
        settings = newSettings
        
        // Apply changes based on what changed
        if oldSettings.numLetters != newSettings.numLetters {
            applyNumLettersSettings()
        } else if oldSettings.numGuesses != newSettings.numGuesses {
            applyNumGuessesSettings()
        } else if oldSettings.theme != newSettings.theme {
            applyThemeSettings()
        }
        
        applyIsAlienWordleSettings()
    }
    
    func addLetter(_ letter: Character) {
        guard !gameOver && currentColumn < settings.numLetters else { return }
        
        gameBoard[currentRow][currentColumn] = letter
        letterStates[currentRow][currentColumn] = .filled
        currentColumn += 1
    }
    
    func deleteLastCharacter() {
        guard !gameOver && currentColumn > 0 else { return }
        
        currentColumn -= 1
        gameBoard[currentRow][currentColumn] = " "
        letterStates[currentRow][currentColumn] = .empty
    }
    
    func submitWord() {
        guard currentColumn == settings.numLetters else {
            showAlert("Not enough letters")
            return
        }

        let currentWord = String(gameBoard[currentRow])
        checkWord(currentWord)

        if currentWord == targetWord {
            hasWon = true
            gameOver = true
            showAlert("You won! 🎉")
            lastGuessWasIncorrect = false
        } else {
            // Set incorrect guess flag immediately for any wrong guess
            lastGuessWasIncorrect = true
            
            if currentRow == settings.numGuesses - 1 {
                gameOver = true
                showAlert("Game Over! The word was \(targetWord)")
            } else {
                if settings.isAlienWordle {
                    targetWord = wordGenerator.getRandomWord(theme: settings.theme, length: settings.numLetters).uppercased()
                    print("Alien mode: New word generated: \(targetWord)")
                    // Don't show alert in alien mode - let the popup handle it
                    resetGame()
                    return
                }

                currentRow += 1
                currentColumn = 0
            }
        }
    }
    
    private func checkWord(_ word: String) {
        let targetArray = Array(targetWord)
        let wordArray = Array(word)
        var targetLetterCounts = [Character: Int]()
        
        // Count letters in target word
        for letter in targetArray {
            targetLetterCounts[letter, default: 0] += 1
        }
        
        // First pass: mark correct positions
        for i in 0..<settings.numLetters {
            if wordArray[i] == targetArray[i] {
                letterStates[currentRow][i] = .correct
                keyboardStates[wordArray[i]] = .correct
                targetLetterCounts[wordArray[i]]! -= 1
            }
        }
        
        // Second pass: mark wrong positions and not in word
        for i in 0..<settings.numLetters {
            if letterStates[currentRow][i] != .correct {
                if let count = targetLetterCounts[wordArray[i]], count > 0 {
                    letterStates[currentRow][i] = .wrongPosition
                    if keyboardStates[wordArray[i]] != .correct {
                        keyboardStates[wordArray[i]] = .wrongPosition
                    }
                    targetLetterCounts[wordArray[i]]! -= 1
                } else {
                    letterStates[currentRow][i] = .notInWord
                    if keyboardStates[wordArray[i]] == nil {
                        keyboardStates[wordArray[i]] = .notInWord
                    }
                }
            }
        }
    }
    
    private func showAlert(_ message: String) {
        alertMessage = message
        showingAlert = true
    }
    
    func resetGame() {
        resetGameState()
        // Don't generate new word here - keep current word
    }
    
    func resetGameWithNewWord() {
        targetWord = wordGenerator.getRandomWord(theme: settings.theme, length: settings.numLetters).uppercased()
        print("Reset with new word: \(targetWord)")
        resetGameState()
    }
    
    private func resetGameState() {
        currentRow = 0
        currentColumn = 0
        gameBoard = Array(repeating: Array(repeating: " ", count: settings.numLetters), count: settings.numGuesses)
        letterStates = Array(repeating: Array(repeating: .empty, count: settings.numLetters), count: settings.numGuesses)
        keyboardStates = [:]
        gameOver = false
        hasWon = false
        showingAlert = false
        alertMessage = ""
        showAlienPopup = false // Reset alien popup flag
        // Don't reset lastGuessWasIncorrect here - let it be handled by the UI
    }
}
