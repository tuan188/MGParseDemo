//
//  Mapper.swift
//  MGParseDemo
//
//  Created by Tuan Truong on 8/25/15.
//  Copyright (c) 2015 Tuan Truong. All rights reserved.
//

import UIKit

class Mapper: NSObject {
    class func mapFromProduct(product: Product, toProductDto productDto: ProductDto) {
        productDto.id = product.id
        productDto.creationDate = product.creation_date
        productDto.modificationDate = product.modification_date
        productDto.name = product.name
        productDto.price = product.price.floatValue
    }
    
    class func mapFromProductDto(productDto: ProductDto, toProduct product: Product) {
        product.id = productDto.id
        product.creation_date = productDto.creationDate
        product.modification_date = productDto.modificationDate
        product.name = productDto.name
        product.price = productDto.price
    }
    
    class func productDtoFromProduct(product: Product) -> ProductDto {
        let productDto = ProductDto()
        Mapper.mapFromProduct(product, toProductDto: productDto)
        return productDto
    }
}

