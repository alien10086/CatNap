//
//  CatNode.swift
//  CatNap
//
//  Created by 李国政 on 2024/9/2.
//

import SpriteKit
class CatNode: SKSpriteNode, EventListenerNode {
    func didMoveToScene() {
        print("cat added to scene")
        let catBodyTexture = SKTexture(imageNamed: "cat_body_outline")
        parent!.physicsBody = SKPhysicsBody(texture: catBodyTexture,
                                            size: catBodyTexture.size())
    }
}
