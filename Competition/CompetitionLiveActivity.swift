//
//  CompetitionLiveActivity.swift
//  Competition
//
//  Created by Alexander Dickhans on 2/22/25.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct CompetitionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CompetitionAttributes.self) { context in
            // Lock screen/banner UI goes here
            DetailedView(lastMatch: context.state.lastMatch, nextMatch: context.state.nextMatch, teamNextMatch: context.state.teamNextMatch)
        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    if let match = context.state.lastMatch {
                        SmallMatchView(match: match, longName: "Last Match").padding(EdgeInsets(top: -10, leading: 12, bottom: -10, trailing: 0))
                    }
                }
                DynamicIslandExpandedRegion(.center) {
                    Ranking(rank: 1, num: 80).frame(maxHeight: .infinity, alignment: .center)
                }
                DynamicIslandExpandedRegion(.trailing) {
                    if let match = context.state.nextMatch {
                        SmallMatchView(match: match, longName: "Next Match").padding(EdgeInsets(top: -10, leading: 0, bottom: -10, trailing: 12))
                    }
                }
                DynamicIslandExpandedRegion(.bottom) {
                    if let match = context.state.teamNextMatch {
                        MatchView(match: match, longName: "Next Up")
                    }
                }
            } compactLeading: {
                if let match = context.state.lastMatch {
                    MinimalMatchView(match: match)
                }
            } compactTrailing: {
                if let match = context.state.teamNextMatch {
                    MinimalMatchView(match: match)
                }
            } minimal: {
                if let match = context.state.lastMatch {
                    MinimalMatchView(match: match)
                }
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension CompetitionAttributes {
    static var preview: CompetitionAttributes {
        CompetitionAttributes(name: "World", division: "Science")
    }
}

extension CompetitionAttributes.ContentState {
    static var sad: CompetitionAttributes.ContentState {
        CompetitionAttributes.ContentState(lastMatch: CompetitionAttributes.Match(name: "R16 1-1", scored: true, scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(), redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: 22), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: 44)), nextMatch: CompetitionAttributes.Match(name: "Q2", scored: true, scheduled: Date().addingTimeInterval(-60 * 2), startTime: nil, redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: nil), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: nil)), teamNextMatch: CompetitionAttributes.Match(name: "Q4", scored: true, scheduled: Date().addingTimeInterval(-60 * 2), startTime: nil, redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: nil), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: nil)))
    }
    
    static var smiley: CompetitionAttributes.ContentState {
        CompetitionAttributes.ContentState(lastMatch: CompetitionAttributes.Match(name: "R16 1-1", scored: true, scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(), redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: 44), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: 22)), nextMatch: CompetitionAttributes.Match(name: "Q2", scored: true, scheduled: Date().addingTimeInterval(-60 * 2), startTime: nil, redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: nil), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: nil)), teamNextMatch: CompetitionAttributes.Match(name: "Q4", scored: true, scheduled: Date().addingTimeInterval(-60 * 2), startTime: nil, redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: nil), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: nil)))
    }
    
    static var pout: CompetitionAttributes.ContentState {
        CompetitionAttributes.ContentState(lastMatch: CompetitionAttributes.Match(name: "R16 1-1", scored: true, scheduled: Date().addingTimeInterval(-60 * 2), startTime: Date(), redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: 22), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: 22)), nextMatch: CompetitionAttributes.Match(name: "Q2", scored: true, scheduled: Date().addingTimeInterval(-60 * 2), startTime: nil, redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: nil), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: nil)), teamNextMatch: CompetitionAttributes.Match(name: "Q4", scored: true, scheduled: Date().addingTimeInterval(-60 * 2), startTime: nil, redAlliance: CompetitionAttributes.Alliance(team1: "2654E", team2: "2145Z", score: nil), blueAlliance: CompetitionAttributes.Alliance(team1: "ABS", team2: "ABCD", score: nil)))
    }
}

#Preview("Live Activity", as: .content, using: CompetitionAttributes.preview) {
    CompetitionLiveActivity()
} contentStates: {
    CompetitionAttributes.ContentState.sad
    CompetitionAttributes.ContentState.smiley
    CompetitionAttributes.ContentState.pout
}
