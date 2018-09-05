//
//  MyClosetItemManagerCell.h
//  MyCloset
//
//  Created by sunning on 14-11-3.
//  Copyright (c) 2014年 ___NinaS Corp__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyClosetItemManagerCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myClosetItemManageImage;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteItem;
@property (weak, nonatomic) IBOutlet UIButton *btnAddToToday;
@property  NSString *linkImageName;

@end
