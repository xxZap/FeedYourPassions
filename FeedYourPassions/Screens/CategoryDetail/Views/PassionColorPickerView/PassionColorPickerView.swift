//
//  PassionColorPickerView.swift
//  FeedYourPassions
//
//  Created by Alessio Boerio on 24/05/24.
//

import Meteor
import SwiftUI

struct PassionColorPickerView: View {

    @State var selectedColor: Color
    var onCancel: () -> Void
    var onSave: ((Color) -> Void)

    private let colors: [Color] = Color.mGetPalette(.rainbow)

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 72))]) {
                    ForEach(colors.indices) { index in
                        let color = colors[index]
                        Button {
                            selectedColor = color
                        } label: {
                            ZStack(alignment: .center) {
                                let isSelected = isSelectedColor(color)
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(color)
                                    .stroke(
                                        isSelected ? Color.mAccent : Color.mBorder,
                                        lineWidth: isSelected ? 6 : 2
                                    )
                                    .frame(width: 48, height: 64)
                                    .padding(12)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 8)
            .background(Color.mBackground)
            .navigationTitle("Color")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        onCancel()
                    } label: {
                        Text("Cancel")
                    }
                    .tint(Color.mAccent)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        onSave(selectedColor)
                    } label: {
                        Text("Save")
                    }
                    .tint(Color.mAccent)
                }
            }
        }
    }

    // FIXME:
    // This terrible thing is due the fact the Color hex initializer
    // is creating a microscopic variant of the RGBA Color one
    // and, since the `selectedColor` is parsed from an hex string but
    // the `colors` are from RGBA, even if the color is the same they
    // have microscopic differences.
    // This function compares by approximating their components.
    private func isSelectedColor(_ color: Color) -> Bool {
        let selectedComponents: [CGFloat]? = selectedColor.cgColor?.components
        let components: [CGFloat]? = color.cgColor?.components

        let roundedSelectedComponents = selectedComponents?.map { String(format: "%.4f", $0) }
        let roundedComponents = components?.map { String(format: "%.4f", $0) }

        return roundedSelectedComponents == roundedComponents
    }
}

#if DEBUG
#Preview {
    PassionColorPickerView(
        selectedColor: Color.red,
        onCancel: { },
        onSave: { _ in }
    )
}
#endif
