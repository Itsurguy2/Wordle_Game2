//
//  GameGridView.swift
//  Wordle_Game
//
//  Created by Jesse Rosenthal on 6/15/25.
//

import Foundation
import SwiftUI

struct GameGridView: View {
    @ObservedObject var gameState: GameState

    var body: some View {
        VStack(spacing: 5) {
            if isBoardValid() {
                ForEach(0..<gameState.settings.numGuesses, id: \.self) { row in
                    HStack(spacing: 5) {
                        ForEach(0..<gameState.settings.numLetters, id: \.self) { column in
                            LetterCell(
                                letter: gameState.gameBoard[row][column],
                                state: gameState.letterStates[row][column]
                            )
                        }
                    }
                }
            } else {
                ProgressView("Loading Grid...")
            }
        }
        .padding(.horizontal)
        .alert("Game Alert", isPresented: $gameState.showingAlert) {
            Button("OK") {
                if gameState.gameOver {
                    gameState.resetGameWithNewWord()
                }
            }
        } message: {
            Text(gameState.alertMessage)
        }
    }

    private func isBoardValid() -> Bool {
        return gameState.gameBoard.count == gameState.settings.numGuesses &&
               gameState.letterStates.count == gameState.settings.numGuesses &&
               gameState.gameBoard.allSatisfy { $0.count == gameState.settings.numLetters } &&
               gameState.letterStates.allSatisfy { $0.count == gameState.settings.numLetters }
    }
}
