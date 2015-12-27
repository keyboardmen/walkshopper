//
//  WSSelectCountryFlowLayout.m
//  WalkShopper
//
//  Created by 丁 一 on 15/12/26.
//  Copyright © 2015年 Ding Yi. All rights reserved.
//

#import "WSSelectCountryFlowLayout.h"

@interface WSSelectCountryFlowLayout () <UICollectionViewDelegateFlowLayout>

@end

@implementation WSSelectCountryFlowLayout

- (id)init
{
    if (self = [super init])
    {
        self.itemSize = CGSizeMake(95, 95);
        self.minimumInteritemSpacing = 2;
        self.minimumLineSpacing = 2;
        //self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.sectionInset = UIEdgeInsetsMake(2, 2, 2, 22);
        self.headerReferenceSize = CGSizeMake(320, 30);
    }
    return self;
}



@end
