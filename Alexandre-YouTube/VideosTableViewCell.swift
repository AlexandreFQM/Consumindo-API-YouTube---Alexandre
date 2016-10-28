//
//  VideosTableViewCell.swift
//  Alexandre-YouTube
//
//  Created by Alexandre Furquim on 25/10/16.
//
//

import UIKit

class VideosTableViewCell: UITableViewCell {

    
    //MARK: Properties
    @IBOutlet weak var channelPic: UIButton!
    @IBOutlet weak var videoPic: UIImageView!
    @IBOutlet weak var videoTitle: UILabel!
    @IBOutlet weak var videoDescription: UILabel!
    @IBOutlet weak var videoDuration: UILabel!
    
    //MARK: Methods
    func customization()  {
        self.videoPic.layer.borderWidth = 0.5
        self.videoPic.layer.borderColor = UIColor.lightGray.cgColor
        self.channelPic.layer.cornerRadius = 24
        self.channelPic.clipsToBounds  = true
        self.videoDuration.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        self.videoDuration.layer.borderWidth = 0.5
        self.videoDuration.layer.borderColor = UIColor.white.cgColor
        self.videoDuration.sizeToFit()
    }
    
    //MARK: Inits
    override func awakeFromNib() {
        super.awakeFromNib()
        customization()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
