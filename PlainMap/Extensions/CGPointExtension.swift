//
//  CGPointExtension.swift
//  PlainMap
//
//  Created by David Dvořák on 14.01.2024.
//

import SpriteKit

extension CGPoint {
    func distance(to point: CGPoint) -> CGFloat {
        return abs(CGFloat(hypotf(Float(point.x - x), Float(point.y - y))))
    }
}

extension CGVector {
    func length() -> CGFloat {
        return sqrt(pow(self.dx, 2) + pow(self.dy, 2))
    }
}
