//
//  MyClosetTodayViewController.m
//  MyCloset
//
//  Created by WangXiao on 8/11/14.
//  Copyright (c) 2014 WangXiao. All rights reserved.
//

#import "MyClosetTodayViewController.h"
#import "MyClosetTodayCell.h"
#import "TabViewAppDelegate.h"

@interface MyClosetTodayViewController ()
{
    NSMutableArray *fileList;
    int fileCount;
    TabViewAppDelegate *delegate;
}

@end

@implementation MyClosetTodayViewController

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
    // Do any additional setup after loading the view.
    delegate=(TabViewAppDelegate*)[[UIApplication sharedApplication] delegate];
    //NSString *fileNameString = [NSString string];
    /*for (int i=0; i<6; i++) {
        if ([[delegate.Types objectAtIndex:i] count]>0) {
            fileNameString = [fileNameString stringByAppendingString:delegate.filePath];
            fileNameString = [fileNameString stringByAppendingString:[[delegate.Types objectAtIndex:i] lastObject]];
            if (i<5) {
                fileNameString = [fileNameString stringByAppendingString:@"|"];
            }
        }
    }*/
    //int count = delegate.todayImages.count;
    fileList = delegate.todayImages;
    //fileList = [fileNameString componentsSeparatedByString:@"|"];
    NSLog(@"%@",fileList);
    fileCount = fileList.count;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return fileCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyClosetTodayCell *cell = (MyClosetTodayCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"MyClosetTodayCell" forIndexPath:indexPath];
    
    NSString *imageToLoad = [delegate.filePath stringByAppendingString:[fileList objectAtIndex:indexPath.row]];
    cell.myClosetItemImage.image = [UIImage imageWithContentsOfFile:imageToLoad];
    //cell.MyClosetItemLabel.text = [NSString stringWithFormat:@"{%1d}",(int)indexPath.row];
    
    return cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
