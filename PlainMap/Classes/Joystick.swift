//
//  Joystick.swift
//  PlainMap
//
//  Created by David Dvořák on 14.01.2024.
//

import SpriteKit

protocol JoystickDelegate {
    func joystickMoved(_ joystick: Joystick, position: CGVector)
}

class Joystick: SKNode {
    
    private var baseRadius: CGFloat
    private var handleRadius: CGFloat
    private var baseSprite: SKShapeNode
    private var handleSprite: SKShapeNode
    private var isActive: Bool = false
    
    var delegate: JoystickDelegate?
    
    init(baseRadius: CGFloat, handleRadius: CGFloat) {
        self.baseRadius = baseRadius
        self.handleRadius = handleRadius
        
        // Create the joystick base (surrounding circle)
        baseSprite = SKShapeNode(circleOfRadius: baseRadius)
        baseSprite.strokeColor = .white
        baseSprite.lineWidth = 2.0
        
        // Create the joystick handle (filled circle)
        handleSprite = SKShapeNode(circleOfRadius: handleRadius)
        handleSprite.fillColor = .white
        handleSprite.strokeColor = .clear
        
        super.init()
        isUserInteractionEnabled = true
        addChild(baseSprite)
        addChild(handleSprite)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)

        // Check if the touch is inside the joystick base
        if baseSprite.contains(touchLocation) {
            isActive = true
            updatePosition(touchLocation)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, isActive else { return }
        let touchLocation = touch.location(in: self)
        updatePosition(touchLocation)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isActive else { return }
        isActive = false

        // Reset the handle position when touch ends
        handleSprite.position = CGPoint.zero
    }
    
    private func updatePosition(_ position: CGPoint) {
        let distance = position.distance(to: .zero)
        
        if distance > baseRadius {
            let angle = atan2(position.y, position.x)
            let x = baseRadius * cos(angle)
            let y = baseRadius * sin(angle)
            handleSprite.position = CGPoint(x: x, y: y)
            delegate?.joystickMoved(self, position: CGVector(dx: position.x, dy: position.y))
            
        } else {
            handleSprite.position = CGPoint(x: position.x, y: position.y)
            delegate?.joystickMoved(self, position: CGVector(dx: position.x, dy: position.y))
        }
    }
}
