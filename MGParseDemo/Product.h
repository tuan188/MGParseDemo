//
//  Product.h
//  MGParseDemo
//
//  Created by Tuan Truong on 8/25/15.
//  Copyright (c) 2015 Tuan Truong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSDate * creation_date;
@property (nonatomic, retain) NSDate * modification_date;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * price;

@end
