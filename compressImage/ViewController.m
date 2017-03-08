//
//  ViewController.m
//  compressImage
//
//  Created by 张衡 on 2016/10/15.
//  Copyright © 2016年 张衡. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Compresser.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImage *image1 = [UIImage imageNamed:@"IMG_1460"];
    
    
    UIImage *image2 = [image1 compressWithTargetPixel:1280];
    
    
    [self loadImageFinished:image2];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadImageFinished:(UIImage *)image
{
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
}

@end
