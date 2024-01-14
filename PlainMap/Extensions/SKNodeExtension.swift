//
//  SKNodeExtension.swift
//  PlainMap
//
//  Created by David Dvořák on 14.01.2024.
//

import SpriteKit

extension SKNode {
    func scale(to screenSize: CGSize, width: Bool, multiplier: CGFloat) {
        let scale = width ? 
            (screenSize.width * multiplier) / self.frame.size.width
            :
            (screenSize.height * multiplier) / self.frame.size.height
        self.setScale(scale)
    }
}
