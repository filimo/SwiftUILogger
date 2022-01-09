//
//  Debug.swift
//  
//
//  Created by Viktor Kushnerov on 16.07.2020.
//  
//

import SwiftUI

extension View {
    public func debugGrid(
        topPadding: CGFloat = 0,
        leadingPadding: CGFloat = 0,
        spacing: CGFloat = 8,
        opacity: Double = 1
    ) -> some View {
        background(
            ZStack {
                HStack(spacing: spacing) {
                    ForEach(0 ..< 50) { _ in
                        Divider()
                    }
                }
                VStack(spacing: spacing) {
                    ForEach(0 ..< 150) { _ in
                        Divider()
                    }
                }
            }
            .opacity(opacity)
            .padding(.top, topPadding)
            .padding(.leading, leadingPadding)
        )
    }
}

extension View {
    public func debugAction(_ closure: () -> Void) -> Self {
        #if DEBUG
        closure()
        #endif

        return self
    }

    public func debugPrint(_ value: Any...) -> Self {
        debugAction { pp(value) }
    }

    public func debugModifier<T: View>(_ modifier: (Self) -> T) -> some View {
        #if DEBUG
        return modifier(self)
        #else
        return self
        #endif
    }
}

extension View {
    public func debugBorder(_ color: Color = .red, width: CGFloat = 1) -> some View {
        debugModifier {
            $0.border(color, width: width)
        }
    }

    public func debugBackground(_ color: Color = .red) -> some View {
        debugModifier {
            $0.background(color)
        }
    }
}

struct Debug_Previews: PreviewProvider {
    static var previews: some View {
        Text("Test")
            .debugGrid(topPadding: 3, spacing: 9)
    }
}
