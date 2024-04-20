//
//  FYPButtonStyles.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI

struct FYPPressable: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .edgesIgnoringSafeArea(.all)
            .background(configuration.isPressed ? FYPColor.backgroundDark.opacity(0.3) : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
