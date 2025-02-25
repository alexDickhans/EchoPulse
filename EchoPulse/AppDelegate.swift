//
//  AppDelegate.swift
//  EchoPulse
//
//  Created by Alexander Dickhans on 2/24/25.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
    ) {
        // Simulate fetching new data
        fetchData { newDataAvailable in
            if newDataAvailable {
                completionHandler(.newData)
            } else {
                completionHandler(.noData)
            }
        }
    }

    private func fetchData(completion: @escaping (Bool) -> Void) {
        // Perform your network request or database update
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let newDataAvailable = Bool.random() // Simulate data change
            completion(newDataAvailable)
        }
    }
}
