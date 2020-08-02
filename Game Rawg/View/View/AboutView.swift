//
//  AboutView.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 07/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    @State var edit : Bool = false
    @State var nama = ""
    @State var email = ""
    @State var githubUrl = ""
    @State var githubName = ""
    var body: some View {
        NavigationView {
            VStack {
                Image("hario")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250.0, height: 250.0, alignment: .center)
                    .clipShape(Circle())

                Divider()

                if edit {
                    TextField("Nama", text: $nama).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Email", text: $email).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Github Url", text: $githubUrl).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Github Name", text: $githubName).textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    Text(nama)
                    Text(email)
                    Button(action: {
                        let urlGithub = self.githubUrl
                        let url: NSURL = URL(string: urlGithub)! as NSURL
                        UIApplication.shared.open(url as URL)
                    }) {
                        Text("Github : \(githubName)")
                    }
                }
            }
            .navigationBarTitle(Text("Profile"))
            .navigationBarItems(trailing:
                Button(edit ? "Save" : "Edit") {
                    if self.edit {
                        self.saveData()
                    }
                    self.edit = !self.edit
                }
            )
        }.onAppear {
            self.nama = SharedPref.getName() ?? "Name empty!"
            self.email = SharedPref.getEmail() ?? "Email empty!"
            self.githubUrl = SharedPref.getGithubUrl() ?? "Github url empty!"
            self.githubName = SharedPref.getGithubName() ?? "Github Name empty!"
        }
    }

    func saveData() {
        SharedPref.saveName(name: nama)
        SharedPref.saveEmail(email: email)
        SharedPref.saveGithubUrl(githubUrl: githubUrl)
        SharedPref.saveGithubName(githubName: githubName)
    }
}
