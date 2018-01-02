//
//  SelectionListBO.h
//  YesMakeOver
//
//  Created by Janmenjaya Rout on 30/12/17.
//  Copyright © 2017 Janmenjaya Rout. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SelectionListBO : NSObject

@property (nonatomic, strong) NSString *objectId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isSelected;

@end
