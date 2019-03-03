//
//  DataStore.swift
//  iTunesExamApp
//
//  Data Persists (save searched itunes tracks)
//
//  Created by Aicha on 03/03/2019.
//  Copyright © 2019 Aiza Simbra. All rights reserved.
//

import Foundation

class DataStore {
    
    //MARK: Save tracks
    static func saveTracks(_ tracks: [iTunesTrack]){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tracks, toFile: iTunesTrack.ArchiveURL.path)
        print(isSuccessfulSave ? "Successfuly saved" : "Failed to save")
    }
    
    //MARK: Load Tracks
    static func loadSavedTracks() -> [iTunesTrack]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: iTunesTrack.ArchiveURL.path) as? [iTunesTrack]
    }
    
    //MARK: Check if has stored tracks
    static func hasStoredTracks() -> Bool{
        return FileManager.default.fileExists(atPath: iTunesTrack.ArchiveURL.path)
    }
}
