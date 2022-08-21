//
//  GameScene.swift
//  AngryBirdClone
//
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //var bird2 = SKSpriteNode()
    
    var bird = SKSpriteNode()
    var box1 = SKSpriteNode()
    var box2 = SKSpriteNode()
    var box3 = SKSpriteNode()
    var box4 = SKSpriteNode()
    var box5 = SKSpriteNode()
    
    var gameStarted = false//Bu false is çekme işlemi yapılsın, değil ise yapılmasın.
    
    //MARK: Positions
    var originalPosition : CGPoint?//Kuşun ilk baştaki pozisyonunu atamak için kullanacağız.
    var box1Original : CGPoint?
    var box2Original : CGPoint?
    var box3Original : CGPoint?
    var box4Original : CGPoint?
    var box5Original : CGPoint?
    
    var score = 0
    var scoreLabel = SKLabelNode()
    
    enum ColliderType: UInt32 {//Enum'da kategoriler oluşturabiliyoruz.
        case Bird = 1
        case Box = 2//Bunun altına bir şey yazarsam içindeki değer 3 olamaz, 4 olacak. Çünkü üstündekilerin toplamını alttakilere veremeyiz.
    }
    
    override func didMove(to view: SKView) {
        //viewDidLoad gibi düşün. İlk başta yapılacak işlemler bu metot içinde yazılır.
        
        /*let texture = SKTexture(imageNamed: "bird")
        bird2 = SKSpriteNode(texture: texture)
        bird2.position = CGPoint(x: 0, y: 0)//Kuş tam ortada duracak. Çünkü x ve y'ye 0 atandı.
        bird2.size = CGSize(width: self.frame.width / 16, height: self.frame.height / 10)
        bird2.zPosition = 1
        self.addChild(bird2)*/
        
        //Physics Body
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)//Buraya frame yazınca total bir çerçeve oluştu. Yani ekran dışına taşma olmayacak. Gravity açıksa mesela kuş düşecek ama ekranın dışına çıkmayacak.
        self.scene?.scaleMode = .aspectFit
        self.physicsWorld.contactDelegate = self//Artık bizim kontakları algılama şansımız olacak. Yukarıdaki class'ta da SKPhysicsContactDelegate yazdık.
        
        //Bird
        
        bird = childNode(withName: "bird") as! SKSpriteNode//GameScene tarafında eklediğimiz kuşu buraya tanımladık.
        
        let birdTexture = SKTexture(imageNamed: "bird")
        
        //Bu physicsBody'yi ekleme sebebimiz diğer physicsBody'lerle çarpışmayı sağlamak. Aslında çarpışan şeyler görseller değil, onların physicsBody'leri.
        
        bird.physicsBody = SKPhysicsBody(circleOfRadius: birdTexture.size().height / 17)//Kuş, daire olduğu için circle of radius kullanıldı. Yani bir dairenin yarıçapı gibi.
        bird.physicsBody?.affectedByGravity = false//Kuş, yerçekiminden etkilenmeyecek olarak ayarlandı.
        bird.physicsBody?.isDynamic = true//Kuşu havaya atacağız, tutacağız vs. O yüzden bu true olacak.
        bird.physicsBody?.mass = 0.15//Kuşa kilo değeri girildi.
        originalPosition = bird.position
        
        bird.physicsBody?.contactTestBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.categoryBitMask = ColliderType.Bird.rawValue
        bird.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        //Box
        
        let boxTexture = SKTexture(imageNamed: "brick")
        let size = CGSize(width: boxTexture.size().width / 6, height: boxTexture.size().height / 6)
        
        box1 = childNode(withName: "box1") as! SKSpriteNode
        box1.physicsBody = SKPhysicsBody(rectangleOf: size)
        box1.physicsBody?.isDynamic = true
        box1.physicsBody?.affectedByGravity = true
        box1.physicsBody?.allowsRotation = true//Sağa sola dönebilir mi manasına geliyor. Dönmesini istiyoruz, bu yüzden true.
        box1.physicsBody?.mass = 0.4
        box1Original = box1.position
        
        //İki physicsBody'nin birbiriyle iletişim kurmasını istediğimizde collisionBitMask kullanıyoruz.
        box1.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue//Kutulara da bird atadım çünkü kuşla kutuların çarpışmasını istiyorum.
        
        box2 = childNode(withName: "box2") as! SKSpriteNode
        box2.physicsBody = SKPhysicsBody(rectangleOf: size)
        box2.physicsBody?.isDynamic = true
        box2.physicsBody?.affectedByGravity = true
        box2.physicsBody?.allowsRotation = true//Sağa sola dönebilir mi manasına geliyor. Dönmesini istiyoruz, bu yüzden true.
        box2.physicsBody?.mass = 0.4
        box2Original = box2.position
        
        box2.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box3 = childNode(withName: "box3") as! SKSpriteNode
        box3.physicsBody = SKPhysicsBody(rectangleOf: size)
        box3.physicsBody?.isDynamic = true
        box3.physicsBody?.affectedByGravity = true
        box3.physicsBody?.allowsRotation = true//Sağa sola dönebilir mi manasına geliyor. Dönmesini istiyoruz, bu yüzden true.
        box3.physicsBody?.mass = 0.4
        box3Original = box3.position
        
        box3.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box4 = childNode(withName: "box4") as! SKSpriteNode
        box4.physicsBody = SKPhysicsBody(rectangleOf: size)
        box4.physicsBody?.isDynamic = true
        box4.physicsBody?.affectedByGravity = true
        box4.physicsBody?.allowsRotation = true//Sağa sola dönebilir mi manasına geliyor. Dönmesini istiyoruz, bu yüzden true.
        box4.physicsBody?.mass = 0.4
        box4Original = box4.position
        
        box4.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        box5 = childNode(withName: "box5") as! SKSpriteNode
        box5.physicsBody = SKPhysicsBody(rectangleOf: size)
        box5.physicsBody?.isDynamic = true
        box5.physicsBody?.affectedByGravity = true
        box5.physicsBody?.allowsRotation = true//Sağa sola dönebilir mi manasına geliyor. Dönmesini istiyoruz, bu yüzden true.
        box5.physicsBody?.mass = 0.4
        box5Original = box5.position
        
        box5.physicsBody?.collisionBitMask = ColliderType.Bird.rawValue
        
        /*box1.physicsBody?.affectedByGravity = false
        box2.physicsBody?.affectedByGravity = false
        box3.physicsBody?.affectedByGravity = false
        box4.physicsBody?.affectedByGravity = false
        box5.physicsBody?.affectedByGravity = false*/
        
        //Label
        
        scoreLabel.fontName = "Helvetica"
        scoreLabel.fontSize = 60
        scoreLabel.text = "0"
        scoreLabel.position = CGPoint(x: 0, y: self.frame.height / 4)
        scoreLabel.zPosition = 2
        self.addChild(scoreLabel)
        
        
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.collisionBitMask == ColliderType.Bird.rawValue || contact.bodyB.collisionBitMask == ColliderType.Box.rawValue {
            score += 1
            scoreLabel.text = String(score)
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Kullanıcı ekrana dokunmaya başladı. Bunlar Gesture Recognizer'a benziyor.
        
        //applyImpulse: Seçili nesneye güç uygulamak anlamına gelir.
        
        //dx: 0, dy: 200 Bu durumda ekrana her tıklandığında kuş 200 birim yukarı zıplayacak.
        //dx: 50, dy: 200 Bu durumda ekrana her tıklandığında kuş 50 birim sağa ve 200 birim yukarı zıplayacak.
        /*bird.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 200))
        bird.physicsBody?.affectedByGravity = true//Ekrana tıklandığında kuş yerçekimine uyacak.*/
        
        if gameStarted == false {
            if let touch = touches.first {//Eğer touch'ı alabilirsem
                let touchLocation = touch.location(in: self)//Dokunulan yeri buluyorum. Burada benden view istedi.
                let touchNodes = nodes(at: touchLocation)//Hangi noktadaki node'u almak istediğimi bana soruyor. touchNodes bir SKNode dizisi.
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {//Kuş bir SKSpriteNode'dur.
                            if sprite == bird {//Dokunulan şey kuş mu diye kontrol ediyor.
                                bird.position = touchLocation//Eğer kuş ise kuşun pozisyonuna touchLocation'ı yani dokunulan yeri ata.
                            }
                        }
                    }
                }
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Kullanıcı ekrana dokunup hareket ediyor.
        
        if gameStarted == false {
            if let touch = touches.first {//Eğer touch'ı alabilirsem
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                bird.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Kullanıcı dokunmayı bıraktı.
        
        if gameStarted == false {
            if let touch = touches.first {//Eğer touch'ı alabilirsem
                let touchLocation = touch.location(in: self)
                let touchNodes = nodes(at: touchLocation)
                
                if touchNodes.isEmpty == false {
                    for node in touchNodes {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == bird {
                                //Touch Location ve Original Position arasındaki fark alınacak ve bu değeri impulse olarak vereceğiz.
                                let dx = -(touchLocation.x - originalPosition!.x)//Başına eksi koyduk çünkü artı dersek aynı yöne gider. Biz, kuşu çektiğimiz yerin tam tersine doğru gitsin istiyoruz.
                                let dy = -(touchLocation.y - originalPosition!.y)
                                let impulse = CGVector(dx: dx, dy: dy)
                                
                                bird.physicsBody?.applyImpulse(impulse)
                                bird.physicsBody?.affectedByGravity = true
                                
                                /*box1.physicsBody?.affectedByGravity = true
                                box2.physicsBody?.affectedByGravity = true
                                box3.physicsBody?.affectedByGravity = true
                                box4.physicsBody?.affectedByGravity = true
                                box5.physicsBody?.affectedByGravity = true*/
                                
                                gameStarted = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Dokunmaktan vazgeçildi.
    }
    
    
    override func update(_ currentTime: TimeInterval) {//Ekran her değiştiğinde çağırılan bir fonksiyon.
        if let birdPhysicsBody = bird.physicsBody {
            if birdPhysicsBody.velocity.dx <= 0.1 && birdPhysicsBody.velocity.dy <= 0.1 && birdPhysicsBody.angularVelocity <= 0.1 && gameStarted == true {
                
                //MARK: Reset Positions
                bird.physicsBody?.affectedByGravity = false
                bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                bird.physicsBody?.angularVelocity = 0
                bird.zPosition = 1
                bird.position = originalPosition!
                
                box1.position = box1Original!
                box2.position = box2Original!
                box3.position = box3Original!
                box4.position = box4Original!
                box5.position = box5Original!
                
                /*box1.physicsBody?.affectedByGravity = true
                box2.physicsBody?.affectedByGravity = true
                box3.physicsBody?.affectedByGravity = true
                box4.physicsBody?.affectedByGravity = true
                box5.physicsBody?.affectedByGravity = true*/
                
                score = 0
                scoreLabel.text = String(score)
                
                gameStarted = false
            }
        }
    }
}
