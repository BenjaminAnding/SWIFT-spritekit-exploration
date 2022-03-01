//
//  GameScene.swift
//  Antfarm
//
//  Created by Ben Anding on 3/1/22.
//

import SpriteKit

class GameScene: SKScene {
    
    var ants: [Ant] = []
    var ticker: Int = 0

    
    override func didMove(to view: SKView) {
        for _ in 0...10 {
            let newAnt = Ant(xPos: 0, yPos: 0)
            ants.append(newAnt)
        }
        for ant in ants {
            self.addChild(ant.getAnt())
        }
    }

    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        ticker += 1
        
        for ant in ants {
            ant.move()
            if ticker % 10 == 0 {
                ant.switchItUp()
                ticker = 0
            }
        }
    }
}


// A33E """" """" """"
// 1010001100111110 """""""""""""""" """""""""""""""" """"""""""""""""
