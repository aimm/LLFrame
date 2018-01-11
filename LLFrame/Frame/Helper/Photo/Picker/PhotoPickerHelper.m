//
//  PhotoPickerHelper.m
//  LLFrame
//
//  Created by Hailong Guo on 2018/1/1.
//  Copyright © 2018年 Hailong Guo. All rights reserved.
//

#import "PhotoPickerHelper.h"
#import <TZImagePickerController/TZImagePickerController.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "TZImageManager.h"
#import <Photos/Photos.h>
#import "SysAlertHelper.h"

@interface PhotoPickerHelper ()<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imagePickerVC;

@property (nonatomic,strong) NSMutableArray <UIImage *> *selectedPhotos;

@end

@implementation PhotoPickerHelper

#pragma mark - 初始化
- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _maxCount = 9;
        _columnCount = 4;
        _allowCrop = NO;
        _cropFrame = CGRectZero;
        _selectedPhotos = [NSMutableArray new];
    }
    return self;
}

#pragma mark - 覆写set方法，保证裁剪框frame合法
- (void)setCropFrame:(CGRect)cropFrame
{
    if (cropFrame.size.width != kScreenWidth)
    {
        CGFloat requiredWidth = kScreenWidth;
        CGFloat newHeight = cropFrame.size.height * requiredWidth / cropFrame.size.width;
        
        cropFrame.origin.x = 0;
        cropFrame.size.width = requiredWidth;
        cropFrame.origin.y += (cropFrame.size.height - newHeight) * 0.5;
        cropFrame.size.height = newHeight;
    }
    
    _cropFrame = cropFrame;
}

- (void)setViewController:(UIViewController *)viewController
{
    _viewController = viewController;
    
    // 适应主题色
    self.imagePickerVC.navigationBar.barTintColor = _viewController.navigationController.navigationBar.barTintColor;
    self.imagePickerVC.navigationBar.tintColor = _viewController.navigationController.navigationBar.tintColor;
    
    UIBarButtonItem *tzBarItem, *BarItem;
    if (@available(iOS 9.0, *))
    {
        tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
        BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
    }
    else
    {
        tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
        BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
    }
    
    NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
    [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
}

#pragma mark - 展示照片选择器
- (void)showImagePicker
{
    TZImagePickerController *imagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:self.maxCount columnNumber:self.columnCount delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVC.delegate = self;
    // 不记录已选择图片
    imagePickerVC.selectedAssets = nil;
    imagePickerVC.allowPickingImage = YES;
    imagePickerVC.allowPickingVideo = NO;
    imagePickerVC.allowPickingOriginalPhoto = NO;
    imagePickerVC.showSelectBtn = self.maxCount > 1;
    imagePickerVC.allowCrop = self.allowCrop;
    imagePickerVC.cropRect = self.cropFrame;
    
    [self.viewController presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark - 选择完照片
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto
{
    [self handleSelectPhotoCompletedWithNewSelectedPhotos:photos];
}

#pragma mark - 处理选择照片完成
- (void)handleSelectPhotoCompletedWithNewSelectedPhotos:(NSArray *)newSelectedPhotos
{
    [self.selectedPhotos removeAllObjects];
    [self.selectedPhotos addObjectsFromArray:newSelectedPhotos];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoPickerHelper:selectPhotoCompleted:)])
    {
        NSMutableArray *temp = [NSMutableArray new];
        
        [self.selectedPhotos enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            LLPhoto *photo = [LLPhoto photoWithImage:obj];
            [temp addObject:photo];
        }];
        
        [self.delegate photoPickerHelper:self selectPhotoCompleted:temp.copy];
    }
}

#pragma mark - 相机
- (UIImagePickerController *)imagePickerVC
{
    if (!_imagePickerVC)
    {
        _imagePickerVC = [UIImagePickerController new];
        _imagePickerVC.delegate = self;
        _imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePickerVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    }
    return _imagePickerVC;
}

