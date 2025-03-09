//
//  AppDelegate.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/24/25.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let test_payload = "{\"nextMatch\":{\"blueAlliance\":{\"score\":0,\"team1\":\"Blue Team 1\",\"team2\":\"Blue Team 2\"},\"name\":\"Qualification 5\",\"redAlliance\":{\"score\":0,\"team1\":\"Red Team 1\",\"team2\":\"Red Team 2\"},\"scheduled\":1741503521},\"teamNextMatch\":{\"blueAlliance\":{\"score\":0,\"team1\":\"Blue Team 1\",\"team2\":\"Blue Team 2\"},\"name\":\"Qualification 5\",\"redAlliance\":{\"score\":0,\"team1\":\"Red Team 1\",\"team2\":\"Red Team 2\"},\"scheduled\":1741503521}}".data(using: .utf8)
        
        var content = CompetitionAttributes.ContentState.pout;
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let json = try encoder.encode(content)
            
            print ("encoded json: ", String(data: json, encoding: .utf8)!)
        } catch {
            print("Failed to encode json: \(error.localizedDescription)")
        }
        
        let decoder = JSONDecoder()
        
        do {
            let output = try decoder.decode(CompetitionAttributes.ContentState.self, from: test_payload!)
            
            print("Decoded output: ", output)
        } catch {
            print("Failed to parse json: \(error.localizedDescription)")
        }
        
        
        return true
    }
//    
//    func application(
//        _ application: UIApplication,
//        didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
//    ) {
//        
//        print("Token: ", deviceToken.base64EncodedString())
//    }
}
