//
//  MasterViewController.swift
//  iTunesExamApp
//
//  Created by Aicha on 03/03/2019.
//  Copyright © 2019 Aiza Simbra. All rights reserved.
//

import UIKit
import SkeletonView

class MasterViewController: UITableViewController {

    //MARK: Properties
    var detailViewController: DetailViewController? = nil
    var tracks = [iTunesTrack]()
    let toSearchTerm = "star"
    let toSearchCountry = "au"
    let toSearchMedia = "movie"
    var lastVisitedDate: Date!
    var isSkeletonLoading = false{
        didSet{
            self.tableView.reloadData()
        }
    }

    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //default set up for split view
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        //load tracks
        self.loadTracks()
        
        //last visit timestamp
        self.setDateUserLastVisitedTheApp()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //TO DETAIL VIEW
        if segue.identifier == kSegueShowDetail {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.trackObj = self.tracks[indexPath.row]
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    //MARK: PRIVATE METHODS
    //load saved tracks if there is, else, fetch from the api
    private func loadTracks(){
        if DataStore.hasStoredTracks(){
            self.storeTracksAndReloadList()
        }else{
            self.fetchTracksFromAPI()
        }
    }
    
    //fetch tracks from api with the given search category in param
    private func fetchTracksFromAPI(){
        self.isSkeletonLoading = true
        let params = ["term" : toSearchTerm, "country" : toSearchCountry, "media" : toSearchMedia]
        
        APIClient.fetchTracksWithParams(params) { (error) in
            guard error == nil else {
                self.presentAlertControllerWithMessageAndHandler(error!, title: kError, buttonText: kOk, handler: nil)
                self.isSkeletonLoading = false
                return
            }
            self.storeTracksAndReloadList()
        }
    }
    
    //store the fetched tracks and reload table view
    private func storeTracksAndReloadList(){
        self.isSkeletonLoading = false
        if let savedTracks = DataStore.loadSavedTracks(){
            self.tracks += savedTracks
        }
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    //set the date the user last visited the app
    private func setDateUserLastVisitedTheApp(){
        if let lastVisitedDate = UserDefaults.standard.object(forKey: kLastVisitedDate) as? Date{
            self.lastVisitedDate = lastVisitedDate
        }else{
            self.lastVisitedDate = Date()
        }
        //save the NEW date user visited the app
        UserDefaults.standard.set(Date(), forKey: kLastVisitedDate)
    }

    //MARK: Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSkeletonLoading ? 10 : tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrackTableViewCell.identifier, for: indexPath) as? TrackTableViewCell else{
            fatalError("Dequeued cell is not an instance of TrackTableViewCell")
        }
        
        cell.imgArtwork.image = nil
        cell.showAnimation()
        
        if !isSkeletonLoading{
            cell.hideAnimation()
            let track = tracks[indexPath.row]
            cell.lblTrackName.text = track.trackName ?? ""
            cell.lblGenre.text = track.primaryGenreName ?? ""
            cell.lblPrice.text = "\(track.currency ?? "") \(track.trackPrice ?? 0.0)"
            if let artworkURL = track.artworkUrl100{
                WebClient.downloadImage(url: URL(string: artworkURL)!, imgView: cell.imgArtwork)
            }
        }
        
        return cell
    }
    
    //MARK: Table view delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 111
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView(frame: self.view.frame)
        vw.backgroundColor = UIColor.white
        
        let lblTimeStamp = UILabel(frame: CGRect(x: 12, y: 5, width: self.view.bounds.width - 24, height: 30))
        lblTimeStamp.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        //display the date the user last visited the app
        lblTimeStamp.text = "Last visited at: " + self.lastVisitedDate.dateTo_DDMMMMYYYY_format()
        vw.addSubview(lblTimeStamp)
        
        return vw
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: nil)
    }
}

