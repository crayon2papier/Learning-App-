//
//  TestView.swift
//  LearningApp
//
//  Created by Salima O. on 06/07/2022.
//

import SwiftUI

struct TestView: View {
    
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        if model.currentQuestion != nil {
            
            VStack {
              // Question number
                Text("Questions \(model.currentQuestionIndex + 1) of \(model.currentModule?.test.questions.count ?? 0)")
                
              // Question
                CodeTextView()
                
              // Answers
                
              // Button
                
            }
            .navigationBarTitle("\(model.currentModule?.category ?? "") Test")
                   
        }
        else {
            // Test hasn't loaded yet
            ProgressView()
        }
        
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
