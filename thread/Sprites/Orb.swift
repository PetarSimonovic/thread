//
//  File.swift
//  thread
//
//  Created by Petar Simonovic on 06/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func createOrb() {
        print("Bolo addad")
        let orb = SKSpriteNode(imageNamed: "bolo")
        orb.physicsBody = SKPhysicsBody(texture: orb.texture!, size: orb.size)
        orb.size = CGSize(width: 10, height: 10)
        orb.physicsBody?.linearDamping = 0.0 // simulates air friction (value between 0 and 1)
        orb.physicsBody?.restitution = 0.0 // how much energy object loses when it hits another (value between 0 and 1)
        
        // Add collision masks
                orb.physicsBody?.categoryBitMask = CollisionBitMask.boloCategory
        orb.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory
        orb.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory | CollisionBitMask.fireflyCategory
        orb.physicsBody?.affectedByGravity = true
        orb.physicsBody?.isDynamic = true
        orb.name = "orb"
       // bolo.setScale(0.5)
        
        self.addChild(orb)
       // seed.addChild(bolo)
        orb.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        orb.position = CGPoint(x: seed.position.x + 20, y: seed.position.y + 20 )
    }
    
    func throwOrb () {
        
        print ("throwing!")
    
    enumerateChildNodes(withName: "orb", using: ({
            (node, error) in
       let orb = node as! SKSpriteNode
        print(orb.position)
      //  orb.physicsBody?.velocity = CGVector(dx: 100, dy: 100)
        orb.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
      //  orb.physicsBody?.applyTorque(CGFloat(0.1))
     //   orb.physicsBody?.applyForce(CGVector(dx: 100.5, dy: 100.5))

            }))


    
  }

}
