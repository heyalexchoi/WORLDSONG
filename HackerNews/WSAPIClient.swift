//
//  HNAPIClient.swift
//  HackerNews
//
//  Created by alexchoi on 4/10/15.
//  Copyright (c) 2015 Alex Choi. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON



class WSAPIClient {
    
    let baseURLString = ""
    static let sharedClient = WSAPIClient()
    let responseProcessingQueue = NSOperationQueue()
    //    examples:::
    func getTopStories(limit: Int, offset: Int, completion: (stories: [Story]?, error: NSError?) -> Void) -> Request {
        return Alamofire
            .request(.GET, baseURLString + "/topstories", parameters: ["limit": limit, "offset": offset])
            .responseJSON { [weak self] (_, _, json, error) -> Void in
                if let error = error {
                    completion(stories: nil, error: error)
                } else if let json: AnyObject = json {
                    self?.responseProcessingQueue.addOperationWithBlock({ () -> Void in
                        let stories = JSON(json).arrayValue.map { Story(json: $0) }
                        NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                            completion(stories: stories, error: nil)
                        })
                    })
                }
        }
    }
    
    func getStory(id: Int, completion: (story: Story?, error: NSError?) -> Void) -> Request {
        return Alamofire
            .request(.GET, baseURLString + "/items/\(id)")
            .responseJSON { (_, _, json, error) -> Void in
                if let error = error {
                    completion(story: nil, error: error)
                } else if let json: AnyObject = json {
                    completion(story: Story(json: JSON(json)), error: nil)
                }
        }
    }
    
    func uploadRecording(fileURL: NSURL, completion: () -> Void) {
        Alamofire.upload(.POST, "http://httpbin.org/post", fileURL)
            .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                println(totalBytesWritten)
            }
            .responseJSON { (request, response, JSON, error) in
                println(JSON)
        }
    }
    
}
