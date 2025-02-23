//
//  SmallMatchView.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import Foundation
import SwiftUI

struct MinimalMatchView: View {
    let match: CompetitionAttributes.Match
    let textColor: Color
    
    
    var body: some View {
        Text(match.name)
            .foregroundStyle(textColor, Color.black)
            .font(.system(size: 20, weight: .bold))
            .minimumScaleFactor(0.5) // Ensures small text scales down instead of truncating
            .lineLimit(1)
    }
    
    init(match: CompetitionAttributes.Match) {
        self.match = match
        
        if let redAlliance = match.redAlliance.score, let blueAlliance = match.blueAlliance.score {
            textColor = redAlliance > blueAlliance ? Color.red : Color.blue
        } else {
            textColor = Color.primary
        }
    }
}

