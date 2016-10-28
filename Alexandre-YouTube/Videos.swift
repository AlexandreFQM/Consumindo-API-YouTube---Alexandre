//
//  Videos.swift
//  Alexandre-YouTube
//
//  Created by Alexandre Furquim on 25/10/16.
//
//

import UIKit
import SwiftyJSON

class Videos {
    
    var posicaoVideo: Int?
    var canalID: String?
    var tituloCanal: String?
    var videosID : String?
    var videosTitulo: String?
    var videosDescricao: String?
    var videosURL: String?
    var videosURLMedium: String?
    var videosURLHigh: String?
    var videosURLMax: String?
    
    init(dados: JSON, contador: Int) {
    
//        print(dados["id"].stringValue)
//        print(dados["snippet"]["title"].stringValue)
//        print(dados["snippet"]["description"].stringValue)
        
        self.posicaoVideo = contador
        self.canalID = dados["snippet"]["channelId"].stringValue
        self.tituloCanal = dados["snippet"]["channelTitle"].stringValue
        self.videosID = dados["id"].stringValue
        self.videosTitulo = dados["snippet"]["title"].stringValue
        self.videosDescricao = dados["snippet"]["description"].stringValue
        self.videosURL = dados["snippet"]["thumbnails"]["default"]["url"].stringValue
        self.videosURLMedium = dados["snippet"]["thumbnails"]["medium"]["url"].stringValue
        self.videosURLHigh = dados["snippet"]["thumbnails"]["high"]["url"].stringValue
        self.videosURLMax = dados["snippet"]["thumbnails"]["maxres"]["url"].stringValue
        
    }
    
}

class Canal {
    
    var canalPosicao: Int?
    var canalID : String?
    var canalTitulo: String?
    var canalDescricao: String?
    var canalURL: String?
    var canalURLMedium: String?
    var canalURLHigh: String?
    var canalURLMax: String?
    
    init(dados: JSON, contador: Int) {
        
//        print(dados["id"].stringValue)
        print("Gravando Canal: \(dados["snippet"]["title"].stringValue)")
//        print(dados["snippet"]["description"].stringValue)
        
        self.canalPosicao = contador
        self.canalID = dados["id"].stringValue
        self.canalTitulo = dados["snippet"]["title"].stringValue
        self.canalDescricao = dados["snippet"]["description"].stringValue
        self.canalURL = dados["snippet"]["thumbnails"]["default"]["url"].stringValue
        self.canalURLMedium = dados["snippet"]["thumbnails"]["medium"]["url"].stringValue
        self.canalURLHigh = dados["snippet"]["thumbnails"]["high"]["url"].stringValue
        self.canalURLMax = dados["snippet"]["thumbnails"]["maxres"]["url"].stringValue
        
    }
    
}

