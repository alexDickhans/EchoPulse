//
//  ContentView.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import ActivityKit
import SwiftUI

// IMPORTANT: LIVE VIEW CAN ONLY SAY ON SCREEN FOR 8 HOURS - maybe

struct ContentView: View {
    @State var activity: Activity<CompetitionAttributes>?

    var body: some View {
        NavigationView {
            VStack {
                ZStack (alignment: Alignment(horizontal: .center, vertical: .bottom)) {
                    Color.orange
                                    .frame(height: 100) // Height of the top bar
                                Text("Echo Live")
                                    .foregroundColor(.white) // Text color
                                    .padding().font(.system(size: 18, weight: .heavy))
                }.edgesIgnoringSafeArea(.top)
                ScrollView {
                    VStack {
                        if activity != nil {
                            Button("Stop Activity") {
                                Task {
                                    await stopActivity()
                                }
                            }
                            FullDetailedView(
                                matches: [
                                    CompetitionAttributes.ContentState.pout
                                        .lastMatch!,
                                    CompetitionAttributes.ContentState.pout
                                        .lastMatch!,
                                    CompetitionAttributes.ContentState.pout
                                        .lastMatch!,
                                    CompetitionAttributes.ContentState.pout
                                        .lastMatch!,
                                    CompetitionAttributes.ContentState.pout
                                        .lastMatch!,
                                    CompetitionAttributes.ContentState.pout
                                        .lastMatch!,
                                    CompetitionAttributes.ContentState.pout
                                        .lastMatch!,
                                    CompetitionAttributes.ContentState.pout
                                        .lastMatch!,
                                    CompetitionAttributes.ContentState.pout
                                        .lastMatch!,
                                    CompetitionAttributes.ContentState.pout
                                        .lastMatch!,
                                    CompetitionAttributes.ContentState.pout
                                        .nextMatch!,
                                    CompetitionAttributes.ContentState.pout
                                        .teamNextMatch!,
                                ], teamName: "2654E")
                        } else {
                            Button("Start Activity") {
                                startActivity()
                            }
                        }
                    }.buttonStyle(.borderedProminent).controlSize(.large)
                }
            }.edgesIgnoringSafeArea(.top)
        }

    }

    func startActivity() {
        let attributes = CompetitionAttributes.preview
        let state = ActivityContent(
            state: CompetitionAttributes.ContentState.pout,
            staleDate: Date().addingTimeInterval(60))

        do {
            activity = try Activity<CompetitionAttributes>.request(
                attributes: attributes, content: state, pushType: nil)
        } catch {
            print(error.localizedDescription)
        }
    }

    func stopActivity() async {
        await activity?.end(
            ActivityContent(
                state: CompetitionAttributes.ContentState.smiley, staleDate: nil
            ), dismissalPolicy: ActivityUIDismissalPolicy.immediate)

        activity = nil
    }

    init() {
    }
}

#Preview {
    ContentView()
}
