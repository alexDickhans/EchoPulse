//
//  MatchView.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import SwiftUI

struct MatchView: View {
    let match: CompetitionAttributes.Match

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
                    Text(score.codingKey.stringValue).font(.system(size: 25))
                }
            }.foregroundStyle(Color.red, Color.black)
            
            Text(match.name).font(.system(size: 35, weight: .bold))
            
            Group {
                if let score = match.blueAlliance.score {
                    Text(score.codingKey.stringValue).font(.system(size: 25))
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
