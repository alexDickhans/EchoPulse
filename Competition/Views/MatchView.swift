//
//  MatchView.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import SwiftUI

struct MatchView: View {
    let match: CompetitionAttributes.Match
    private let winner: Winner
    
    var body: some View {
        HStack {
            Group {
                VStack {
                    if let red2 = match.redAlliance.team2 {
                        Text(match.redAlliance.team1)
                        Text(red2)
                    } else {
                        Text(match.redAlliance.team1)
                    }
                }
                
                if let score = match.redAlliance.score {
                    Text(score.codingKey.stringValue).font(.system(size: 25)).underline(winner == Winner.red)
                }
            }.foregroundStyle(Color.red, Color.black)
            
            Text(match.name).font(.system(size: 35, weight: .bold))
            
            Group {
                if let score = match.blueAlliance.score {
                    Text(score.codingKey.stringValue).font(.system(size: 25)).underline(winner == Winner.blue)
                }
                
                VStack {
                    if let red2 = match.blueAlliance.team2 {
                        Text(match.blueAlliance.team1)
                        Text(red2)
                    } else {
                        Text(match.blueAlliance.team1)
                    }
                }
            }.foregroundStyle(Color.blue, Color.black)
        }
    }
    
    public init(match: CompetitionAttributes.Match) {
        self.match = match
        
        if let redScore = match.redAlliance.score, let blueScore = match.blueAlliance.score {
            if (redScore > blueScore) {
                winner = Winner.red
            } else if (redScore < blueScore) {
                winner = Winner.blue
            } else {
                winner = Winner.neither
            }
        } else {
            winner = Winner.neither
        }
    }
    
    private enum Winner {
        case red
        case blue
        case neither
    }
}

#Preview {
    MatchView(
        match: CompetitionAttributes.Match(
            name: "Q1", scored: true,
            scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(),
            redAlliance: CompetitionAttributes.Alliance(
                team1: "2654E", team2: "2145Z", score: 22),
            blueAlliance: CompetitionAttributes.Alliance(
                team1: "ABS", team2: "ABCD", score: 44)))
}
