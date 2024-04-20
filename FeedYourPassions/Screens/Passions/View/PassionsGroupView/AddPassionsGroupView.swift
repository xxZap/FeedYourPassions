//
//  AddPassionsGroupView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 20/04/24.
//

import SwiftUI

struct AddPassionsGroupView: View {
    let action: (() -> Void)

    var body: some View {
        Button(
            action: { action() },
            label: {
                Text("New Group")
                    .font(.body.weight(.semibold))
                    .foregroundStyle(FYPColor.lightText)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                    .background {
                        Capsule()
                            .strokeBorder(FYPColor.lightText, style: StrokeStyle(lineWidth: 2, dash: [6]))
                    }
            }
        )
        .buttonStyle(FYPPressable())
    }
}

#if DEBUG
#Preview("\(AddPassionsGroupView.self)") {
    VStack {
        Spacer()
        AddPassionsGroupView() {
        }
        Spacer()
    }
    .background(FYPColor.background)
}
#endif
