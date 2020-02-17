//
//  FetchResult.swift
//  iTunesCodeAssessment
//
//  Created by Suruchi Kumari on 26/01/20.
//  Copyright © 2020 Suruchi Kumari. All rights reserved.
//

import Foundation
enum FetchResult<T, E : Error>{
    case success(data : T)
    case failure(E?)
}
