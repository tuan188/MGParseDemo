//
//  SyncService.swift
//  MGParseDemo
//
//  Created by Tuan Truong on 8/26/15.
//  Copyright (c) 2015 Tuan Truong. All rights reserved.
//

import UIKit

class SyncService: NSObject {
    let productService = ProductService()
    let productParseService = ProductParseService()
    
    func sync() {
        let localUpdatedDate: NSDate? = productService.mostRecentUpdatedDate()
        let parseUpdatedDate: NSDate? = productParseService.mostRecentUpdatedDate()
        
        if localUpdatedDate == nil {
            if parseUpdatedDate != nil {
                let products = productParseService.getAllProducts()
                for product in products {
                    productService.addProduct(product)
                }
            }
        }
        else {
            if parseUpdatedDate != nil {
                // localUpdatedDate > parseUpdatedDate
                if localUpdatedDate!.compare(parseUpdatedDate!) == NSComparisonResult.OrderedDescending {
                    let products = productService.getProductsUpdatedAfterDate(parseUpdatedDate!)
                    for product in products {
                        productParseService.addOrUpdateProduct(product)
                    }
                }
                else {
                    let products = productParseService.getProductsUpdatedAfterDate(localUpdatedDate!)
                    for product in products {
                        productService.addOrUpdateProduct(product)
                    }
                }
            }
            else {
                let products = productService.getAllProducts(true)
                for product in products {
                    productParseService.addProduct(product)
                }
            }
        }
    }
}
