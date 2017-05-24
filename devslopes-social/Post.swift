//
//  Post.swift
//  devslopes-social
//
//  Created by Fain Cowie on 2017-05-14.
//  Copyright © 2017 Fain Cowie. All rights reserved.
//

import Foundation

class Post {
    
    private var _caption: String!
    private var _imageURL: String!
    private var _likes: Int!
    private var _postKey: String!
    
    var imageURL: String {
        return _imageURL
    }
    var caption: String {
        return _caption
    }
    var likes: Int {
        return _likes
    }
    var postKey: String {
        return _postKey
    }
  
    init (caption: String, imageURL: String, likes: Int) {
        self._caption = caption
        self._imageURL = imageURL
        self._likes = likes
    }
    
    init (postKey: String, postData: Dictionary<String, AnyObject>) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        if let imageURL = postData["imageURL"] as? String {
            self._imageURL = imageURL
        }
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        
    }
}
