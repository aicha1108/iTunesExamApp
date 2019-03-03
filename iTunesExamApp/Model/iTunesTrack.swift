//
//  iTunesTrack.swift
//  iTunesExamApp
//
//  iTunes Track Model
//
//  Created by Aicha on 03/03/2019.
//  Copyright © 2019 Aiza Simbra. All rights reserved.
//

import Foundation

class iTunesTrack: NSObject, NSCoding {
    //MARK: Properties
    var trackId: Int?
    var trackName: String?
    var trackPrice: Double?
    var currency: String?
    var artworkUrl100: String?
    var primaryGenreName: String?
    var longDescription: String?
    var contentAdvisoryRating: String?
    
    //MARK: Archive Path [Documents Directory]
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent(kItunesTrackFileName)
    
    //MARK: Types
    struct Keys {
        static let trackId = "trackId"
        static let trackName = "trackName"
        static let trackPrice = "trackPrice"
        static let currency = "currency"
        static let artworkUrl100 = "artworkUrl100"
        static let primaryGenreName = "primaryGenreName"
        static let longDescription = "longDescription"
        static let contentAdvisoryRating = "contentAdvisoryRating"
    }
    
    //MARK: Initialization
    init?(trackId: Int?, trackName: String?, trackPrice: Double?, currency: String?, artworkUrl100: String?, primaryGenreName: String?, longDescription: String?, contentAdvisoryRating: String?) {
        
        self.trackId = trackId
        self.trackName = trackName
        self.trackPrice = trackPrice
        self.currency = currency
        self.artworkUrl100 = artworkUrl100
        self.primaryGenreName = primaryGenreName
        self.longDescription = longDescription
        self.contentAdvisoryRating = contentAdvisoryRating
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.trackId, forKey: Keys.trackId)
        aCoder.encode(self.trackName, forKey: Keys.trackName)
        aCoder.encode(self.trackPrice, forKey: Keys.trackPrice)
        aCoder.encode(self.currency, forKey: Keys.currency)
        aCoder.encode(self.artworkUrl100, forKey: Keys.artworkUrl100)
        aCoder.encode(self.primaryGenreName, forKey: Keys.primaryGenreName)
        aCoder.encode(self.longDescription, forKey: Keys.longDescription)
        aCoder.encode(self.contentAdvisoryRating, forKey: Keys.contentAdvisoryRating)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let trackId = aDecoder.decodeObject(forKey: Keys.trackId) as? Int
        let trackName = aDecoder.decodeObject(forKey: Keys.trackName) as? String
        let trackPrice = aDecoder.decodeObject(forKey: Keys.trackPrice) as? Double
        let currency = aDecoder.decodeObject(forKey: Keys.currency) as? String
        let artworkUrl100 = aDecoder.decodeObject(forKey: Keys.artworkUrl100) as? String
        let primaryGenreName = aDecoder.decodeObject(forKey: Keys.primaryGenreName) as? String
        let longDescription = aDecoder.decodeObject(forKey: Keys.longDescription) as? String
        let contentAdvisoryRating = aDecoder.decodeObject(forKey: Keys.contentAdvisoryRating) as? String
        
        //must call designated initializer
        self.init(trackId: trackId, trackName: trackName, trackPrice: trackPrice, currency: currency, artworkUrl100: artworkUrl100, primaryGenreName: primaryGenreName, longDescription: longDescription, contentAdvisoryRating: contentAdvisoryRating)
    }
    
}
