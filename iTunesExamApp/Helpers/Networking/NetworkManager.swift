//
//  NetworkManager.swift
//  iTunesExamApp
//
//  Created by Aicha on 03/03/2019.
//  Copyright © 2019 Aiza Simbra. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager{
    //check if connected to internet
    static func isConnectedToInternet() -> Bool{
        return NetworkReachabilityManager()!.isReachable
    }
}
