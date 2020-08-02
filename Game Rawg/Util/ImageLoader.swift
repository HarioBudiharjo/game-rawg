//
//  ImageLoader.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 11/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation
import UIKit

class ImageLoader: ObservableObject {
    @Published var dataIsValid = false
    @Published var requestDone = false
    var data:Data?
    var url: String = ""

    func setUrl(urlString:String) {
        self.url = urlString
    }

    func getDataImage() {
        guard let url = URL(string: self.url) else {
            dataIsValid = false
            requestDone = true
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.requestDone = true
                self.dataIsValid = true
                self.data = data
            }
        }
        task.resume()

    }

    func imageFromData() -> UIImage {
        UIImage(data: data!) ?? UIImage()
    }
}
