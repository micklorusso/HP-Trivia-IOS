//
//  GameViewModel.swift
//  HP Trivia
//
//  Created by Lorusso, Michele on 17/12/24.
//

import Foundation

@MainActor
class GameViewModel: ObservableObject {
    private var allQuestions: [QuestionModel] = []
    private var filteredQuestions: [QuestionModel] = []
    private var answeredQuestions: [Int] = []
    
    var currentQuestion = Constants.previewQuestion
    var currentAnswers: [String] = []
    var currentCorrectAnswer: String {
        currentQuestion.answers.first(where: {$0.value == true})!.key
    }
    
    @Published var gameScore = 0
    @Published var questionScore = 5
    @Published var recentScores = [0, 0, 0]
    
    private let savePath = FileManager.documentsDirectory.appending(path: "SavedScores")
    
    init() {
        Task {
            loadScores()
        }
        for answer in currentQuestion.answers.keys {
            currentAnswers.append(answer)
        }
        decodeQuestions()
    }
    
    func startGame() {
        gameScore = 0
        questionScore = 5
        answeredQuestions = []
    }
    
    func nextQuestion() {
        if filteredQuestions.isEmpty {
            return
        }
        
        if answeredQuestions.count == filteredQuestions.count {
            answeredQuestions = []
        }
        
        var candidateQuestion = filteredQuestions.randomElement()!
        while answeredQuestions.contains(candidateQuestion.id) {
            candidateQuestion = filteredQuestions.randomElement()!
        }
        currentQuestion = candidateQuestion
        
        currentAnswers = []
        for answer in currentQuestion.answers.keys {
            currentAnswers.append(answer)
        }
        
        currentAnswers.shuffle()
        
        questionScore = 5
    }
    
    func endGame() {
        recentScores[2] = recentScores[1]
        recentScores[1] = recentScores[0]
        recentScores[0] = gameScore
        
        saveScores()
    }
    
    func usedHint() {
        questionScore -= 1
    }
    
    func gaveCorrectAnswer() {
        answeredQuestions.append(currentQuestion.id)
        gameScore += questionScore
    }
    
    func gaveWrongAnswer() {
        questionScore -= 1
    }
    
    func filterQuestions(from bookIDs: [Int]) {
        filteredQuestions = allQuestions.filter { question in
            bookIDs.contains(question.book)
        }
    }
    
    func loadScores() {
        do {
            let data = try Data(contentsOf: savePath)
            recentScores = try JSONDecoder().decode([Int].self, from: data)
        } catch {
            recentScores = [0, 0, 0]
        }
    }
    
    private func saveScores() {
        do {
            let data = try JSONEncoder().encode(recentScores)
            try data.write(to: savePath)
        } catch {
            print("Unable to save data: \(error)")
        }
    }
    
    private func decodeQuestions() {
        allQuestions = try! JSONDecoder().decode([QuestionModel].self, from: Data(contentsOf: Bundle.main.url(forResource: "trivia", withExtension: "json")!))
        filteredQuestions = allQuestions
    }

}
