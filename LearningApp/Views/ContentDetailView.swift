//
//  ContentDetailView.swift
//  LearningApp
//
//  Created by Salima O. on 04/07/2022.
//

import SwiftUI
import AVKit

struct ContentDetailView: View {
  
    @EnvironmentObject var model:ContentModel
    
    var body: some View {
        
        let lesson = model.currentLesson
        let url = URL(string: Constants.videoHostURL + (lesson?.video ?? ""))
        
        VStack {
       // Only show video if we get a valid URL
        if url != nil {
            VideoPlayer(player: AVPlayer(url: url!))
                .cornerRadius(10)
        }
        
        // Description
            CodeTextView()
        
        // Show Next Lesson Button only if there is next lesson
            if model.hasNextLesson() {
            
            Button {
                // Advance to the next lesson
                model.nextLesson()
                
            } label: {
                
                ZStack {
                    
                    RectangleCard(color: Color.green)
                        .frame(height: 48)
                    
                    
                Text("Next Lesson: \(model.currentModule!.content.lessons[model.currentLessonIndex + 1].title)")
                        .bold()
                        .foregroundColor(.white)
                    
                    
                }
            }

            }
            else {
                // Show the complete button instead
                
                Button {
                    // Take the user back to the homeview
                    model.currentContentSelected = nil
                    
                } label: {
                    
                    ZStack {
                        
                        RectangleCard(color: Color.green)
                            .frame(height: 48)
                        
                        
                        
                    Text("Complete")
                            .bold()
                            .foregroundColor(.white)
                        
                        
                    }
                }
            }
            
        }
        .padding()
        .navigationTitle(lesson?.title ?? "")
    }
}

struct ContentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentDetailView()
    }
}
