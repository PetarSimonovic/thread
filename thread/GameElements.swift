//
//  GameElements.swift
//  thread
//
//  Created by Petar Simonovic on 23/04/2021.
//

import SpriteKit

struct CollisionBitMask {
    static let seedCategory:UInt32 = 0x1 << 0
    static let rockCategory:UInt32 = 0x1 << 1
    static let loopCategory:UInt32 = 0x1 << 2
    static let groundCategory:UInt32 = 0x1 << 3
}

extension GameScene {
    
    func createSeed() -> SKSpriteNode {
        // Assign image and position
        let seed = SKSpriteNode(imageNamed: "seed")
        seed.size = CGSize(width: 20, height: 20)
        seed.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        
        // Asign physics
        seed.physicsBody = SKPhysicsBody(texture: seed.texture!, size: seed.size)
        seed.physicsBody?.linearDamping = 0.5 // simulates air friction (value between 0 and 1)
        seed.physicsBody?.restitution = 0.3 // how much energy object loses when it hits another (value between 0 and 1)
        
        // Add collision masks
        
        seed.physicsBody?.categoryBitMask = CollisionBitMask.seedCategory
        seed.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory
        seed.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory | CollisionBitMask.loopCategory
        
        seed.physicsBody?.affectedByGravity = false
        seed.physicsBody?.isDynamic = true
    
        return seed
    
        
    }
    
    func createCanyon() {
     //topRock()
      bottomRock()
    }
    
    func topRock() {
       // let  element = Int.random(in: 1..<9)
          let rock = SKSpriteNode(imageNamed: "rocK_5")
              rock.physicsBody = SKPhysicsBody(texture: rock.texture!, size: rock.texture!.size())
              rock.physicsBody?.categoryBitMask = CollisionBitMask.rockCategory
              rock.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory
              rock.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory
              rock.physicsBody?.isDynamic = false
              rock.physicsBody?.affectedByGravity = false
              rock.anchorPoint = CGPoint.init(x: 0, y: 0)
              //let height = CGFloat(arc4random() % UInt32(CGFloat(self.frame.height)))
          rock.position = CGPoint(x: CGFloat(1) * self.frame.width, y: 400)
                  rock.name = "background"
                let randomScale = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
                rock.setScale(randomScale)
              //background.zRotation = CGFloat(M_PI_4)
                self.addChild(rock)
    }
    
    func bottomRock() {
       let  element = Int.random(in: 1..<100)
        if element <= 13 && nodeCount < 6 {
          let rock = SKSpriteNode(imageNamed: "rock_\(element)")
              rock.physicsBody = SKPhysicsBody(texture: rock.texture!, size: rock.texture!.size())
              rock.physicsBody?.categoryBitMask = CollisionBitMask.rockCategory
              rock.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory
              rock.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory
              rock.physicsBody?.isDynamic = false
              rock.physicsBody?.affectedByGravity = false
            rock.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
              let height = CGFloat(arc4random() % UInt32(CGFloat(self.frame.height)))
          rock.position = CGPoint(x: CGFloat(1) * self.frame.width, y: height )
                  rock.name = "rock"
                let randomScale = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
                rock.setScale(randomScale)
                self.addChild(rock)
            nodeCount += 1
    }
    }
    
    func decelerate() {
        if acceleration >= 1 {
            acceleration -= 0.2
        }
    }
    
    func accelerate() {
        if acceleration <= 10 {
            acceleration += 0.5
        }
    }
    
    
    func setGravity() {
        physicsWorld.gravity = CGVector(dx:0, dy: 0);
        let gravityVector = vector_float3(0,-1,0);
        let gravityNode = SKFieldNode.linearGravityField(withVector: gravityVector)
        gravityNode.strength = 0.8
        addChild(gravityNode)
    }
    
}

