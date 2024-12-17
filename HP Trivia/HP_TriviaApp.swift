//
//  HP_TriviaApp.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 13/12/24.
//

import SwiftUI

@main
struct HP_TriviaApp: App {
    @StateObject private var store = Store()
    @StateObject private var gameViewModel = GameViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView(isPreview: false)
                .environmentObject(store)
                .environmentObject(gameViewModel)
        }
    }
}
