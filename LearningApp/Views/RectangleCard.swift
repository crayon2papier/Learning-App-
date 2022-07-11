//
//  RectangleCard.swift
//  LearningApp
//
//  Created by Salima O. on 05/07/2022.
//

import SwiftUI

struct RectangleCard: View {
    
    var color = Color.white
    
    var body: some View {
        
        Rectangle()
                .foregroundColor(color)
                .cornerRadius(10)
                .shadow(radius: 10)
    }
}

struct RectangleCard_Previews: PreviewProvider {
    static var previews: some View {
        RectangleCard()
    }
}
