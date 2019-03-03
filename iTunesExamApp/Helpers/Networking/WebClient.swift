//
//  WebClient.swift
//  iTunesExamApp
//
//  HTTP Networking-related class
//
//  Created by Aicha on 03/03/2019.
//  Copyright © 2019 Aiza Simbra. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SkeletonView

class WebClient{
    
    //MARK: GENERIC HTTP REQUEST (post, get, put, delete) with specified API URL and optional params to pass
    static func commonHTTPRequestWithMethod(_ method: HTTPMethod, params: Parameters?, apiURL: String, completionHandler: @escaping (_ response: Any?, _ error: String?) -> Void){
        
        let url = appBaseURL + apiURL
        let header = HTTPHeaders()
        
        if NetworkManager.isConnectedToInternet(){
            Alamofire.request(url, method: method, parameters: params, encoding: URLEncoding.queryString, headers: header).responseJSON { (response) in
                
                let result = response.result
                if result.isSuccess{
                    if let dictResponse = response.value as? Dictionary<String, Any>{ //if response is dictionary
                        if let error = dictResponse["error"] as? String{
                            completionHandler(nil, error)
                        }else{
                            completionHandler(dictResponse, nil)
                        }
                    }else if let arrResponse = response.value as? Array<Any>{ // if response is array
                        completionHandler(arrResponse, nil)
                    }else{
                        completionHandler(nil, kJSONParseError) // json parsing error
                    }
                }else{
                    completionHandler(nil, kGenericAPIError) // encountered error
                }
            }
        }else{
            completionHandler(nil, kOffline) // offline
        }
    }
    
    //MARK: DOWNLOAD IMAGE
    private class func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    //download image from given URL and display in image view
    static func downloadImage(url: URL?, imgView: UIImageView) {
        DispatchQueue.main.async {
            imgView.showAnimatedGradientSkeleton()
        }
        if let nURL = url{
            getDataFromUrl(url: nURL) { data, response, error in
                guard let data = data, error == nil else {
                    //no image found or error encountered, display no_photo image
                    DispatchQueue.main.async() {
                        imgView.image = #imageLiteral(resourceName: "no_photo")
                        imgView.hideSkeleton()
                    }
                    return
                }
                //print(response?.suggestedFilename ?? url.lastPathComponent)
                DispatchQueue.main.async() {
                    imgView.image = UIImage(data: data)
                    imgView.hideSkeleton()
                }
            }
        }else{
            //no url found, display no_photo image
            DispatchQueue.main.async() {
                imgView.image = #imageLiteral(resourceName: "no_photo")
                imgView.hideSkeleton()
            }
        }
    }
}
