//
//  ViewController.swift
//  Alexandre-YouTube
//
//  Created by Alexandre Furquim on 25/10/16.
//
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate {
    
    //Declaração de variavéis
    @IBOutlet weak var tblVideos: UITableView!
    
    var url: URL?
    var modelVideos : [Videos] = [Videos]()
    var modelCanal : [Canal] = [Canal]()
    var contador = 0
    var contadorVideo = 0
    var selectedVideoIndex: Int!
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tblVideos.delegate = self
        tblVideos.dataSource = self
        
        self.listaVideos { (result : [Videos]) in
            for item in result {
                
                print ("Titulo do Video: \(item.videosTitulo)")
                
                self.buscaChannel(canalID: item.canalID!) {
                    (result2: [Canal]) in
                    
                    if(result.count == self.contador) {
                        self.tblVideos.reloadData()
                        self.start()
                        
                    }
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if self.modelVideos.count > 0 {
            
            self.start()
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "idSeguePlayer" {
            let playerViewController = segue.destination as! PlayerViewController
            
            let videoDetails = modelVideos[selectedVideoIndex]
            
            playerViewController.videoID = videoDetails.videosID
        }
    }
    
    
    
    // MARK: UITableView method implementation
    
    private func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelVideos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: VideosTableViewCell
        
        cell = tableView.dequeueReusableCell(withIdentifier: "idCellVideo") as! VideosTableViewCell
        
        let videoDetails = modelVideos[indexPath.row]
        let channelDetails = modelCanal[indexPath.row]
        
        
        if (videoDetails.videosURLMax != "") {
            url = URL(string: videoDetails.videosURLMax!)
        }else{
            url = URL(string: videoDetails.videosURLMedium!)
        }
        
        let data = try? Data(contentsOf: url!)
        
        let urlProfile = URL(string: channelDetails.canalURL!)
        let dataProfile = try? Data(contentsOf: urlProfile!)
        
        if data != nil {
            cell.videoPic.image = UIImage(data: data!)
        }else{
            cell.videoPic.image = UIImage.init(named: "emptyTumbnail")
        }
        
        cell.videoTitle.text = videoDetails.videosTitulo
        cell.videoDescription.text = channelDetails.canalTitulo
        cell.channelPic.setImage(UIImage(data: dataProfile!), for: [])
        cell.channelPic.imageView?.contentMode = UIViewContentMode.scaleAspectFill
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        timer?.invalidate()
    }
    
    
    func SleepTableView(_ scrollView: UIScrollView) {
        
        let cellHeight = 289
        
        let verticalContentOffset = Int(scrollView.contentOffset.y)
        
        let halfScreenHeight = Int(tblVideos.frame.height) / 2 // == 284
        
        let center = halfScreenHeight + verticalContentOffset // == 404
        
        let position : Int = Int(round(Double(center / cellHeight)))
        
        if position >= 0 && position <= modelVideos.count{
            
            timer?.invalidate()
            selectedVideoIndex = Int(position)
            performSegue(withIdentifier: "idSeguePlayer", sender: self)
            
        }
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.start()
    }
    
    
    func start(){
        
        self.timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.ExecutarAcao), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }
    
    func ExecutarAcao(){
        
        self.SleepTableView(tblVideos)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 289.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        timer?.invalidate()
        selectedVideoIndex = indexPath.row
        performSegue(withIdentifier: "idSeguePlayer", sender: self)
    }
    
    
    private func listaVideos(completion: @escaping (_ result: [Videos]) -> Void) {
        Alamofire.request(urlSnippetAPI)
            .responseJSON { response in
                switch response.result {
                case .success:
                    
                    if let value = response.result.value {
                        let json = JSON(value)
                        
                        if let items = json["items"].array {
                            
                            for item in items {
                                self.modelVideos.append(Videos(dados: item, contador: self.contadorVideo))
                                self.contadorVideo = self.contadorVideo + 1
                                
                            }
                        }
                        completion(self.modelVideos)
                    }
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
    
    private func buscaChannel(canalID: String, completion: @escaping (_ result: [Canal]) -> Void) {
        
        let urlChanelSnippetAPI = "https://www.googleapis.com/youtube/v3/channels?part=snippet&id=\(canalID)&key=\(apiKey)"
        
        Alamofire.request(urlChanelSnippetAPI)
            .responseJSON { response in
                switch response.result {
                case .success:
                    
                    if let value = response.result.value {
                        let json = JSON(value)
                        
                        if let items = json["items"].array {
                            
                            for item in items {
                                
                                _ = self.modelVideos.filter { $0.tituloCanal == item["snippet"]["title"].stringValue }
                                let indice = self.modelVideos.index(where: { $0.tituloCanal == item["snippet"]["title"].stringValue })
                                
                                self.modelCanal.append(Canal(dados: item, contador: indice!))
                                self.modelCanal = self.modelCanal.sorted(by: {$0.canalPosicao! < $1.canalPosicao!})
                                self.contador = self.contador + 1
                            }
                        }
                        
                        completion(self.modelCanal)
                        
                    }
                    
                case .failure(let error):
                    print(error)
                }
        }
    }
}
