//
//  Score.swift
//  thread
//
//  Created by Petar Simonovic on 17/05/2021.
//

import Foundation
import SpriteKit

extension GameScene {
    
    
    func setScore() {
      print("Setting Score")
      scoreLabel.text = "Score: \(distance) | High: \(highScore)"
      scoreLabel.fontColor = UIColor(red: 85/255, green: 24/255, blue: 32/255, alpha: 1)
      scoreLabel.position = CGPoint(x: frame.minX, y: frame.maxY)
      scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
      scoreLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.top
      scoreLabel.fontSize = 10
      scoreLabel.zPosition = CGFloat(1.0)
      addChild(scoreLabel)
    }
    
}
