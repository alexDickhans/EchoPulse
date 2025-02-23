//
//  ContentView.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/22/25.
//

import ActivityKit
import SwiftUI

// IMPORTANT: LIVE VIEW CAN ONLY SAY ON SCREEN FOR 8 HOURS

struct ContentView: View {
    @State var activity: Activity<CompetitionAttributes>?

    var body: some View {
        VStack {
            Button("Start Activity") {
                startActivity()
            }
            Button("Stop Activity") {
                Task {
                    await stopActivity()
                }
            }
        }.buttonStyle(.borderedProminent).controlSize(.large)
    }

    func startActivity() {
        let attributes = CompetitionAttributes.preview
        let state = ActivityContent(
            state: CompetitionAttributes.ContentState.smiley, staleDate: nil)

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
    }
}

#Preview {
    ContentView()
}
