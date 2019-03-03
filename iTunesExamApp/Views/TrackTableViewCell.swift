//
//  TrackTableViewCell.swift
//  iTunesExamApp
//
//  Created by Aicha on 03/03/2019.
//  Copyright © 2019 Aiza Simbra. All rights reserved.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var imgArtwork: UIImageView!
    @IBOutlet weak var lblTrackName: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    //MARK: Properties
    class var identifier: String{
        return String(describing: self)
    }

    //MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        showAnimation()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    //MARK: Show skeleton loading animation
    func showAnimation(){
        self.imgArtwork.showAnimatedGradientSkeleton()
        self.lblTrackName.showAnimatedGradientSkeleton()
        self.lblGenre.showAnimatedGradientSkeleton()
        self.lblPrice.showAnimatedGradientSkeleton()
    }
    
    //MARK: Hide skeleton loading animation
    func hideAnimation(){
        self.imgArtwork.hideSkeleton()
        self.lblTrackName.hideSkeleton()
        self.lblGenre.hideSkeleton()
        self.lblPrice.hideSkeleton()
    }

}
