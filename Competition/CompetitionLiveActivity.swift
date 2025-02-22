//
//  CompetitionLiveActivity.swift
//  Competition
//
//  Created by Alexander Dickhans on 2/22/25.
//

import ActivityKit
import SwiftUI
import WidgetKit

struct CompetitionAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct CompetitionLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: CompetitionAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension CompetitionAttributes {
    static var preview: CompetitionAttributes {
        CompetitionAttributes(name: "World")
    }
}

extension CompetitionAttributes.ContentState {
    static var smiley: CompetitionAttributes.ContentState {
        CompetitionAttributes.ContentState(emoji: "😀")
    }

    static var starEyes: CompetitionAttributes.ContentState {
        CompetitionAttributes.ContentState(emoji: "🤩")
    }
}

#Preview("Notification", as: .content, using: CompetitionAttributes.preview) {
    CompetitionLiveActivity()
} contentStates: {
    CompetitionAttributes.ContentState.smiley
    CompetitionAttributes.ContentState.starEyes
}
