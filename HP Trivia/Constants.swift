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
