//
//  SyncService.swift
//  MGParseDemo
//
//  Created by Tuan Truong on 8/26/15.
//  Copyright (c) 2015 Tuan Truong. All rights reserved.
//

import UIKit

class SyncService: NSObject {
    let productRepository = ProductRepository()
    let productParseClient = ProductParseClient()
    
    func sync() {
        let localUpdatedDate: NSDate? = productRepository.mostRecentUpdatedDate()
        let parseUpdatedDate: NSDate? = productParseClient.mostRecentUpdatedDate()
        
        if localUpdatedDate == nil {
            if parseUpdatedDate != nil {
                let products = productParseClient.getAllProducts()
                for product in products {
                    productRepository.addProduct(product)
                }
            }
        }
        else {
            if parseUpdatedDate != nil {
                if localUpdatedDate!.compare(parseUpdatedDate!) == NSComparisonResult.OrderedDescending {  // localUpdatedDate > parseUpdatedDate
                    let products = productRepository.getProductsUpdatedAfterDate(parseUpdatedDate!)
                    for product in products {
                        productParseClient.addProduct(product)
                    }
                }
                else {
                    let products = productParseClient.getProductsUpdatedAfterDate(parseUpdatedDate!)
                    for product in products {
                        productRepository.addProduct(product)
                    }
                }
            }
            else {
                let products = productRepository.getAllProducts()
                for product in products {
                    productParseClient.addProduct(product)
                }
            }
        }
    }
    
}
