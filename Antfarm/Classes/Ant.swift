//
//  Ant.swift
//  Antfarm
//
//  Created by Ben Anding on 3/1/22.
//

import Foundation
import SpriteKit

let dirmap: [String: CGPoint] = [  "ul": CGPoint(x: -1, y: 1),
                                   "uu": CGPoint(x: 0, y: 1),
                                   "ur": CGPoint(x: 1, y: 1),
                                   "rr": CGPoint(x: 1, y: 0),
                                   "nm": CGPoint(x: 0, y: 0),
                                   "dr": CGPoint(x: 1, y: -1),
                                   "dd": CGPoint(x: 0, y: -1),
                                   "dl": CGPoint(x: -1, y: -1),
                                   "ll": CGPoint(x: -1, y: 0)
                                ]



class Ant {
    let ant = SKSpriteNode(imageNamed: "ant")
    var id: UUID
    var dir: String
    var facing: CGPoint
    init(xPos: CGFloat, yPos: CGFloat) {
        self.ant.position.x = xPos
        self.ant.position.y = yPos
        self.id = UUID.init()
        self.dir = "ul"
        self.facing = dirmap[self.dir]!
    }
    func getPos() -> CGPoint {
        return self.ant.position
    }
    
    func setDir(newDir: String) {
        self.facing = dirmap[newDir]!
        self.dir = newDir
    }
    
    func move() {
        if (((-480 < self.ant.position.x + facing.x) && (self.ant.position.x + facing.x < 480)) && ((-160 < self.ant.position.y + facing.y) && (self.ant.position.y + facing.y < 160))) {
            self.ant.position = CGPoint(x: self.ant.position.x + facing.x, y: self.ant.position.y + facing.y)
        }
    }
    
    func getAnt() -> SKSpriteNode {
        return self.ant
    }
    
    func turnRight() {
        switch self.dir {
            case "ul":
                self.setDir(newDir: "uu")
                break
            case "uu":
                self.setDir(newDir: "ur")
                break
            case "ur":
                self.setDir(newDir: "rr")
                break
            case "rr":
                self.setDir(newDir: "dr")
                break
            case "dl":
                self.setDir(newDir: "ll")
                break
            case "dr":
                self.setDir(newDir: "dd")
                break
            case "dd":
                self.setDir(newDir: "dl")
                break
            case "ll":
                self.setDir(newDir: "ul")
                break
            default:
                self.setDir(newDir: "nm")
        }
    }

    func turnLeft() {
        switch self.dir {
            case "ul":
                self.setDir(newDir: "ll")
                break
            case "uu":
                self.setDir(newDir: "ul")
                break
            case "ur":
                self.setDir(newDir: "uu")
                break
            case "rr":
                self.setDir(newDir: "ur")
                break
            case "dl":
                self.setDir(newDir: "dd")
                break
            case "dr":
                self.setDir(newDir: "rr")
                break
            case "dd":
                self.setDir(newDir: "dr")
                break
            case "ll":
                self.setDir(newDir: "dl")
                break
            default:
                self.setDir(newDir: "nm")
        }
    }
    
    func switchItUp() {
        let random = Int(arc4random() % 8)
        self.setDir(newDir: Array(dirmap.keys)[random])
    }
}
