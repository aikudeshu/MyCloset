//
//  MyClosetCameraViewController.m
//  MyCloset
//
//  Created by WangXiao on 1/11/14.
//  Copyright (c) 2014 WangXiao. All rights reserved.
//

#import "MyClosetCameraViewController.h"
#import "TabViewAppDelegate.h"

@interface MyClosetCameraViewController ()
{
    BOOL isCameraOn;
}

@end

@implementation MyClosetCameraViewController
@synthesize photoView;
@synthesize tagLabel;
@synthesize tagsArray;
@synthesize saveButton;

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
    isCameraOn = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**************** Added by WangXiao *******************/

- (void)viewDidAppear:(BOOL)animated
{
    if (isCameraOn) {
        [self showCameraSheet];
    }
    else
    {
        isCameraOn = YES;
    }
}

- (void)showCameraSheet
{
    UIActionSheet *cameraSheet;
    
    // 判断是否支持相机，弹中调用相机和相册sheet页
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        cameraSheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        [cameraSheet showInView:self.photoView];
    }
    else
    {
        cameraSheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
        [cameraSheet showInView:self.photoView];
    }
    
    cameraSheet.tag = 255;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 处理相机和相册sheet页
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机，弹出调用相机和相册sheet页
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                default:
                    break;
            }
        }
        else
        {
            if (buttonIndex == 0) {
                // 取消
                return;
            }
            else
            {
                // 相册
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        
        [self presentViewController:imagePickerController animated:YES completion:^{}];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    isCameraOn = NO;
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    
    photoView.contentMode = UIViewContentModeScaleAspectFit;
    photoView.image = image;
    
    //UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    isCameraOn = YES;
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (BOOL)savePicture:(UIImage*)image savedWithFormat:(NSInteger)format
{
    NSString *fullPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    // 取本地时间做图片名
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSDate *date = [NSDate date];
    [dateFormatter setDateFormat:@"YYYYMMddHHmmss"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    NSString *picName;
    BOOL result = YES;
    
    
    
    // savedWithFormat: 0: PNG;  1: JPG
    switch (format) {
        case 0:
        {
            // 保存原图片至本地文件夹
            picName = [dateStr stringByAppendingString:@".png"];
            fullPath = [[fullPath stringByAppendingFormat:@"/"] stringByAppendingString:picName];
            result = [UIImagePNGRepresentation(image)writeToFile:fullPath atomically:NO];
            break;
        }
        case 1:
        {
            // 保存压缩图片至本地文件夹
            picName = [dateStr stringByAppendingString:@".jpg"];
            fullPath = [[fullPath stringByAppendingFormat:@"/"] stringByAppendingString:picName];
            NSData *picData = UIImageJPEGRepresentation(image, 0.5);
            result = [picData writeToFile:fullPath atomically:NO];
            break;
        }
        default:
            break;
            
    }
    
    [self addClothType:picName];
    
    // 保存图片至本地相册
    //UIImageWriteToSavedPhotosAlbum(image, self, nil, nil);
    
    return result;
}

- (void)addClothType:(NSString*)fileName
{
    TabViewAppDelegate *delegate=(TabViewAppDelegate*)[[UIApplication sharedApplication] delegate];
    
    
    switch (tagLabel.tag) {
        case 0:
        {
            [delegate.Type0 addObject:fileName];
            [delegate.Type0 writeToFile:[delegate.filePath stringByAppendingFormat:@"Type0.xml"] atomically:NO];
            break;
        }
        case 1:
        {
            [delegate.Type1 addObject:fileName];
            [delegate.Type1 writeToFile:[delegate.filePath stringByAppendingFormat:@"Type1.xml"] atomically:NO];
            break;
        }
        case 2:
        {
            [delegate.Type2 addObject:fileName];
            [delegate.Type2 writeToFile:[delegate.filePath stringByAppendingFormat:@"Type2.xml"] atomically:NO];
            break;
        }
        case 3:
        {
            [delegate.Type3 addObject:fileName];
            [delegate.Type3 writeToFile:[delegate.filePath stringByAppendingFormat:@"Type3.xml"] atomically:NO];
            break;
        }
        case 4:
        {
            [delegate.Type4 addObject:fileName];
            [delegate.Type4 writeToFile:[delegate.filePath stringByAppendingFormat:@"Type4.xml"] atomically:NO];
            break;
        }
        case 5:
            [delegate.Type5 addObject:fileName];
            [delegate.Type5 writeToFile:[delegate.filePath stringByAppendingFormat:@"Type5.xml"] atomically:NO];
            break;
        default:
            break;
    }
    
    
    if (tagLabel.tag>=0 && tagLabel.tag<6) {
        [[delegate.Types objectAtIndex:tagLabel.tag] addObject:fileName];
        NSString *xmlToWrite = [delegate.filePath stringByAppendingString:[NSString stringWithFormat:@"Type%d.xml",tagLabel.tag]];
        [[delegate.Types objectAtIndex:tagLabel.tag] writeToFile:xmlToWrite atomically:NO];
    }
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

- (IBAction)selectTag:(id)sender {
    for (UIButton* btn in tagsArray) {
        if (btn == sender) {
            //[btn setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
            btn.selected = !btn.selected;
            if (btn.selected) {
                tagLabel.text = btn.titleLabel.text;
                tagLabel.tag = btn.tag;
            } else
            {
                tagLabel.text = @"";
                tagLabel.tag = 99;
            }
        }
        else {
            btn.selected = NO;
        }
    }
}

- (IBAction)savePhoto:(id)sender {
    if (tagLabel.tag == 99) {
        [[[UIAlertView alloc]initWithTitle:nil message:@"请选择图片分类" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
    }
    else {
        //保存图片文件，使用PNG格式
        BOOL result = [self savePicture:self.photoView.image savedWithFormat:0];
        // 显示保存结果
        if (result) {
            [[[UIAlertView alloc]initWithTitle:@"保存图片" message:@"图片保存成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
        }
        else
        {
            [[[UIAlertView alloc]initWithTitle:@"保存图片" message:@"图片保存异常" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil]show];
        }
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if ([alertView.title  isEqual: @"保存图片"]) {
        [self.tabBarController setSelectedIndex:0];
    }
}

@end
