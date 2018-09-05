//
//  MyClosetItemsView.m
//  MyCloset
//
//  Created by sunning on 14-11-2.
//  Copyright (c) 2014年 ___NinaS Corp__. All rights reserved.
//

#import "MyClosetItemsView.h"
#import "MyClosetItemsCell.h"
#import "MyClosetItemsManager.h"

@interface MyClosetItemsView ()
{
    NSArray *fileList;
    NSArray *cellName;
    int count;
}
@end

@implementation MyClosetItemsView

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
    //[self.collectionView registerClass:[MyClosetItemsCell class] forCellWithReuseIdentifier:@"MyClosetItems"];
    //NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    //fileList =[[[NSFileManager defaultManager] contentsOfDirectoryAtPath:imagePath error:nil] pathsMatchingExtensions:[NSArray arrayWithObject:@"png"]];
    
    //[fileList addObject: imagePath];
    fileList = [[NSArray alloc] initWithObjects:
    @"sweater.png",
    @"shirt.png",
    @"pants.png",
    @"dress.png",
    @"shoes.png",
    @"accessory.png",nil];
    count = [fileList count];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section

{
    
    return count;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    
    MyClosetItemsCell *cell = (MyClosetItemsCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"MyClosetItems" forIndexPath:indexPath];
    
    NSString *imagePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    NSString *imageName = [fileList objectAtIndex:indexPath.row];
    //NSLog([NSString stringWithFormat:@"{%1d}",(int)indexPath.row]);
    NSString *imageToLoad = [imagePath stringByAppendingPathComponent:imageName];
    cell.myClosetItemsImage.image = [UIImage imageWithContentsOfFile:imageToLoad];
    
    //cell.backgroundColor = [UIColor colorWithRed:((10 * indexPath.row) / 255.0) green:((20 * indexPath.row)/255.0) blue:((30 * indexPath.row)/255.0) alpha:1.0f];
    //cell.MyClosetItemLabel.text = [NSString stringWithFormat:@"{%1d}",(int)indexPath.row];
    
    return cell;
    
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

/*-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    MyClosetItemsManager * myClosetItemsManager = [[MyClosetItemsManager alloc] init];
    [self.navigationController pushViewController:myClosetItemsManager animated:NO];
    

}*/

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([[segue identifier]isEqualToString:@"showDetail"]){
        NSIndexPath *selectIndexPath = [[self.collectionView indexPathsForSelectedItems] objectAtIndex:0];
        MyClosetItemsManager *itemManager =[segue destinationViewController];
        itemManager.iType = selectIndexPath.row;
        
    }
}





@end
