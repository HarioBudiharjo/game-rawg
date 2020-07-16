//
//  ExtensionView.swift
//  Game Rawg
//
//  Created by Hario Budiharjo on 17/07/20.
//  Copyright © 2020 Hario Budiharjo. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    func resignKeyboardOnDragGesture() -> some View {
        return modifier(ResignKeyboardOnDragGesture())
    }
}
