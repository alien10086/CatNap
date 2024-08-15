//
//  GameScene.swift
//  CatNap Shared
//
//  Created by 李国政 on 2024/8/15.
//

import SpriteKit

class GameScene: SKScene {
    fileprivate var label: SKLabelNode?
    fileprivate var spinnyNode: SKShapeNode?

    class func newGameScene() -> GameScene {
        // Load 'GameScene.sks' as an SKScene.
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }

        // Set the scale mode to scale to fit the window
        scene.scaleMode = .aspectFill

        return scene
    }

    func setUpScene() {
        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }

        // Create shape node to use during mouse interaction
        let w = (size.width + size.height) * 0.05
        spinnyNode = SKShapeNode(rectOf: CGSize(width: w, height: w), cornerRadius: w * 0.3)

        if let spinnyNode = spinnyNode {
            spinnyNode.lineWidth = 4.0
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }

    override func didMove(to view: SKView) {
        setUpScene()
        // 1. 强制重新渲染
//        在某些情况下，设置 isPaused 属性为 true 会暂停场景的更新和渲染，而将其设置为 false 后，会强制重新启动渲染过程。这种方式可以确保场景及其动画正确地开始更新。由于 SKView 在场景加载后可能没有立即更新，因此通过这种方式可以强制场景重新渲染。
//
//        2. 触发内部刷新
//        在暂停并恢复视图的过程中，可能会触发一些内部刷新逻辑，确保所有的动画和渲染操作被正确初始化。isPaused 属性的变化可能会引发内部的更新和检查，确保动画能够正常启动。
//
//        3. 解决渲染延迟
//        有时，场景加载和视图显示过程中可能存在渲染延迟或状态同步问题。通过暂时暂停视图并恢复，可以解决这种延迟，确保所有节点和动画在渲染时能够正常工作。
//
//        4. 处理视图更新问题
//        在某些情况下，视图可能需要强制刷新以应用最新的状态。设置 isPaused 可能会触发视图的刷新和重新绘制，解决了动画不立即显示的问题。
        view.isPaused = true
        view.isPaused = false

//        if let sksPath = Bundle.main.path(forResource: "Cat", ofType: "sks"),
//           let scene = SKScene(fileNamed: "Cat") {
//
//            // 假设动画定义在某个子节点上，比如一个 SKSpriteNode
//            if let animatedNode = scene.childNode(withName: "AnimatedNode") as? SKSpriteNode {
//
//                // 获取在 sks 文件中定义的动画动作
//                if let animateAction = SKAction(named: "animateAction") {
//                    // 运行动画
//                    animatedNode.run(animateAction)
//                }
//            }
//        }
    }

    func makeSpinny(at pos: CGPoint, color: SKColor) {
        if let spinny = spinnyNode?.copy() as! SKShapeNode? {
            spinny.position = pos
            spinny.strokeColor = color
            addChild(spinny)
        }
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

#if os(iOS) || os(tvOS)
    // Touch-based event handling
    extension GameScene {
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            if let label = label {
                label.run(SKAction(named: "Pulse")!, withKey: "fadeInOut")
            }

            for t in touches {
                makeSpinny(at: t.location(in: self), color: SKColor.green)
            }
        }

        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches {
                makeSpinny(at: t.location(in: self), color: SKColor.blue)
            }
        }

        override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches {
                makeSpinny(at: t.location(in: self), color: SKColor.red)
            }
        }

        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            for t in touches {
                makeSpinny(at: t.location(in: self), color: SKColor.red)
            }
        }
    }
#endif

#if os(OSX)
    // Mouse-based event handling
    extension GameScene {
        override func mouseDown(with event: NSEvent) {
            if let label = label {
                label.run(SKAction(named: "Pulse")!, withKey: "fadeInOut")
            }
            makeSpinny(at: event.location(in: self), color: SKColor.green)
        }

        override func mouseDragged(with event: NSEvent) {
            makeSpinny(at: event.location(in: self), color: SKColor.blue)
        }

        override func mouseUp(with event: NSEvent) {
            makeSpinny(at: event.location(in: self), color: SKColor.red)
        }
    }
#endif
