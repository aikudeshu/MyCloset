//
//  MyClosetCameraViewController.h
//  MyCloset
//
//  Created by WangXiao on 1/11/14.
//  Copyright (c) 2014 WangXiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyClosetCameraViewController : UIViewController<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) IBOutlet UILabel *tagLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *tagsArray;
@property (strong, nonatomic) IBOutlet UIButton *saveButton;

- (IBAction)selectTag:(id)sender;
- (IBAction)savePhoto:(id)sender;

@end
