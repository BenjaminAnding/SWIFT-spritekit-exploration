//
//  GameScene.swift
//  Antfarm
//
//  Created by Ben Anding on 3/1/22.
//

import SpriteKit
import GameKit
import Carbon.HIToolbox

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var rect : SKShapeNode?
    private var ants: [Ant] = []
    private var selectedAnts: [Ant] = []
    private var ticker: Int = 0
    private var startRect = CGPoint (x: 0, y: 0)
    private var endRect = CGPoint (x: 0, y: 0)
    private var flag: Bool = false
    var leftPressed = false
    var rightPressed = false
    var upPressed = false
    var downPressed = false
    var plusPressed = false
    var minusPressed = false
    
    let cameraNode = SKCameraNode()
    
    
    
    override func keyDown(with event: NSEvent) {
        switch Int(event.keyCode) {
        case kVK_LeftArrow:
            leftPressed = true
        case kVK_RightArrow:
            rightPressed = true
        case kVK_UpArrow:
            upPressed = true
        case kVK_DownArrow:
            downPressed = true
        case kVK_ANSI_Minus:
            minusPressed = true
        case kVK_ANSI_Equal:
            plusPressed = true
        default:
            break
        }
    }

    override func keyUp(with event: NSEvent) {
        switch Int(event.keyCode) {
        case kVK_LeftArrow:
            leftPressed = false
        case kVK_RightArrow:
            rightPressed = false
        case kVK_UpArrow:
            upPressed = false
        case kVK_DownArrow:
            downPressed = false
        case kVK_ANSI_Minus:
            minusPressed = false
        case kVK_ANSI_Equal:
            plusPressed = false
        default:
            break
        }
    }
    
    override func didMove(to view: SKView) {
        cameraNode.position = CGPoint(x: 0,
                                      y: 0)
        self.physicsWorld.gravity = .zero
        self.physicsWorld.contactDelegate = self
        self.addChild(cameraNode)
        self.camera = cameraNode
        for _ in 0...25 {
            let newAnt = Ant(xPos: -100, yPos: 0, shape: "ant", color: .green)
            ants.append(newAnt)
        }
        for _ in 0...25 {
            let newAnt = Ant(xPos: 100, yPos: 0, shape: "ant", color: .red)
            ants.append(newAnt)
        }
        for ant in self.ants {
            self.addChild(ant.getAnt())
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let antA = getAntByName(name: (contact.bodyA.node?.name)!)
        let antB = getAntByName(name: (contact.bodyB.node?.name)!)
        if antA?.ant.color != antB?.ant.color {
            antA?.die(mod: 2)
            antB?.die(mod: 2)
        }
        
    }
    
    func getAntByName(name: String) -> Ant? {
        for ant in ants {
            if ant.ant.name == name {
                return ant
            }
        }
        return nil
    }
    
    func rightTouchUp(atPoint pos : CGPoint) {
        for ant in self.selectedAnts {
            ant.pathTo(newDest: pos)
        }
        self.selectedAnts = []
    }

    func touchDown(atPoint pos : CGPoint) {
        self.startRect = pos
    }
    
    func touchUp(atPoint pos : CGPoint) {
        self.endRect = pos
        let w = (self.size.width + self.size.height) * 0.05
        self.rect = SKShapeNode.init(rectOf: CGSize.init(width: endRect.x - startRect.x, height: endRect.y - startRect.y), cornerRadius: w * 0.3)
        if let rect = self.rect {
            rect.lineWidth = 2.5
            
            rect.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
        rect!.position = CGPoint(x: (self.endRect.x + self.startRect.x) / 2, y: (self.endRect.y + self.startRect.y) / 2)
        self.addChild(rect!)
        for ant in self.ants {
            if ((ant.getAnt().position.x > self.startRect.x && ant.getAnt().position.x < self.endRect.x) && (ant.getAnt().position.y > self.startRect.y && ant.getAnt().position.y < self.endRect.y)) || ((ant.getAnt().position.x < self.startRect.x && ant.getAnt().position.x > self.endRect.x) && (ant.getAnt().position.y > self.startRect.y && ant.getAnt().position.y < self.endRect.y)) || ((ant.getAnt().position.x > self.endRect.x && ant.getAnt().position.x < self.startRect.x) && (ant.getAnt().position.y > self.endRect.y && ant.getAnt().position.y < self.startRect.y)) || ((ant.getAnt().position.x < self.endRect.x && ant.getAnt().position.x > self.startRect.x) && (ant.getAnt().position.y > self.endRect.y && ant.getAnt().position.y < self.startRect.y)) {
                self.selectedAnts.append(ant)
            }
        }
    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func rightMouseUp(with event: NSEvent) {
        self.rightTouchUp(atPoint: event.location(in: self))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        ticker += 1
        for ant in self.ants {
            ant.move()
            if ticker % 10 == 0 {
                if ant.isPathing() {
                    ant.continuePathing()
                }
                else {
                    ant.switchItUp()
                }
            }
        }
        if ticker % 10 == 0 {
            ticker = 0
        }
        if leftPressed {
            cameraNode.position.x -= 10 * cameraNode.xScale
        }
        if rightPressed {
            cameraNode.position.x += 10 * cameraNode.yScale
        }
        if upPressed {
            cameraNode.position.y += 10 * cameraNode.yScale
        }
        if downPressed {
            cameraNode.position.y -= 10 * cameraNode.yScale
        }
        if minusPressed {
            cameraNode.xScale += 0.01
            cameraNode.yScale += 0.01
        }
        if plusPressed {
            if cameraNode.xScale > 0 && cameraNode.yScale > 0 {
                cameraNode.xScale -= 0.01
                cameraNode.yScale -= 0.01
            }
        }
    }
}


// A33E """" """" """"
// 1010001100111110 """""""""""""""" """""""""""""""" """"""""""""""""
