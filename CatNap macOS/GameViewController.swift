//
//  GameViewController.swift
//  CatNap macOS
//
//  Created by 李国政 on 2024/8/15.
//

import Cocoa
import SpriteKit
import GameplayKit

class GameViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene.newGameScene()
        
        // Present the scene
        let skView = self.view as! SKView
        skView.presentScene(scene)
        
        skView.ignoresSiblingOrder = false // 使得具有相同 zPosition 的节点按照添加到场景的顺序绘制, 副作用 降低性能
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.showsPhysics = true
    }

}

