//
//  ContentView.swift
//  Wordle_Game
//
//  Created by Jesse Rosenthal on 6/15/25.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @StateObject private var gameState = GameState()
    @State private var showingSettings = false
    @State private var showAlienMessage = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 20) {
                    // Header
                    Text("WORDLE")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    
                    // Game Info
                    HStack {
                        Text("\(gameState.settings.numLetters) Letters")
                        Text("•")
                        Text("\(gameState.settings.numGuesses) Guesses")
                        Text("•")
                        Text(gameState.settings.theme.displayName)
                        if gameState.settings.isAlienWordle {
                            Text("•")
                            Text("👽")
                        }
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                    
                    // Game Grid
                    GameGridView(gameState: gameState)
                    
                    Spacer()
                    
                    // Keyboard
                    KeyboardView(gameState: gameState)
                }
                .background(Color.black)
                .foregroundColor(.white)
                
                // 👽 Alien Popup Message (overlay)
                if showAlienMessage {
                    AlienPopupView()
                        .transition(.asymmetric(
                            insertion: .scale.combined(with: .opacity),
                            removal: .opacity
                        ))
                        .zIndex(1)
                }
            }
            .navigationBarItems(
                leading: Button("Reset") {
                    gameState.resetGameWithNewWord()
                },
                trailing: Button("Settings") {
                    showingSettings = true
                }
            )
            .sheet(isPresented: $showingSettings) {
                SettingsView(settings: $gameState.settings)
                    .onDisappear {
                        // Apply settings when sheet is dismissed
                        let currentSettings = gameState.settings
                        gameState.updateSettings(currentSettings)
                    }
            }
        }
        .onChange(of: gameState.lastGuessWasIncorrect) { wasIncorrect in
            if wasIncorrect && gameState.settings.isAlienWordle {
                showAlienPopup()
            }
        }
    }
    
    private func showAlienPopup() {
        withAnimation(.easeInOut(duration: 0.3)) {
            showAlienMessage = true
        }
        
        // Hide the message after 2.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            withAnimation(.easeInOut(duration: 0.3)) {
                showAlienMessage = false
                // Reset the flag after showing the popup
                gameState.lastGuessWasIncorrect = false
            }
        }
    }
}

struct AlienPopupView: View {
    @State private var alienScale: CGFloat = 1.0
    
    var body: some View {
        VStack(spacing: 15) {
            // Animated alien emoji
            Text("👽")
                .font(.system(size: 60))
                .scaleEffect(alienScale)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                        alienScale = 1.2
                    }
                }
            
            // Message text
            VStack(spacing: 8) {
                Text("WRONG GUESS!")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                
                Text("The word has changed!")
                    .font(.subheadline)
                    .foregroundColor(.white)
                
                Text("Try again, human... 👽")
                    .font(.caption)
                    .foregroundColor(.green)
                    .italic()
            }
        }
        .padding(25)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.9))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.green, lineWidth: 2)
        )
        .shadow(color: .green.opacity(0.5), radius: 10, x: 0, y: 0)
        .frame(maxWidth: 250)
    }
}
