//
//  ImagePicker.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 05/08/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    var presentationMode

    @Binding var image: Image?
    @Binding var data: Data?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var presentationMode: PresentationMode
        @Binding var image: Image?
        @Binding var data: Data?

        init(presentationMode: Binding<PresentationMode>, image: Binding<Image?>, data:Binding<Data?>) {
            _presentationMode = presentationMode
            _image = image
            _data = data
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
                presentationMode.dismiss()
                return
            }
            image = Image(uiImage: uiImage)
            data = uiImage.pngData()
            presentationMode.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image, data: $data)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

}
