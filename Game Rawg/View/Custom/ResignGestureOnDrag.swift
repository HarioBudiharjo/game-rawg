//
//  ResignGestureOnDrag.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 17/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation
import SwiftUI

struct ResignKeyboardOnDragGesture: ViewModifier {
    var gesture = DragGesture().onChanged{_ in
        UIApplication.shared.endEditing(true)
    }
    func body(content: Content) -> some View {
        content.gesture(gesture)
    }
}
