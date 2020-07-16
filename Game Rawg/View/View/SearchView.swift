//
//  SearchView.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 12/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import SwiftUI

struct SearchView: View {
    
    
    @State private var wasSearch = false
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    @ObservedObject var viewmodel = GameViewModel()
    
    var body: some View {
        
        VStack {
            HStack {
                HStack {
                    Image(systemName: "magnifyingglass")
                    
                    TextField("search", text: $searchText, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                    }, onCommit: {
                        self.wasSearch = true
                        self.viewmodel.loadDataSearchGame(search: self.searchText)
                    }).foregroundColor(.primary)
                    
                    Button(action: {
                        self.searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill").opacity(searchText == "" ? 0 : 1)
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10.0)
                
                if showCancelButton  {
                    Button("Cancel") {
                        UIApplication.shared.endEditing(true)
                        self.searchText = ""
                        self.showCancelButton = false
                    }
                    .foregroundColor(Color(.systemBlue))
                }
            }
            .padding(.horizontal)
            .navigationBarHidden(showCancelButton)
            
            VStack{
                if viewmodel.loading {
                    Spacer()
                    ActivityIndicator(size: 80)
                    Spacer()
                } else {
                    if (viewmodel.games.results.count > 0) {
                        List(viewmodel.games.results){ game in
                            NavigationLink(destination: DetailView(game: game)) {
                                SearchRow(game: game)
                            }
                        }
                    } else {
                        Spacer()
                        Text(wasSearch ? "Data not found!" : "Let Search and click return!")
                        Spacer()
                    }
                }
            }
                
            .navigationBarTitle(Text("Search"))
            .resignKeyboardOnDragGesture()
        }.padding(.top,5)
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}