//
//  SmallMatchView.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import Foundation
import SwiftUI

struct MinimalMatchView: View {
    let match: CompetitionAttributes.DisplayMatch
    let textColor: Color
    
    
    var body: some View {
        Text(match.name)
            .foregroundStyle(textColor, Color.black)
            .font(.system(size: 14, weight: .bold))
            .minimumScaleFactor(0.4)
            .lineLimit(2).multilineTextAlignment(TextAlignment.center)
    }
    
    init(match: CompetitionAttributes.DisplayMatch) {
        self.match = match
        
        if let redAlliance = match.redAlliance.score, let blueAlliance = match.blueAlliance.score {
            textColor = redAlliance == blueAlliance ? Color.gray : (redAlliance > blueAlliance ? Color.red : Color.blue)
        } else {
            textColor = Color.primary
        }
    }
}

