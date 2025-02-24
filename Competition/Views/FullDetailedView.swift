//
//  DetailedView.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import SwiftUI

struct FullDetailedView: View {
    let matches: [CompetitionAttributes.DisplayMatch]
    let teamName: String

    var body: some View {
        VStack(spacing: 0) {
            Group {
                        ForEach(matches, id: \.self) { match in
                            MatchView(match: match, longName: "", teamName: teamName)
                        }
                    }
        }.padding(EdgeInsets(top: 30, leading: 20, bottom: 30, trailing: 20))
    }
}

#Preview {
    FullDetailedView(
        matches: [CompetitionAttributes.DisplayMatch(
            name: "Q1",
            scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(),
            redAlliance: CompetitionAttributes.Alliance(
                team1: "2654E", team2: "2145Z", score: 22),
            blueAlliance: CompetitionAttributes.Alliance(
                team1: "ABS", team2: "ABCD", score: 44)),CompetitionAttributes.DisplayMatch(
            name: "Q2",
            scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(),
            redAlliance: CompetitionAttributes.Alliance(
                team1: "2654E", team2: "2145Z", score: nil),
            blueAlliance: CompetitionAttributes.Alliance(
                team1: "ABS", team2: "ABCD", score: nil)), CompetitionAttributes.DisplayMatch(
            name: "Q4",
            scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(),
            redAlliance: CompetitionAttributes.Alliance(
                team1: "2654E", team2: "2145Z", score: nil),
            blueAlliance: CompetitionAttributes.Alliance(
                team1: "ABS", team2: "ABCD", score: nil))], teamName: "2654E")
}
