//
//  PassionColorPickerView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 24/05/24.
//

import Meteor
import SwiftUI

struct PassionColorPickerView: View {

    var selectedColor: Color
    var onColorSelection: ((Color) -> Void)

    private let colors: [Color] = Color.mGetPalette(.rainbow)

    var body: some View {
        Group {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 72))]) {
                    ForEach(colors.indices) { index in
                        let color = colors[index]
                        Button {
                            onColorSelection(color)
                        } label: {
                            RoundedRectangle(cornerRadius: 16)
                                .fill(color)
                                .stroke(Color.mBorder, lineWidth: 2)
                                .frame(width: 48, height: 64)
                                .padding(12)
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
        }
        .background(Color.mBackground)
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 20) {
//                ForEach(colors, id: \.self) { color in
//                    Button{
//                        onColorSelection(color)
//                    } label: {
//                        Circle()
//                            .fill(color)
//                            .frame(width: 50, height: 50)
//                            .overlay(
//                                Circle()
//                                    .stroke(Color.white, lineWidth: self.selectedColor == color ? 3 : 0)
//                            )
//                    }
//                }
//            }
//            .padding()
//        }
    }
}

#if DEBUG
#Preview {
    PassionColorPickerView(
        selectedColor: Color.red,
        onColorSelection: { _ in }
    )
}
#endif
