//
//  GameViewController.swift
//  AngryBirdClone
//
//  Created by Pixelplus Interactive on 18.07.2022.
//

//GameScene içinden tasarım yapılabilir fakat genelde koddan yapılıyor.

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    private var orientations = UIInterfaceOrientationMask.landscapeRight//Uygulama ekran sola dönmüş olarak başlıyor.
       override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
           get { return self.orientations }
           set { self.orientations = newValue }
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = false
            view.showsNodeCount = false
            view.showsPhysics = false//Oyunu yayınlarken kullanmayız. Debug yaparken kullanılır. True ise sadece kuş tanımlandığı için etrafında bir çizgi gözükecek.
        }
    }
    

    override var shouldAutorotate: Bool {
        return true
    }

    /*override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }*/

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
