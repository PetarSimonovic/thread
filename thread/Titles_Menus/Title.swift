//
//  Title.swift
//  thread
//
//  Created by Petar Simonovic on 06/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    

    
    func displayTitle() -> SKSpriteNode {
        title = SKSpriteNode(imageNamed: "threadtitle")
        title.position = CGPoint(x: self.frame.midX, y:self.frame.midY + 50)
        title.setScale(0.8)
        title.name = "title"
        
        return title
        
    }
    
    func removeTitle() {
        let fade = SKAction.fadeOut(withDuration: 3)
        title.run(fade)
    }
    
    
}
