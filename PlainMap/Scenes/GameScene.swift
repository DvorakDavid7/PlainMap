//
//  GameScene.swift
//  PlainMap
//
//  Created by David Dvořák on 14.01.2024.
//

import SpriteKit

class GameScene: SKScene {
    
    var tileMap: SKTileMapNode!
    var player: Player!
    
    override func didMove(to view: SKView) {
        loadMap()
    }
    
    func loadMap() {
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        
        tileMap = childNode(withName: "TileMap") as? SKTileMapNode
        tileMap.scale(to: frame.size, width: false, multiplier: 1.0)
        
        player = Player(color: .red, size: CGSize(width: 100, height: 200))
        player.physicsBody = SKPhysicsBody(rectangleOf: player.size)
        player.physicsBody?.isDynamic = true
        player.physicsBody?.affectedByGravity = true
        player.physicsBody?.friction = 10
        addChild(player)
        
        let joyStick = Joystick(baseRadius: 100.0, handleRadius: 50.0)
        joyStick.delegate = self
        joyStick.position = CGPoint(x: -size.width/4, y: -size.height/4)
        addChild(joyStick)
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func update(_ currentTime: TimeInterval) {
        simulateFriction()
    }
    
    func simulateFriction() {
        if let velocity = player.physicsBody?.velocity {
            // Apply a friction force opposite to the velocity direction
            let friction = 2.0
            let frictionForce = CGVector(dx: -velocity.dx * friction, dy: -velocity.dy * friction)
            player.physicsBody?.applyForce(frictionForce)
        }
    }
}


extension GameScene: JoystickDelegate {
    func joystickMoved(_ joystick: Joystick, position: CGVector) {
        if (tileMap.hasActions()) {
            return
        }
        player.physicsBody?.applyForce(position)
    }
}
