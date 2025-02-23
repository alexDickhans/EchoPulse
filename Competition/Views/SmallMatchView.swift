//
//  MatchView.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import SwiftUI

struct SmallMatchView: View {
    let match: CompetitionAttributes.Match
    let longName: String
    let textColor: Color
    private let timeText: String
    
    let dateFormatter = DateFormatter()
    
    var body: some View {
        VStack {
            VStack (spacing: -6) {
                Text(longName).textScale(Text.Scale.secondary)
                Text(match.name).font(.system(size: 22, weight: .bold)).foregroundStyle(textColor, Color.black)
                
                VStack (spacing: -6) {
                    Text(timeText.split(separator: "\n")[0])
                    Text(timeText.split(separator: "\n")[1])
                }.textScale(Text.Scale.secondary).multilineTextAlignment(TextAlignment.center)
            }
        }
    }
    
    public init(match: CompetitionAttributes.Match, longName: String) {
        self.match = match
        
        if let redAlliance = match.redAlliance.score, let blueAlliance = match.blueAlliance.score {
            textColor = redAlliance == blueAlliance ? Color.gray : (redAlliance > blueAlliance ? Color.red : Color.blue)
        } else {
            textColor = Color.primary
        }
        
        self.longName = longName
        
        dateFormatter.dateFormat = "h:mm a"

        var startedTime = "\n(Not Started)"
        
        if let startTime = match.startTime {
            startedTime = "\n(\(dateFormatter.string(from: startTime)))"
        }
        
        timeText = dateFormatter.string(from: match.scheduled!) + startedTime
    }
    
    private enum Winner {
        case red
        case blue
        case neither
    }
}

#Preview {
    SmallMatchView(
        match: CompetitionAttributes.Match(
            name: "Q1", scored: true,
            scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(),
            redAlliance: CompetitionAttributes.Alliance(
                team1: "2654E", team2: "2145Z", score: 22),
            blueAlliance: CompetitionAttributes.Alliance(
                team1: "ABS", team2: "ABCD", score: 44)), longName: "Last Match")
}
