//
//  seed.swift
//  thread
//
//  Created by Petar Simonovic on 06/05/2021.
//

import Foundation
import SpriteKit

class Seed {

   func createSeed() -> SKSpriteNode {
    // Assign image and position
    let seed = SKSpriteNode(imageNamed: "threadship")
    seed.size = CGSize(width: 20, height: 20)
    
    seed.physicsBody = SKPhysicsBody(texture: seed.texture!, size: seed.size)
   
    
    seed.physicsBody?.categoryBitMask = CollisionBitMask.seedCategory
    seed.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory
    seed.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory | CollisionBitMask.fireflyCategory
    
    seed.physicsBody?.linearDamping = 0.75 // simulates air friction (value between 0 and 1)
    seed.physicsBody?.restitution = 0.9 // how much energy object loses when it hits another (value between 0 and 1)
    seed.physicsBody?.affectedByGravity = false
    seed.physicsBody?.isDynamic = true
    if let seedParticles = SKEmitterNode(fileNamed: "threadship") {
        seedParticles.setScale(CGFloat(0.15))
        seed.addChild(seedParticles)
    }
    return seed
      
  }
}

    
// MOTION

    

// PHYSICS NOTES

// seed.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
//   seed.physicsBody?.applyImpulse(CGVector(dx:0, dy: 0))
//        } else {
//            if isDead == false {
//                        //OLD CODE
//                seed.physicsBody?.velocity = CGVector(dx: -0, dy: 0)

//                for touch in (touches) {
//                    print(touch)
//                    }
//                    let location = touch.location(in: self)
//                    if (location.x < self.size.width / 2) {
//                            isLeft = true
//                        seed.physicsBody?.velocity = CGVector(dx: -0.1, dy: 0.1)
//
//                        seed.physicsBody?.applyImpulse(CGVector(dx: -0, dy: 0.2))
//                        seed.physicsBody?.applyTorque(CGFloat(0.003))
//                        seed.physicsBody?.applyForce(CGVector(dx: -1, dy: 1.5))
//                        }
//
//                    if (location.x > self.size.width/2){
//                            isRight = true
//                        seed.physicsBody?.velocity = CGVector(dx: 0.3, dy: 0.3)
//                        seed.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0.2))
//                        seed.physicsBody?.applyTorque(CGFloat(-0.003))
//                        seed.physicsBody?.applyForce(CGVector(dx: 1, dy: 1.5))
//                        }
//                    }

//            }
//        }
