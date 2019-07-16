import UIKit
//import AVFoundation
import AVKit
import Alamofire

class ViewController: UIViewController {
    
//        let informator = AVPlayer(url: URL(string: "http://main.inf.fm:9103")!)
    
    let rabbitPath = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
    let urlWatch = "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_adv_example_hevc/master.m3u8"
    let urlFM = "http://main.inf.fm:9103"
    let informator = AVPlayer(url: URL(string: "http://main.inf.fm:9103")!)
    
    
    static var player = AVPlayer()
    
    let myButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 30, y: 30, width: 40, height: 40)
        button.setTitle("GO!", for: .normal)
        button.titleLabel?.textColor = .red
        button.backgroundColor = .green
        
        button.addTarget(self, action: #selector(getRadioWithAlamofire), for: .touchDown)
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(myButton)
        //        getRabbitInNora()
        getController()
    }
    
    
    func getRabbitInNora() {
        guard let rabbitUrl = URL(string: rabbitPath) else {print("error URL"); return}
        let player = AVPlayer(url: rabbitUrl)
        print("player = \(player.description)")
        let layer = AVPlayerLayer(player: player)
        
        layer.frame = self.view.bounds
        self.view.layer.addSublayer(layer)
        player.play()
        
    }
    
    @objc func getController() {
        //        guard let urlWatch = URL(string: urlFM) else { return }
        
        ViewController.player = AVPlayer(url: URL(string: urlFM)!)
        
        //        let playerLayer = AVPlayerLayer(player: player)
        //        playerLayer.frame = self.view.bounds
        //        self.view.layer.addSublayer(playerLayer)
        
        let controller = AVPlayerViewController()
        controller.player = ViewController.player
        
        present(controller, animated: true) {
            ViewController.player.play()
        }
        
    }
    
    @objc func getRadioWithAlamofire() {
//        informator.play()
                var player = AVAudioPlayer()
        
        
                request(urlFM).stream { data in
                    do {
        
                        player = try AVAudioPlayer(data: data, fileTypeHint: AVFileType.mp3.rawValue)
                        print("DATA = \(data)")
                        player.prepareToPlay()
                        player.play()
        
                        DispatchQueue.main.async {
                            for _ in 0...Int64.max {
                                if player.duration >= 4 {
                                    player.play()
                                }
                            }
                        }
                    } catch {}
                }
    }
}

