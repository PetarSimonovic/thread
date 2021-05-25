//
//  Motion.swift
//  thread
//
//  Created by Petar Simonovic on 25/05/2021.
//

import Foundation
import SpriteKit


extension GameScene {
func seedThrust() {

    seed.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0.4))
    seed.physicsBody?.applyTorque(CGFloat(0.01))
  //  seed.physicsBody?.velocity = CGVector(dx: 0, dy: 90)
}

    
  func seedFlight() {
    if isLeft == true {
        seed.physicsBody?.applyForce(CGVector(dx: -0.3, dy: 0.2))
       // seed.physicsBody?.velocity = CGVector(dx: -50, dy: 50)

    }
    else if isRight == true {
        seed.physicsBody?.applyForce(CGVector(dx: 0.3, dy: 0.2))

        //seed.physicsBody?.velocity = CGVector(dx: 50, dy: 50)

    }

    
  }
}
