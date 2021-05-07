//
//  File.swift
//  thread
//
//  Created by Petar Simonovic on 06/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func addOrb() {
        print("Bolo addad")
        let orb = SKSpriteNode(imageNamed: "bolo")
        orb.size = CGSize(width: 10, height: 10)
        orb.physicsBody = SKPhysicsBody(circleOfRadius: 5)
      //  orb.physicsBody?.linearDamping = 0.0 // simulates air friction (value between 0 and 1)
       // orb.physicsBody?.restitution = 0.0 // how much energy object loses when it hits another (value between 0 and 1)
        
        // Add collision masks
        orb.physicsBody?.categoryBitMask = CollisionBitMask.orbCategory
        orb.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory
        orb.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory | CollisionBitMask.fireflyCategory
        orb.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        orb.physicsBody?.isDynamic = true
        orb.physicsBody?.affectedByGravity = false
        orb.physicsBody?.mass = CGFloat(-10.0)
        let orbOrbit = SKNode()
        orbOrbit.position = CGPoint(x: self.frame.midX, y: self.frame.midY)

        orb.name = "orb"
       orb.position = CGPoint(x: orbOrbit.position.x/9, y: orbOrbit.position.y/9)
        self.addChild(orbOrbit)
       // bolo.setScale(0.5)
        orbOrbit.addChild(orb)
        let rotate = SKAction.rotate(byAngle: CGFloat(0.5), duration: TimeInterval(0.1))
        orbOrbit.run(SKAction.repeatForever(rotate))
        print(orb)
        print(orbOrbit)
        print(seed)
       // seed.addChild(bolo)
      
    }
    
    func throwOrb () {
        
        print ("throwing!")
    
    enumerateChildNodes(withName: "orb", using: ({
            (node, error) in
       let orb = node as! SKSpriteNode
        print(orb.position)
       // orb.position = CGPoint(x: orb.position.x + 1.5, y: orb.position.y)
      //  orb.physicsBody?.velocity = CGVector(dx: 100, dy: 100)
       orb.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 5))
      //  orb.physicsBody?.applyTorque(CGFloat(0.1))
  //      orb.physicsBody?.applyForce(CGVector(dx: 100.5, dy: 100.5))

            }))


    
  }

}
