//
//  File.swift
//  thread
//
//  Created by Petar Simonovic on 06/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func createBolo() {
        print("Bolo addad")
        let bolo = SKSpriteNode(imageNamed: "bolo")
        bolo.physicsBody = SKPhysicsBody(texture: bolo.texture!, size: bolo.size)
        bolo.size = CGSize(width: 10, height: 10)
        bolo.physicsBody?.linearDamping = 0.0 // simulates air friction (value between 0 and 1)
        bolo.physicsBody?.restitution = 0.0 // how much energy object loses when it hits another (value between 0 and 1)
        
        // Add collision masks
                bolo.physicsBody?.categoryBitMask = CollisionBitMask.boloCategory
        bolo.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory
        bolo.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory | CollisionBitMask.fireflyCategory
        bolo.physicsBody?.affectedByGravity = true
        bolo.physicsBody?.isDynamic = true
        bolo.name = "bolo"
       // bolo.setScale(0.5)
        
        addChild(bolo)
       // seed.addChild(bolo)
        bolo.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        bolo.position = CGPoint(x: seed.position.x + 20, y: seed.position.y + 20 )
    }
    
    func throwBolo () {
        
        print ("throwing!")
    
    enumerateChildNodes(withName: "bolo", using: ({
            (node, error) in
       let bolo = node as! SKSpriteNode
        bolo.physicsBody?.velocity = CGVector(dx: 100, dy: 100)
        bolo.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
        bolo.physicsBody?.applyTorque(CGFloat(0.1))
        bolo.physicsBody?.applyForce(CGVector(dx: 100.5, dy: 100.5))

            }))


    
  }

}
