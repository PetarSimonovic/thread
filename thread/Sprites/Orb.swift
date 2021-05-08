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
        let orb = SKSpriteNode()
        orb.size = CGSize(width: 10, height: 10)
      //  orb.physicsBody?.linearDamping = 0.0 // simulates air friction (value between 0 and 1)
       // orb.physicsBody?.restitution = 0.0 // how much energy object loses when it hits another (value between 0 and 1)
        
        // Add collision masks
        let orbOrbit = SKNode()
        orbOrbit.position = seed.position
        orbOrbit.name = "orbOrbit"
        orb.name = "orb"
        orb.position = CGPoint(x: 20, y: 20)
       // bolo.setScale(0.5)
        addChild(orbOrbit)
        orbOrbit.addChild(orb)
        let rotate = SKAction.rotate(byAngle: CGFloat(0.5), duration: TimeInterval(0.1))
        orbOrbit.run(SKAction.repeatForever(rotate))
        print(orb)
        print(orbOrbit)
        print(seed)
        if let orbParticles = SKEmitterNode(fileNamed: "firefly") {
            orb.addChild(orbParticles)
        }

              
    }
    
    func launchOrb() {
        let dynamicOrb = SKSpriteNode()
        dynamicOrb.size = CGSize(width: 10, height: 10)
        dynamicOrb.physicsBody = SKPhysicsBody(circleOfRadius: 5)
      //  orb.physicsBody?.linearDamping = 0.0 // simulates air friction (value between 0 and 1)
       // orb.physicsBody?.restitution = 0.0 // how much energy object loses when it hits another (value between 0 and 1)
        
        // Add collision masks
        dynamicOrb.physicsBody?.categoryBitMask = CollisionBitMask.orbCategory
        dynamicOrb.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory
        dynamicOrb.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory | CollisionBitMask.canyonCategory | CollisionBitMask.fireflyCategory
        dynamicOrb.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        dynamicOrb.physicsBody?.isDynamic = true
        dynamicOrb.physicsBody?.density = CGFloat(100)
        dynamicOrb.position = seed.position
        dynamicOrb.name = "dynamicOrb"
       // bolo.setScale(0.5)
        addChild(dynamicOrb)
        if let orbParticles = SKEmitterNode(fileNamed: "firefly") {
            dynamicOrb.addChild(orbParticles)
        }
        dynamicOrb.physicsBody?.velocity = CGVector(dx: 200, dy: 100)
        let velocity = CGFloat((seed.physicsBody?.velocity.dy)!)
        print(velocity)
        dynamicOrb.physicsBody?.velocity = CGVector(dx: velocity * 3, dy: velocity)
        dynamicOrb.physicsBody?.applyForce(CGVector(dx: velocity * 3, dy: velocity))

    }
    
    func throwOrb () {
        
        print ("throwing!")
        
        
        enumerateChildNodes(withName: "orbOrbit", using: ({
            (node, error) in
            let orb = node
            orb.position = self.seed.position
            orb.removeFromParent()
            self.launchOrb()
                //print(bg.position.x)          //      print(self.distance)
            //    print("rock position \(rock.position)")
        
        }))
                          // print(orb.position)
             
   
           // orb.position = CGPoint(x: orb.position.x + 1.5, y: orb.position.y)
          //  orb.physicsBody?.velocity = CGVector(dx: 100, dy: 100)
          //  orb.physicsBody?.applyTorque(CGFloat(0.1))
      //      orb.physicsBody?.applyForce(CGVector(dx: 100.5, dy: 100.5))

       // print(orb.position)
      //  orb.physicsBody?.applyTorque(CGFloat(0.1))
  //      orb.physicsBody?.applyForce(CGVector(dx: 100.5, dy: 100.5))


    
  }
    
    func moveOrb () {
        
       // print ("moving!")

        enumerateChildNodes(withName: "orbOrbit", using: ({
            (node, error) in
            let orb = node
            orb.position = self.seed.position
                //print(bg.position.x)          //      print(self.distance)
            //    print("rock position \(rock.position)")
        
        }))       // orb.position = CGPoint(x: orb.position.x + 1.5, y: orb.position.y)
      //  orb.physicsBody?.velocity = CGVector(dx: 100, dy: 100)
     //  orbOrbit.physicsBody?.applyImpulse(CGVector(dx: 5, dy: 5))
      //  orb.physicsBody?.applyTorque(CGFloat(0.1))
    //      orb.physicsBody?.applyForce(CGVector(dx: 100.5, dy: 100.5))



    }

}