#pragma mark - 拍照
- (void)takePhoto
{
    // 获取权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (authStatus == AVAuthorizationStatusRestricted ||
        authStatus == AVAuthorizationStatusDenied)
    {
        // 无相机权限 做一个友好的提示
        [SysAlertHelper showSystemAlertInVC:self.viewController title:@"无法使用相机" message:@"请在iPhone的""设置-隐私-相机""中允许访问相机" cancelBtnTitle:@"取消" cancelBtnClickedBlock:nil okBtnTitle:@"设置" okBtnClicekdBlock:^{
            
            [self toSetPreference];
        }];
    }
    else if (authStatus == AVAuthorizationStatusNotDetermined)
    {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            
            if (granted)
            {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self takePhoto];
                });
            }
        }];
    }
    else if ([TZImageManager authorizationStatus] == 2)
    {
        // 已被拒绝，没有相册权限，将无法保存拍的照片
        [SysAlertHelper showSystemAlertInVC:self.viewController title:@"无法访问相册" message:@"请在iPhone的""设置-隐私-相册""中允许访问相册" cancelBtnTitle:@"取消" cancelBtnClickedBlock:nil okBtnTitle:@"设置" okBtnClicekdBlock:^{
            
            [self toSetPreference];
        }];
    }
    else if ([TZImageManager authorizationStatus] == 0)
    {
        // 未请求过相册权限
        [[TZImageManager manager] requestAuthorizationWithCompletion:^{
            
            [self takePhoto];
        }];
    }
    else
    {
        // 调用相机
        [self.viewController presentViewController:self.imagePickerVC animated:YES completion:nil];
    }
}

#pragma mark - 拍照完成
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSString *type = info[UIImagePickerControllerMediaType];
    
    if ([type isEqualToString:@"public.image"])
    {
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        
        // 不允许裁剪
        if (self.allowCrop == NO)
        {
            [self handleTakePhotoCompletedWithPhoto:image];
        }
        else
        {
            TZImagePickerController *tzImagePickerVC = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
            
            [tzImagePickerVC showProgressHUD];
            
            TZImageManager * manager = [TZImageManager manager];
            
            // 保存图片，获取到asset
            [manager savePhotoWithImage:image location:nil completion:^(NSError *error){
                
                if (error)
                {
                    [tzImagePickerVC hideProgressHUD];
                }
                else
                {
                    [manager getCameraRollAlbum:NO allowPickingImage:YES completion:^(TZAlbumModel *model) {
                        
                        [manager getAssetsFromFetchResult:model.result allowPickingVideo:NO allowPickingImage:YES completion:^(NSArray<TZAssetModel *> *models) {
                            
                            [tzImagePickerVC hideProgressHUD];
                            
                            TZAssetModel *assetModel = models.firstObject;
                            
                            if (tzImagePickerVC.sortAscendingByModificationDate)
                            {
                                assetModel = models.lastObject;
                            }
                            
                            // 裁剪
                            TZImagePickerController *imagePicker = [[TZImagePickerController alloc] initCropTypeWithAsset:assetModel.asset photo:image completion:^(UIImage *cropImage, id asset) {
                                
                                [self handleTakePhotoCompletedWithPhoto:cropImage];
                            }];
                            imagePicker.allowCrop = YES;
                            imagePicker.cropRect = self.cropFrame;
                            
                            [self.viewController presentViewController:imagePicker animated:YES completion:nil];
                        }];
                    }];
                }
            }];
        }
    }
}

#pragma mark - 处理拍照完成
- (void)handleTakePhotoCompletedWithPhoto:(UIImage *)photo
{
    LLPhoto *llphoto = [LLPhoto photoWithImage:photo];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(photoPickerHelper:takePhotoCompleted:)])
    {
        [self.delegate photoPickerHelper:self takePhotoCompleted:llphoto];
    }
}

#pragma mark - 拍照取消
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if ([picker isKindOfClass:[UIImagePickerController class]])
    {
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 到系统设置
- (void)toSetPreference
{
    NSURL *setURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    [[UIApplication sharedApplication] openURL:setURL];
}

@end
