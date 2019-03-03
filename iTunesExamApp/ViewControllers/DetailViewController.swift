//
//  DetailViewController.swift
//  iTunesExamApp
//
//  Created by Aicha on 03/03/2019.
//  Copyright © 2019 Aiza Simbra. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var lbTrackName: UILabel!
    @IBOutlet weak var txtDetailDesription: UITextView!
    @IBOutlet weak var lblDescriptionTitle: UILabel!
    //MARK: Properties
    var trackObj: iTunesTrack?

    //MARK: OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    //MARK: PRIVATE METHOD
    private func configureView() {
        
        if let track = trackObj{
            //display advisory rating of the track
            if let rating = track.contentAdvisoryRating{
                self.navigationItem.title = "Rated - \(rating)"
            }
            self.lblDescriptionTitle.isHidden = false
            //display track name
            if let name = track.trackName{
                self.lbTrackName.text = name
            }
            //display track's long description
            if let description = track.longDescription{
                self.txtDetailDesription.text = description
            }
        }else{
            self.navigationItem.title = "Welcome to iTunes Tracks"
            self.lblDescriptionTitle.isHidden = true
            self.lbTrackName.text = ""
            self.txtDetailDesription.text = ""
        }
        
    }

}

