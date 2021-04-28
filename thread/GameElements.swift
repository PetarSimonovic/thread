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
        seed.size = CGSize(width: 30, height: 30)
        seed.position = CGPoint(x: self.frame.midX, y:self.frame.midY)
        
        // Asign physics
        seed.physicsBody = SKPhysicsBody(circleOfRadius: seed.size.width/2)
        seed.physicsBody?.linearDamping = 1.1
        seed.physicsBody?.restitution = 0
        
        // Add collision masks
        
        seed.physicsBody?.categoryBitMask = CollisionBitMask.seedCategory
        seed.physicsBody?.collisionBitMask = CollisionBitMask.rockCategory
        seed.physicsBody?.contactTestBitMask = CollisionBitMask.rockCategory | CollisionBitMask.loopCategory
        
        seed.physicsBody?.affectedByGravity = false
        seed.physicsBody?.isDynamic = true
    
        return seed
    
        
    }
    
    func createRock() {
      let  element = Int.random(in: 1..<9)
    var rockGravity = false
        let rock = SKSpriteNode(imageNamed: "background_\(element)")
            rock.physicsBody = SKPhysicsBody(rectangleOf: rock.size)
            rock.physicsBody?.categoryBitMask = CollisionBitMask.rockCategory
            rock.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory
            rock.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory
            rock.physicsBody?.isDynamic = false
            if Int.random(in: 1..<10) == 5 {
              rockGravity = true
           }
            rock.physicsBody?.affectedByGravity = rockGravity
                rock.anchorPoint = CGPoint.init(x: 0, y: 0)
            //let height = CGFloat(arc4random() % UInt32(CGFloat(self.frame.height)))
                rock.position = CGPoint(x: CGFloat(1) * self.frame.width, y: -20)
                rock.name = "background"
              let randomScale = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
              rock.setScale(randomScale)
            //background.zRotation = CGFloat(M_PI_4)
              self.addChild(rock)
                rockNode += 1
          
            
            
            
            
        }
    
    func decelerate() {
        if acceleration >= 1 {
            acceleration -= 0.1
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
        gravityNode.strength = 1.5
        addChild(gravityNode)
    }
    
}

