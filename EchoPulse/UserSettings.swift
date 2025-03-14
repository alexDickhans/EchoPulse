//
//  UserSettings.swift
//  VRC RoboScout
//
//  Created by William Castro on 7/26/24.
//

import Foundation
import SwiftUI

let defaults = UserDefaults.standard

public extension UIColor {
    
    class func StringFromUIColor(color: UIColor) -> String {
        var components = color.cgColor.components
        while (components!.count < 4) {
            components!.append(1.0)
        }
        return "[\(components![0]), \(components![1]), \(components![2]), \(components![3])]"
    }
    
    class func UIColorFromString(string: String) -> UIColor {
        let componentsString = string.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "")
        let components = componentsString.components(separatedBy: ", ")
        return UIColor(red: CGFloat((components[0] as NSString).floatValue),
                       green: CGFloat((components[1] as NSString).floatValue),
                       blue: CGFloat((components[2] as NSString).floatValue),
                       alpha: CGFloat((components[3] as NSString).floatValue))
    }
    
}

func getRed() -> UIColor {
    #if os(iOS)
    return .systemRed
    #else
    return .red
    #endif
}

class UserSettings: ObservableObject {
        
    private var buttonColorString: String
    private var topBarColorString: String
    private var topBarContentColorString: String
    private var minimalistic: Bool
    private var adam_score: Bool
    private var grade_level: String
    private var performance_ratings_calculation_option: String
    private var team_info_default_page: String
    private var match_team_default_page: String
    private var selected_season_id: Int
    
    static var keyIndex = Int.random(in: 0..<10)
    
    init() {
        self.buttonColorString = defaults.object(forKey: "buttonColor") as? String ?? UIColor.StringFromUIColor(color: getRed())
        self.topBarColorString = defaults.object(forKey: "topBarColor") as? String ?? UIColor.StringFromUIColor(color: getRed())
        defaults.object(forKey: "minimalistic") as? Int ?? 1 == 1 ? (self.minimalistic = true) : (self.minimalistic = false)
        self.topBarContentColorString = defaults.object(forKey: "topBarContentColor") as? String ?? UIColor.StringFromUIColor(color: self.minimalistic ? getRed() : .white)
        defaults.object(forKey: "adam_score") as? Int ?? 1 == 1 ? (self.adam_score = true) : (self.adam_score = false)
        self.grade_level = defaults.object(forKey: "grade_level") as? String ?? "High School"
        self.performance_ratings_calculation_option = defaults.object(forKey: "performance_ratings_calculation_option") as? String ?? "real"
        self.team_info_default_page = defaults.object(forKey: "team_info_default_page") as? String ?? "events"
        self.match_team_default_page = defaults.object(forKey: "match_team_default_page") as? String ?? "matches"
        self.selected_season_id = defaults.object(forKey: "selected_season_id") as? Int ?? API.active_season_id()
    }
    
    func readUserDefaults() {
        self.buttonColorString = defaults.object(forKey: "buttonColor") as? String ?? UIColor.StringFromUIColor(color: getRed())
        self.topBarColorString = defaults.object(forKey: "topBarColor") as? String ?? UIColor.StringFromUIColor(color: getRed())
        defaults.object(forKey: "minimalistic") as? Int ?? 1 == 1 ? (self.minimalistic = true) : (self.minimalistic = false)
        self.topBarContentColorString = defaults.object(forKey: "topBarContentColor") as? String ?? UIColor.StringFromUIColor(color: self.minimalistic ? getRed() : .white)
        defaults.object(forKey: "adam_score") as? Int ?? 1 == 1 ? (self.adam_score = true) : (self.adam_score = false)
        self.grade_level = defaults.object(forKey: "grade_level") as? String ?? "High School"
        self.performance_ratings_calculation_option = defaults.object(forKey: "performance_ratings_calculation_option") as? String ?? "real"
        self.team_info_default_page = defaults.object(forKey: "team_info_default_page") as? String ?? "events"
        self.match_team_default_page = defaults.object(forKey: "match_team_default_page") as? String ?? "matches"
        self.selected_season_id = defaults.object(forKey: "selected_season_id") as? Int ?? API.selected_season_id()
    }
    
    func updateUserDefaults(updateTopBarContentColor: Bool) {
        defaults.set(UIColor.StringFromUIColor(color: UIColor.UIColorFromString(string: self.buttonColorString)), forKey: "buttonColor")
        defaults.set(UIColor.StringFromUIColor(color: UIColor.UIColorFromString(string: self.topBarColorString)), forKey: "topBarColor")
        if updateTopBarContentColor {
            defaults.set(UIColor.StringFromUIColor(color: UIColor.UIColorFromString(string: self.topBarContentColorString)), forKey: "topBarContentColor")
        }
        defaults.set(self.minimalistic ? 1 : 0, forKey: "minimalistic")
        defaults.set(self.adam_score ? 1 : 0, forKey: "adam_score")
        defaults.set(self.grade_level, forKey: "grade_level")
        defaults.set(self.performance_ratings_calculation_option, forKey: "performance_ratings_calculation_option")
        defaults.set(self.team_info_default_page, forKey: "team_info_default_page")
        defaults.set(self.match_team_default_page, forKey: "match_team_default_page")
        defaults.set(self.selected_season_id, forKey: "selected_season_id")
    }
    
    func setButtonColor(color: SwiftUI.Color) {
        self.buttonColorString = UIColor.StringFromUIColor(color: UIColor(color))
    }
    
