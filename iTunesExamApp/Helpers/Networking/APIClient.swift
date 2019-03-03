//
//  APIClient.swift
//  iTunesExamApp
//
//  API-specific networking-related class
//
//  Created by Aicha on 03/03/2019.
//  Copyright © 2019 Aiza Simbra. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    //MARK: Get tracks data from itunes search api with given params and save data to archive path
    static func fetchTracksWithParams(_ params: [String: Any] , _ hasError: @escaping (_ error: String?) -> ()){
        
        WebClient.commonHTTPRequestWithMethod(.get, params: params, apiURL: apiSearch) { (response, error) in
            if error == nil{
                var tracks = [iTunesTrack]()
                if let dictResponse = response as? Dictionary<String, Any>{
                    if let arrTracks = dictResponse["results"] as? [Dictionary<String, Any>]{
                        for track in arrTracks{
                            guard let trackObj = iTunesTrack.init(trackId: track["trackId"] as? Int, trackName: track["trackName"] as? String, trackPrice: track["trackPrice"] as? Double, currency: track["currency"] as? String, artworkUrl100: track["artworkUrl100"] as? String, primaryGenreName: track["primaryGenreName"] as? String, longDescription: track["longDescription"] as? String, contentAdvisoryRating: track["contentAdvisoryRating"] as? String) else {
                                
                                fatalError("Unable to instantiate track")
                            }
                            
                            tracks.append(trackObj)
                        }
                    }
                }
                //persists data fetched
                DataStore.saveTracks(tracks)
                hasError(nil)
            }else{
                hasError(error)
            }
        }
    }
    
}
