//
//  ProductService.swift
//  MGParseDemo
//
//  Created by Tuan Truong on 8/26/15.
//  Copyright (c) 2015 Tuan Truong. All rights reserved.
//

import UIKit

class ProductService: NSObject {
    let productRepository = ProductRepository()
    
    func addProduct(productDto: ProductDto) {
        productRepository.addProduct(productDto)
    }
    
    func updateProduct(productDto: ProductDto) {
        productRepository.updateProduct(productDto)
    }
    
    func deleteProductById(id: String) {
        productRepository.deleteProductById(id)
    }
    
    func getAllProducts() -> [ProductDto] {
        return productRepository.getAllProducts()
    }
    
    func mostRecentUpdatedDate() -> NSDate? {
        return productRepository.mostRecentUpdatedDate()
    }
    
    func getProductsUpdatedAfterDate(date: NSDate) -> [ProductDto] {
        return productRepository.getProductsUpdatedAfterDate(date)
    }
}
