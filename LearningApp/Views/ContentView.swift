//
//  ContentView.swift
//  LearningApp
//
//  Created by Salima O. on 03/07/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var model: ContentModel
    
    var body: some View {
        
        ScrollView {
            
            LazyVStack {
                
                // Confirm that currentModule is set
                if model.currentModule != nil {
                
                    ForEach(0..<model.currentModule!.content.lessons.count) { index in
                   
                        NavigationLink {
                            ContentDetailView()
                                .onAppear {
                                    model.beginLesson(index)
                                }
                        } label: {
                            ContentViewRow(index: index)
                        }
                        
                        
                        
                    }
                }
            }
            .accentColor(.black)
            .padding()
            .navigationTitle("Learn \(model.currentModule?.category ?? "")")
        }
       
    }
}

