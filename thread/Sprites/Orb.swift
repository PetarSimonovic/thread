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
        orb += 1
        print("Orb added")
        let staticOrb = SKSpriteNode()
        staticOrb.size = CGSize(width: 10, height: 10)
        staticOrb.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        staticOrb.physicsBody?.categoryBitMask = CollisionBitMask.orbitCategory
        staticOrb.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory
        staticOrb.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory
        staticOrb.physicsBody?.isDynamic = false

      //  orb.physicsBody?.linearDamping = 0.0 // simulates air friction (value between 0 and 1)
       // orb.physicsBody?.restitution = 0.0 // how much energy object loses when it hits another (value between 0 and 1)
        
        // Add collision masks
        let orbOrbit = SKNode()
        orbOrbit.position = seed.position
        orbOrbit.name = "orbOrbit"
        staticOrb.name = "staticOrb"
        staticOrb.position = CGPoint(x: 20, y: 20)
       // bolo.setScale(0.5)
        addChild(orbOrbit)
        orbOrbit.addChild(staticOrb)
        let rotate = SKAction.rotate(byAngle: CGFloat(0.5), duration: TimeInterval(0.1))
        orbOrbit.run(SKAction.repeatForever(rotate))
        if let orbParticles = SKEmitterNode(fileNamed: "firefly") {
            staticOrb.addChild(orbParticles)
        }

              
    }
    
    func launchOrb(_ position: CGPoint, _ tap: Bool) {
        orb -= 1
        print("launching Orb")
        let dynamicOrb = SKSpriteNode(imageNamed: "bolo")
        dynamicOrb.size = CGSize(width: 10, height: 10)
        dynamicOrb.physicsBody = SKPhysicsBody(circleOfRadius: 5)
      //  orb.physicsBody?.linearDamping = 0.0 // simulates air friction (value between 0 and 1)
       // orb.physicsBody?.restitution = 0.0 // how much energy object loses when it hits another (value between 0 and 1)
        
        // Add collision masks
        dynamicOrb.physicsBody?.categoryBitMask = CollisionBitMask.orbCategory
        dynamicOrb.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory
        dynamicOrb.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory
        dynamicOrb.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        dynamicOrb.physicsBody?.restitution = 1.0
        dynamicOrb.physicsBody?.isDynamic = true
        //dynamicOrb.physicsBody?.mass = CGFloat(100)
        dynamicOrb.position = position
        dynamicOrb.name = "dynamicOrb"
        dynamicOrb.physicsBody?.linearDamping = 0.3 // simulates air friction (value between 0 and 1)
      //  dynamicOrb.physicsBody?.restitution = 1.0
        dynamicOrb.physicsBody?.friction = 0

        addChild(dynamicOrb)
        if let orbParticles = SKEmitterNode(fileNamed: "firefly") {
            dynamicOrb.addChild(orbParticles)
        }
        if tap == true {
            print("tapped!")
            dynamicOrb.physicsBody?.applyForce(CGVector(dx: 100, dy: 5.5))
            //dynamicOrb.physicsBody?.velocity = CGVector(dx: 00, dy: 100)
         //  dynamicOrb.physicsBody?.applyTorque(CGFloat(1000))


        }
        print(orb)

    }
    
    func throwOrb () {
        print(orb)
        
        print ("throwing!")
        
        
        if orb > 0 {
        let orbOrbit = childNode(withName: "orbOrbit")
        if orbOrbit != nil {
          orbOrbit?.removeAllActions()
            let rotate = SKAction.rotate(byAngle: 5, duration: 0.2)
            let position = (orbOrbit?.position)!
            let remove = SKAction.removeFromParent()
            let launch = SKAction.run({ self.launchOrb(position, true) })
            let sequence = SKAction.sequence([rotate, remove, launch])
            orbOrbit?.run(sequence)
                }
        }
 
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
        
        }))

    }
    
    func removeOrbs() {

     enumerateChildNodes(withName: "dynamicOrb", using: ({
        (node, error) in
        let orb = node as! SKSpriteNode
        if orb.position.y < 0 {
            //print(bg.position.x)
            orb.removeFromParent()
          //  bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y: bg.position.y)
      //      print(self.distance)
        //    print("rock position \(rock.position)")
        }
    }))
        
    }


}





