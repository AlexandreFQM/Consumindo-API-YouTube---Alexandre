//
//  PlayerViewController.swift
//  Alexandre-YouTube
//
//  Created by Alexandre Furquim on 26/10/16.
//
//

import UIKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var playerView: YTPlayerView!
    
    var videoID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        playerView.load(withVideoId: videoID)

    }
    
    func playerViewDidBecomeReady(playerView: YTPlayerView!) {
        playerView.playVideo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func Fechar(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)        
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
