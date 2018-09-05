//
//  MyClosetItemsManager.h
//  MyCloset
//
//  Created by sunning on 14-11-2.
//  Copyright (c) 2014年 ___NinaS Corp__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyClosetItemsManager : UICollectionViewController<UICollectionViewDataSource,UICollectionViewDelegate>
@property int iType;
@property (strong, nonatomic) NSMutableArray *photoImages;


@end
