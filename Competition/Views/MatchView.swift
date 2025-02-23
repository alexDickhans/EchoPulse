//
//  MatchView.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import SwiftUI

struct MatchView: View {
    let match: CompetitionAttributes.Match
    let longName: String
    private let winner: Winner
    private let timeText: String
    
    let dateFormatter = DateFormatter()
    
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
                } else {
                    Text("-").font(.system(size: 25)).underline(winner == Winner.red)
                }
            }.foregroundStyle(Color.red, Color.black)
            Spacer()
            VStack (spacing: -6) {
                Text(longName).textScale(Text.Scale.secondary)
                Text(match.name).font(.system(size: 35, weight: .bold))
                
                HStack {
                    Text(timeText)
                    
                }.textScale(Text.Scale.secondary)
                
            }
            Spacer()
            Group {
                if let score = match.blueAlliance.score {
                    Text(score.codingKey.stringValue).font(.system(size: 25)).underline(winner == Winner.blue)
                } else {
                    Text("-").font(.system(size: 25)).underline(winner == Winner.red)
                }
                
                VStack {
                    if let red2 = match.blueAlliance.team2 {
                        Group {
                            Text(match.blueAlliance.team1)
                            Text(red2)
                        }
                    } else {
                        Text(match.blueAlliance.team1)
                    }
                }
            }.foregroundStyle(Color.blue, Color.black)
        }.frame(maxWidth: .infinity)
    }
    
    public init(match: CompetitionAttributes.Match, longName: String) {
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
        
        self.longName = longName
        
        dateFormatter.dateFormat = "h:mm a"

        var startedTime = " (Not Started)"
        
        if let startTime = match.startTime {
            startedTime = " (\(dateFormatter.string(from: startTime)))"
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
    MatchView(
        match: CompetitionAttributes.Match(
            name: "Q1", scored: true,
            scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(),
            redAlliance: CompetitionAttributes.Alliance(
                team1: "2654E", team2: "2145Z", score: 22),
            blueAlliance: CompetitionAttributes.Alliance(
                team1: "ABS", team2: "ABCD", score: 44)), longName: "Last Match")
}
