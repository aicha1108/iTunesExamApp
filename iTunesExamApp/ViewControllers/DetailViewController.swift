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
    //MARK: Properties
    var trackObj: iTunesTrack!

    //MARK: OVERRIDE
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    //MARK: PRIVATE METHOD
    private func configureView() {
        
        //display advisory rating of the track
        if let rating = trackObj.contentAdvisoryRating{
            self.navigationItem.title = "Rated - \(rating)"
        }
        
        //display track name
        if let name = trackObj.trackName{
            self.lbTrackName.text = name
        }
        
        //display track's long description
        if let description = trackObj.longDescription{
            self.txtDetailDesription.text = description
        }
    }

}

