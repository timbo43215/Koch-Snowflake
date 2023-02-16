//
//  ContentView.swift
//  Koch Snowflake
//
//  Created by IIT PHYS 440 on 2/10/23.
//

import SwiftUI

struct KochSnowflakeView: View {
    @State private var depth: Int = 3
    let size: CGFloat
    
    init(depth: Int, size: CGFloat) {
        self.depth = depth
        self.size = size
    }
    
    var body: some View {
        Path { path in
            path.move(to: CGPoint(x: size * cos(0), y: size * sin(0)))
            for i in 1..<6 {
                let angle = .pi * 2 * Double(i) / 6
                let x = size * cos(angle)
                let y = size * sin(angle)
                path.addLine(to: CGPoint(x: x, y: y))
                drawKochSegment(&path, depth: depth, size: size / 3)
                path.addLine(to: CGPoint(x: size * cos(angle + .pi / 3), y: size * sin(angle + .pi / 3)))
            }
        }
        .stroke(Color.blue, lineWidth: 2)
    }
    
    func drawKochSegment(_ path: inout Path, depth: Int, size: CGFloat) {
        if depth == 0 {
            path.addLine(to: CGPoint(x: size * cos(.pi / 3), y: size * sin(.pi / 3)))
        } else {
            drawKochSegment(&path, depth: depth - 1, size: size / 3)
            path.addLine(to: CGPoint(x: size * cos(.pi / 3), y: size * sin(.pi / 3)))
            drawKochSegment(&path, depth: depth - 1, size: size / 3)
            path.addLine(to: CGPoint(x: size / 2 * cos(-.pi / 3), y: size / 2 * sin(-.pi / 3)))
            drawKochSegment(&path, depth: depth - 1, size: size / 3)
            path.addLine(to: CGPoint(x: size * cos(0), y: size * sin(0)))
            drawKochSegment(&path, depth: depth - 1, size: size / 3)
        }
    }
}

struct KochSnowflakeView_Previews: PreviewProvider {
    static var previews: some View {
        KochSnowflakeView(depth: 100, size: 200)
    }
}
