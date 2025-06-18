//
//  SettingsView.swift
//  Wordle_Game
//
//  Created by Jesse Rosenthal on 6/18/25.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Binding var settings: GameSettings
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("GAME SETTINGS")) {
                    Picker("Number of Letters", selection: $settings.numLetters) {
                        ForEach(4...7, id: \.self) { num in
                            Text("\(num) Letters").tag(num)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker("Number of Guesses", selection: $settings.numGuesses) {
                        ForEach(4...8, id: \.self) { num in
                            Text("\(num) Guesses").tag(num)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    Picker("Word Theme", selection: $settings.theme) {
                        ForEach(WordTheme.allCases, id: \.self) { theme in
                            Text(theme.displayName).tag(theme)
                        }
                    }
                    
                    Toggle("Alien Wordle Mode", isOn: $settings.isAlienWordle)
                }
                
                Section(footer: Text("Alien Wordle: Word changes every wrong guess! 👽")) {
                    EmptyView()
                }
            }
            .navigationTitle("Settings")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
}
