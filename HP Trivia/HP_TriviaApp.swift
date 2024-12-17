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
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
