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
    @State var isShowPicker: Bool = false
    @State var image: Image? = Image("hario")
    @State var data: Data? = UIImage(named: "hario")?.pngData()
    var body: some View {
        NavigationView {
            VStack {
                image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250.0, height: 250.0, alignment: .center)
                    .clipShape(Circle())

                Divider()

                if edit {
                    Button("Change Photo") {
                        self.isShowPicker.toggle()
                    }
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
            .sheet(isPresented: $isShowPicker) {
                ImagePicker(image: self.$image, data: self.$data)
            }
            .navigationBarTitle(Text("Profile"))
            .navigationBarItems(trailing:
                Button(edit ? "Save" : "Edit") {
                    if self.edit {
                        self.saveData()
                    }
                    self.edit = !self.edit
                }
            ).onAppear {
                self.edit = false
                self.nama = SharedPref.getName() ?? "Name empty!"
                self.email = SharedPref.getEmail() ?? "Email empty!"
                self.githubUrl = SharedPref.getGithubUrl() ?? "Github url empty!"
                self.githubName = SharedPref.getGithubName() ?? "Github Name empty!"
                let uiImage = UIImage(data: SharedPref.getPhoto())
                self.image = Image(uiImage: uiImage!)
            }
        }
    }

    func saveData() {
        SharedPref.savePhoto(photo: data!)
        SharedPref.saveName(name: nama)
        SharedPref.saveEmail(email: email)
        SharedPref.saveGithubUrl(githubUrl: githubUrl)
        SharedPref.saveGithubName(githubName: githubName)
    }
}
