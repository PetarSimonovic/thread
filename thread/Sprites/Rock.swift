//
//  Rock.swift
//  thread
//
//  Created by Petar Simonovic on 06/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    func addRock() {
       let  element = Int.random(in: 1..<50)
        if element <= 6 && nodeCount < difficulty && isDead == false {
          let rock = SKSpriteNode(imageNamed: "rock_\(element)")
              rock.physicsBody = SKPhysicsBody(texture: rock.texture!, size: rock.texture!.size())
              rock.physicsBody?.categoryBitMask = CollisionBitMask.rockCategory
              rock.physicsBody?.collisionBitMask = CollisionBitMask.seedCategory | CollisionBitMask.rockCategory
              rock.physicsBody?.contactTestBitMask = CollisionBitMask.seedCategory | CollisionBitMask.rockCategory
              rock.physicsBody?.isDynamic = false
              rock.physicsBody?.affectedByGravity = false
            rock.anchorPoint = CGPoint.init(x: 0.5, y: 0.5)
            let height = CGFloat.random(in: -150.00...150.00)
            rock.position = CGPoint(x: CGFloat(1.5) * self.frame.width, y: self.frame.midY + height )
                  rock.name = "rock"
            let randomScale = CGFloat.random(in: (0.2 + distance/100)...(0.5))
                rock.setScale(randomScale)
                self.addChild(rock)
            let time = Float.random(in: (0.5...1))
            let spin = [Double.pi, -Double.pi].randomElement()!
            let rotate = SKAction.rotate(byAngle: CGFloat(spin), duration: TimeInterval(time))
            rock.run(SKAction.repeatForever(rotate))

               nodeCount += 1
    }
    }
    
    func moveRocks() {
    
    enumerateChildNodes(withName: "rock", using: ({
        (node, error) in
        let rock = node as! SKSpriteNode
        rock.position = CGPoint(x: rock.position.x - 1.5, y: rock.position.y)
        if rock.position.x <= -rock.size.width {
            //print(bg.position.x)
            rock.removeFromParent()
            self.nodeCount -= 1
          //  bg.position = CGPoint(x:bg.position.x + bg.size.width * 2, y: bg.position.y)
            print("Distance")
      //      print(self.distance)
        //    print("rock position \(rock.position)")
        }
    }))
        
    }

}