    func setTopBarColor(color: SwiftUI.Color) {
        self.topBarColorString = UIColor.StringFromUIColor(color: UIColor(color))
    }
    
    func setTopBarContentColor(color: SwiftUI.Color) {
        self.topBarContentColorString = UIColor.StringFromUIColor(color: UIColor(color))
    }
    
    func setMinimalistic(state: Bool) {
        self.minimalistic = state
    }
    
    func setAdamScore(state: Bool) {
        self.adam_score = state
    }
    
    func setGradeLevel(grade_level: String) {
        self.grade_level = grade_level
    }
    
    func setPerformanceRatingsCalculationOption(option: String) {
        self.performance_ratings_calculation_option = option
    }
    
    func setTeamInfoDefaultPage(page: String) {
        self.team_info_default_page = page
    }
    
    func setMatchTeamDefaultPage(page: String) {
        self.match_team_default_page = page
    }
    
    func setSelectedSeasonID(id: Int) {
        self.selected_season_id = id
    }
    
    func buttonColor() -> SwiftUI.Color {
        if let colorString = defaults.object(forKey: "buttonColor") as? String {
            return Color(UIColor.UIColorFromString(string: colorString))
        } else {
            return Color(getRed())
        }
    }
    
    func topBarColor() -> SwiftUI.Color {
        if let colorString = defaults.object(forKey: "topBarColor") as? String {
            return Color(UIColor.UIColorFromString(string: colorString))
        } else {
            return Color(getRed())
        }
    }
    
    func topBarContentColor() -> SwiftUI.Color {
        if let colorString = defaults.object(forKey: "topBarContentColor") as? String {
            let color = Color(UIColor.UIColorFromString(string: colorString))
            return color != topBarColor() ? color : Color.white
        } else {
            if UserSettings.getMinimalistic() {
                return Color(getRed())
            }
            else {
                return Color.white
            }
        }
    }
    
    func tabColor() -> SwiftUI.Color {
        if defaults.object(forKey: "minimalistic") as? Int ?? 1 == 1 {
            return Color(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0))
        } else {
            return self.topBarColor()
        }
    }
    
    static func getRobotEventsAPIKey() -> String? {
        return "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIzIiwianRpIjoiNGViMzY1YzI1N2RhMWRiYWZkZGRkMzRmZDdiMzgzNGJhOWYxNDdmNmFjZTc3NmFkMzIwM2I3MjNmYjQ0M2YyYjdmOWNmOWY0ODdiY2E2MWMiLCJpYXQiOjE2ODU0NTU0ODQuNjQ2OTkyLCJuYmYiOjE2ODU0NTU0ODQuNjQ2OTk2LCJleHAiOjI2MzIyMzAyODQuNjM3ODY2LCJzdWIiOiI5NzI1NyIsInNjb3BlcyI6W119.bmWqYEXdmUV5RgkavYmwVVUL2ilTr-HGbcQTyVe3OU2cJW5R2WsAq-rP89U6dXUbFLRrT6wG7vl-FaT4oT_FXHoqkTOKqfczIC5WGstdWpdNadTGHb52atHU4gewNK69u02d736XM8LmhA1caGCPbCr2gFsb0r_f4F6H0qxzdyiEYIpbgSLgwS91bzPzxc472Xr6wY6gYGBlY212tqHFifoAlxNGDzII8LjUZKpFQWVgFWZsPeuZR6LIgiC5rP6og2iEq1aLLK9lEzN4x1MjY6tEd8wU4Fuqhn5CS9ZeAxDv7ZULCwHRP3oNdC0nhOe5a9EREOTVOjltBYpNRBclbRclER_wHyjRMlf_5QcOpMwwTkk9mF7LturERxWJm8_jjl0YpkEA-p9FJ6glqPH_6uI11iRmiYTacN5XFRs093FvdIIHAd3nePt-5Hsbai8hK8cOb0jUmvoSIKwIyafWRVwR9MvlM8UWge_nrISSEBxBJw-KFjKZgAfxMOoHTBmRNL9nnDLJOPwGOk8c3OoEogypI3KOluXTIEZY7fuWFeulh7qkmCaXR-20X7Xz0IslXtdcSbpVhlf9sTr15pVVGUhnuBMV00xnNHVyFBL6Znp3tNNHD7uLl-q30L5TkfWs5-xzByurd44wGgy0P6AvRfIh9qjASRA-TqAEmx3XpBM"
    }
    
    static func getMinimalistic() -> Bool {
        return defaults.object(forKey: "minimalistic") as? Int ?? 1 == 1
    }
    
    static func getAdamScore() -> Bool {
        return defaults.object(forKey: "adam_score") as? Int ?? 1 == 1
    }
    
    static func getGradeLevel() -> String {
        return defaults.object(forKey: "grade_level") as? String ?? "High School"
    }
    
    static func getPerformanceRatingsCalculationOption() -> String {
        return defaults.object(forKey: "performance_ratings_calculation_option") as? String ?? "real"
    }
    
    static func getTeamInfoDefaultPage() -> String {
        return defaults.object(forKey: "team_info_default_page") as? String ?? "events"
    }
    
    static func getMatchTeamDefaultPage() -> String {
        return defaults.object(forKey: "match_team_default_page") as? String ?? "matches"
    }
    
    static func getSelectedSeasonID() -> Int {
        return defaults.object(forKey: "selected_season_id") as? Int ?? API.active_season_id()
    }
}
