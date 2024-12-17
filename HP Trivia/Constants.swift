//
//  Constants.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 13/12/24.
//

import SwiftUI
import SwiftUICore

enum Constants {
    static let hpFont = "PartyLetPlain"
    
    static let previewQuestion = try! JSONDecoder().decode([QuestionModel].self, from: Data(contentsOf: Bundle.main.url(forResource: "trivia", withExtension: "json")!))[0]
}

struct ParchmentBackground: View {
    var body: some View {
        Image("parchment")
            .resizable()
            .ignoresSafeArea()
            .background(.brown)
    }
}

extension Button {
    func doneButton() -> some View {
        self.padding()
            .tint(.brown)
            .font(.title)
            .foregroundStyle(.white)
            .buttonStyle(.borderedProminent)
    }
}
