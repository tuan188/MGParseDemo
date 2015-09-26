//
//  ProductDto.swift
//  MGParseDemo
//
//  Created by Tuan Truong on 8/25/15.
//  Copyright (c) 2015 Tuan Truong. All rights reserved.
//

import UIKit

enum ProductStatus: Int {
    case New
    case Updated
    case Deleted
}

class ProductDto: NSObject {
    var id: String       = NSUUID().UUIDString
    var creationDate     = NSDate()
    var modificationDate = NSDate()
    var name             = ""
    var price: Float     = 0
    var status           = ProductStatus.New
}
