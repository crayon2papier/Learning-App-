//
//  ContentModel.swift
//  LearningApp
//
//  Created by Salima O. on 02/07/2022.
//

import Foundation

class ContentModel: ObservableObject {
    
    // List of modules
    @Published var modules = [Module]()
   
    //Current module
    @Published var currentModule: Module?
    var currentModuleIndex = 0
    
    // Current lesson
    @Published var currentLesson: Lesson?
    var currentLessonIndex = 0
    
    // Current lesson explanation
    @Published var lessonDescription = NSAttributedString()
    var styleData: Data?
    
    
    // Current selected content and test
    @Published var currentContentSelected:Int?
    
    
    
    init() {
        getLocalData()
    }
    
    // MARK: - Data methods
    func getLocalData() {
        
        // Get a url to the JSON file
        let jsonURL = Bundle.main.url(forResource: "data", withExtension: "json")
        
        do {
        // Read the file into a data object
        let jsonData = try Data(contentsOf: jsonURL!)
            
        // Try to decode the json into an array of modules
            let jsonDecoder = JSONDecoder()
            let modules = try jsonDecoder.decode([Module].self, from: jsonData)
            
        // Assign parsed modules to modules property
            self.modules = modules
        }
        catch {
            //Log error
            print("could not parse local data ")
        }
        
        // Parse the style data
        let styleURL = Bundle.main.url(forResource: "style", withExtension: "html")
        
        do {
            
        // Read the file into a data object
            let styleData = try Data(contentsOf: styleURL!)
            
            self.styleData = styleData
        }
        catch {
            print("Could not parse style data")
        }
        
    }
    
    // MARK: - Module navigation methods
    
    func beginModule(_ moduleid:Int) {
        
        // Find the index for this module id
        for index in 0..<modules.count {
            
            if modules[index].id == moduleid {
                
                // Found the matching module
                currentModuleIndex = index
                break
            }
        }
        
        // Set the current module
        currentModule = modules[currentModuleIndex]
        
    }
    
  
    func beginLesson(_ lessonIndex:Int) {
        
        // Check that the lesson index is within the range of module lessons
        if lessonIndex < currentModule!.content.lessons.count {
            currentLessonIndex = lessonIndex
        }
        else {
            currentLessonIndex = 0
        }
        
        // Set the current lesson
        currentLesson = currentModule!.content.lessons[currentLessonIndex]
        lessonDescription = addStyling(currentLesson!.explanation)
    }
    
    
    func nextLesson() {
        
        // Advance the lesson index
        currentLessonIndex += 1
        
        // Check that it is withon range
        if currentLessonIndex < currentModule!.content.lessons.count {
            
            // Set the current lesson property
            currentLesson = currentModule!.content.lessons[currentLessonIndex]
            lessonDescription = addStyling(currentLesson!.explanation)
        }
        else {
            currentLessonIndex = 0
            currentLesson = nil 
        }
        
        
    }
    
    func hasNextLesson() -> Bool {
        
        if currentLessonIndex + 1 < currentModule!.content.lessons.count {
            return true
        }
        else {
            return false
        }
    }
    
    // MARK: - Code styling
    
    private func addStyling(_ htmlString: String) -> NSAttributedString {
        
        var resultString = NSAttributedString()
        var data = Data()
        
        // Add the styling data
        if styleData != nil {
            data.append(styleData!)
        }
        
        // Add the HTML data
        data.append(Data(htmlString.utf8))
        
        //
        
        // Convert to attributed string
            if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                
               resultString = attributedString
            }
        
      return resultString
    }
    
}
