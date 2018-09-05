//
//  MyClosetItemsManager.m
//  MyCloset
//
//  Created by sunning on 14-11-2.
//  Copyright (c) 2014年 ___NinaS Corp__. All rights reserved.
//

#import "MyClosetItemsManager.h"
#import "MyClosetItemManagerCell.h"
//#import "MyClosetItemCell.h"
#import "TabViewAppDelegate.h"

@interface MyClosetItemsManager ()
{
    NSArray *fileList;
    NSArray *cellName;
    NSString *imagePath;
    int count;
    TabViewAppDelegate *delegate;
}

@end

@implementation MyClosetItemsManager

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self.collectionView registerClass:[MyClosetItemManagerCell class] forCellWithReuseIdentifier:@"myClosetItemManagerCell"];
    
    imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //fileList =[[[NSFileManager defaultManager] contentsOfDirectoryAtPath:imagePath error:nil] pathsMatchingExtensions:[NSArray arrayWithObject:@"jpg"]];

    /*self.photoImages = [[NSMutableArray alloc] initWithObjects:
                        @"0.jpg",
                        @"1.jpg",
                        @"2.jpg",nil];*/
    delegate=(TabViewAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    switch (self.iType) {
        case 0:
            self.photoImages = delegate.Type0;
            break;
            
        case 1:
            self.photoImages = delegate.Type1;
            break;
            
        case 2:
            self.photoImages = delegate.Type2;
            break;
            
        case 3:
            self.photoImages = delegate.Type3;
            break;
        case 4:
            self.photoImages = delegate.Type4;
            break;
        case 5:
            self.photoImages = delegate.Type5;
            break;
            
    }
    
//    delegate.todayImages = [[NSMutableArray alloc] initWithObjects:
//                        @"0.jpg",
//                        nil];
    
    count = [self.photoImages count];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self action:@selector(longPressGestureRecognized:)];
    [self.collectionView addGestureRecognizer:longPress];
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    
    return count;
    
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    MyClosetItemManagerCell *cell = (MyClosetItemManagerCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"myClosetItemManagerCell" forIndexPath:indexPath];
    //NSString *imageName = [fileList objectAtIndex:indexPath.row];
    NSString *imageName = [self.photoImages objectAtIndex:indexPath.row];
    NSString *imageToLoad = [imagePath stringByAppendingPathComponent:imageName];
    cell.myClosetItemManageImage.image = [UIImage imageWithContentsOfFile:imageToLoad];
    cell.linkImageName = imageName;
    //尝试渐变色，失败
    //cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    cell.btnDeleteItem.hidden = YES;
    cell.btnDeleteItem.tag = indexPath.row;
    cell.btnAddToToday.tag = 10+indexPath.row;
    cell.tag = 20+indexPath.row;
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
 {
     //simulate long press on one cell,then delete
     MyClosetItemManagerCell *cell = (MyClosetItemManagerCell *)[collectionView cellForItemAtIndexPath:indexPath];
     cell.backgroundColor = [UIColor whiteColor];
     cell.btnDeleteItem.tag = indexPath.row;
     if(cell.btnDeleteItem.hidden == YES){
         cell.btnDeleteItem.hidden = NO;
     }else{
         cell.btnDeleteItem.hidden = YES;
     }

}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(90, 140);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
//add or delete from today list
- (IBAction)addItemToToday:(id)sender
{
    UIButton *button = (UIButton *)sender;
    //int tag = button.tag-10;
    MyClosetItemManagerCell *cell = (MyClosetItemManagerCell *) button.superview;
    UICollectionViewCell *cell1 = (UICollectionViewCell *) button.superview;
    NSLog(@"d%",cell1.tag);
    
    //NSString * strTmp = (NSString *)[self.photoImages objectAtIndex:tag];
    [delegate.todayImages addObject:cell.linkImageName];
    
    
}

//delete item from item list
- (IBAction)deleteItemManageCell:(id)sender {
    NSArray * arrayTmp = [self.collectionView indexPathsForSelectedItems];
    NSIndexPath * indexToDel = [arrayTmp objectAtIndex:0];
    [self.photoImages removeObjectAtIndex:indexToDel.row];
    NSArray *deleteItems = @[indexToDel];
    count = count -1;//must have, or crush
    [self.collectionView performBatchUpdates:^{
        [self.collectionView deleteItemsAtIndexPaths:deleteItems];
    } completion:nil];
    
}



- (IBAction)longPressGestureRecognized:(id)sender
{
    
    /*UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)sender;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    // More coming soon...
    switch (state) {
        case UIGestureRecognizerStateBegan: {
            if (indexPath) {
                //sourceIndexPath = indexPath;
                
                UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
                
                }
            break;
        }
            // More coming soon...
    }*/
}
    
- (UIView *)customSnapshotFromView:(UIView *)inputView {
        
        UIView *snapshot = [inputView snapshotViewAfterScreenUpdates:YES];
        snapshot.layer.masksToBounds = NO;
        snapshot.layer.cornerRadius = 0.0;
        snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
        snapshot.layer.shadowRadius = 5.0;
        snapshot.layer.shadowOpacity = 0.4;
        
        return snapshot;
}

/*- (void)configureCell:(MyClosetItemManagerCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.deleteButton.tag = indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(deleteNote:)  forControlEvents:UIControlEventTouchUpInside];
    Note *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textField.tag = indexPath.row;
    cell.textField.delegate = self;
    cell.textField.text = note.name;
}*/
    

@end
