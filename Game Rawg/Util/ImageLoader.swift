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
    var data:Data?

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
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
