//
//  BedNode.swift
//  CatNap
//
//  Created by 李国政 on 2024/9/2.
//

import SpriteKit
class BedNode: SKSpriteNode,EventListenerNode {
    func didMoveToScene() {
        print("bed added to scene")
        let bedBodySize = CGSize(width: 40.0, height: 30.0)
        physicsBody = SKPhysicsBody(rectangleOf: bedBodySize)
        physicsBody!.isDynamic = false
    }
}
