//
//  AboutView.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 07/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        NavigationView {
            VStack{
                Image("hario")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 250.0, height: 250.0, alignment: .center)
                    .clipShape(Circle())
                
                Divider()
                
                Text("Hario Budiharjo")
                Text("hariobudiharjo@gmail.com")
                
                Button(action: {
                    let urlGithub = "https://github.com/HarioBudiharjo"
                    let url: NSURL = URL(string: urlGithub)! as NSURL
                    
                    UIApplication.shared.open(url as URL)
                    
                }) {
                    Text("Github : HarioBudiharjo")
                }
                
            }
            .navigationBarTitle(Text("Profile"))
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
