//
//  ContentView.swift
//  vorobei-sui-5
//
//  Created by Alexey Voronov on 11.10.2023.
//

import SwiftUI

struct ContentView: View {
    let colors = [Color.white, .pink, .yellow, .black]
    
    @State var position: CGSize = .zero
    @State var startPosition: CGSize = .zero
    
    var rect: some View {
        RectangleView()
    }
    
    var body: some View {
        GeometryReader {val in
            ZStack {
                VStack(spacing: 0.0) {
                    ForEach(colors, id: \.description) { color in
                        color
                    }
                }
                rect
                    .blendMode(.difference)
                    .overlay(rect.blendMode(.hue))
                    .overlay(rect.foregroundColor(.white).blendMode(.colorBurn))
                    .overlay(rect.foregroundColor(.black).blendMode(.colorBurn))
                    .overlay(rect.foregroundColor(.black).blendMode(.overlay))
                    .overlay(rect.foregroundColor(.white).blendMode(.overlay))
                    .overlay(rect.foregroundColor(.white).blendMode(.colorBurn))
                    .overlay(rect.foregroundColor(.black).blendMode(.colorBurn))
                    .overlay(rect.foregroundColor(.black).blendMode(.overlay))
                    .overlay(rect.foregroundColor(.white).blendMode(.overlay))
                
                    .position(CGPoint(x: position.width, y: position.height))
                    .gesture(
                        DragGesture()
                            .onChanged({ gesture in
                                position = startPosition + gesture.translation
                            })
                            .onEnded({ geture in
                                startPosition = position
                            })
                    )
                
            }
            .ignoresSafeArea()
            .onAppear() {
                position = val.size / 2.0
                startPosition = position
            }
        }
    }
}


struct RectangleView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10.0)
            .frame(width: 100, height: 100)
            .foregroundColor(Color.init(white: 0.9))
    }
}

#Preview {
    ContentView()
}

extension CGSize {
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

extension CGSize {
    static func / (lhs: CGSize, rhs: Double) -> CGSize {
        guard rhs != 0 else {
            fatalError("Cannot divide by zero")
        }
        
        return CGSize(width: lhs.width / CGFloat(rhs), height: lhs.height / CGFloat(rhs))
    }
}
