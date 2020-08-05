//
//  UserDefaultData.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 31/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation
import SwiftUI

class SharedPref {
    static let name = "name"
    static let email = "email"
    static let githubName = "github_name"
    static let githubUrl = "github_url"
    static let firstLaunch = "first_launch"
    static let photo = "photo"

    static let preferences = UserDefaults.standard

    static func saveName(name:String) {
        preferences.set(name, forKey: self.name)
    }

    static func getName() -> String? {
        return preferences.string(forKey: name)
    }

    static func saveEmail(email:String) {
        preferences.set(email, forKey: self.email)
    }

    static func getEmail() -> String? {
        return preferences.string(forKey: email)
    }

    static func saveGithubName(githubName:String) {
        preferences.set(githubName, forKey: self.githubName)
    }

    static func getGithubName() -> String? {
        return preferences.string(forKey: githubName)
    }

    static func saveGithubUrl(githubUrl:String) {
        preferences.set(githubUrl, forKey: self.githubUrl)
    }

    static func getGithubUrl() -> String? {
        return preferences.string(forKey: githubUrl)
    }

    static func saveFirstLaunch(firstLaunch:Bool) {
        preferences.set(firstLaunch, forKey: self.firstLaunch)
    }

    static func getFirstLaunch() -> Bool {
        return preferences.bool(forKey: firstLaunch)
    }

    static func savePhoto(photo:Data) {
        preferences.set(photo, forKey: self.photo)
    }

    static func getPhoto() -> Data {
        let defaultPhoto = UIImage(named: "hario")?.pngData()
        return preferences.data(forKey: photo) ?? defaultPhoto!
    }

    static func checkingFirstLaunch() {
        print("first launch \(getFirstLaunch())")
        if getFirstLaunch() == false {
            saveFirstLaunch(firstLaunch: true)
            saveGithubName(githubName: "HarioBudiharjo")
            saveGithubUrl(githubUrl: "https://github.com/HarioBudiharjo")
            saveName(name: "Hario Budiharjo")
            saveEmail(email: "hariobudiharjo@gmail.com")
        }
    }
}
