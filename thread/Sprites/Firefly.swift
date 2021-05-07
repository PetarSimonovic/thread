//
//  firefly.swift
//  thread
//
//  Created by Petar Simonovic on 06/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    
   func addFireFly() {
    if Int.random(in: 1..<60) == 1 {
        print("Firefly!")
        let firefly = SKSpriteNode(imageNamed: "firefly")
        firefly.physicsBody = SKPhysicsBody(circleOfRadius: 10)
        firefly.physicsBody?.categoryBitMask = CollisionBitMask.fireflyCategory
        firefly.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory
        firefly.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory
        firefly.physicsBody?.isDynamic = false
        firefly.physicsBody?.affectedByGravity = false
        let fireflyheight = CGFloat.random(in: -50.00...50.00)
        firefly.position = CGPoint(x: self.frame.midX +  (self.frame.width/2), y: self.frame.midY + fireflyheight )
          firefly.name = "firefly"
        self.addChild(firefly)
        firefly.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
        firefly.setScale(0.1)
        let time = Float.random(in: (0.5...1))
        let spin = [Double.pi, -Double.pi].randomElement()!
        let rotate = SKAction.rotate(byAngle: CGFloat(spin), duration: TimeInterval(time))
        firefly.run(SKAction.repeatForever(rotate))
    }
    }
    
    func moveFireFlies() {
    
    enumerateChildNodes(withName: "firefly", using: ({
        (node, error) in
        let firefly = node as! SKSpriteNode
        firefly.position = CGPoint(x: firefly.position.x - 0.5, y: firefly.position.y)
      //  print("Firefly position: \(firefly.position)")

        if firefly.position.x <= -self.frame.width * 2 {
            firefly.removeFromParent()
            print("Firefly removed")
        }
    }))
        
    }
    
    func disperseFireFlies() {
        if let fireflyDisperse = SKEmitterNode(fileNamed: "firefly2") {
          fireflyDisperse.position = seed.position
          addChild(fireflyDisperse)
          addOrb()
        
        }
    }
    
    
}
