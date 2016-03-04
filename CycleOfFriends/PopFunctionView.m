//
//  PopFunctionView.m
//  CycleOfFriends
//
//  Created by 胡阳 on 15/12/21.
//  Copyright © 2015年 young4ever. All rights reserved.
//

#import "PopFunctionView.h"

@interface PopFunctionView ()

{
    /** 暗黑色的view */
    UIView *_darkView;
    
    /** 代理 */
    id<PopFunctionViewDelegate> _delegate;
}
/**
 *  类型
 */
@property (nonatomic, assign) PopFunctionViewType type ;

/**
 *  背景黑框图片
 */
@property (nonatomic, strong) UIImageView *backGroundImage ;

/**
 *  复制按钮
 */
@property (nonatomic, strong) UIButton    *btnCopy ;

/**
 *  删除按钮
 */
@property (nonatomic, strong) UIButton    *btnDelete ;

/**
 *  白色分割线
 */
@property (nonatomic, strong) UIView      *whiteSeperatorLine ;

/**
 *  显示的那个window
 */
@property (nonatomic, strong) UIWindow    *backWindow;

@end

@implementation PopFunctionView


- (instancetype)initWithFrame:(CGRect)frame position:(CGPoint)location type:(PopFunctionViewType)type delegate:(id<PopFunctionViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type ;
        _delegate = delegate ;
        
        // 暗黑色的view
        UIView *darkView = [[UIView alloc] init];
        [darkView setAlpha:0];
        [darkView setUserInteractionEnabled:NO];
        [darkView setFrame:(CGRect){0, 0, [UIScreen mainScreen].bounds.size}];
        [darkView setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.1]];
        [self addSubview:darkView];
        _darkView = darkView;
        
        // 添加单点手势隐藏pop view
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss:)];
        [darkView addGestureRecognizer:tap];
        
        // 带箭头的背景图片
        _backGroundImage = [[UIImageView alloc] init];
        _backGroundImage.userInteractionEnabled = YES ;
        _backGroundImage.backgroundColor = [UIColor clearColor];
        _backGroundImage.center = CGPointMake([UIScreen mainScreen].bounds.size.width*0.5, location.y - 45.f) ;
        if (_type == PopFunctionViewTypeCopyAndDelete) {
            _backGroundImage.bounds = CGRectMake(0.f, 0.f, 125.f, 50.f);
            _backGroundImage.image = [self imageWithStretchableName:@"pop_copy_delete"] ;
            
        }else if (_type == PopFunctionViewTypeCopy){
            _backGroundImage.bounds = CGRectMake(0.f, 0.f, 60.f, 50.f);
            _backGroundImage.image = [UIImage imageNamed:@"pop_copy"];
        }
        
        [self addSubview:_backGroundImage];
        
        // 复制按钮
        _btnCopy = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnCopy.frame = CGRectMake(0.f, 0.f, 60.f, 40.f);
        [_btnCopy setTitle:@"复制" forState:UIControlStateNormal];
        [_btnCopy setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnCopy setBackgroundColor:[UIColor clearColor]];
        [_btnCopy addTarget:self action:@selector(buttonCopyAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundImage addSubview:_btnCopy];
        
        
        if (_type == PopFunctionViewTypeCopyAndDelete) {
            // 白色分割线
            _whiteSeperatorLine = [[UIView alloc] init];
            _whiteSeperatorLine.frame = CGRectMake(62.f, 10.f, 1.f, 20.f);
            _whiteSeperatorLine.backgroundColor = [UIColor whiteColor];
            [_backGroundImage addSubview:_whiteSeperatorLine];
            
            // 删除按钮
            _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
            _btnDelete.frame = CGRectMake(64.f, 0.f, 60.f, 40.f);
            [_btnDelete setTitle:@"删除" forState:UIControlStateNormal];
            [_btnDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_btnDelete setBackgroundColor:[UIColor clearColor]];
            [_btnDelete addTarget:self action:@selector(buttonDeleteAction:) forControlEvents:UIControlEventTouchUpInside];
            [_backGroundImage addSubview:_btnDelete];
        }
        
        [self setFrame:(CGRect){0, 0, [UIScreen mainScreen].bounds.size}];
        [self.backWindow addSubview:self];
        
    }
    return self ;
}

/**
 *  复制
 */
- (void)buttonCopyAction:(UIButton *)btn
{
    [self dismiss:nil];
    
    if (_delegate && [_delegate respondsToSelector:@selector(copyButtonClickedOnPopFunctionView:)]) {
        [_delegate copyButtonClickedOnPopFunctionView:self];
    }
}
/**
 *  删除
 */
- (void)buttonDeleteAction:(UIButton *)btn
{
    [self dismiss:nil];
    
    if (_delegate && [_delegate respondsToSelector:@selector(deleteButtonClickedOnPopFunctionView:)]) {
        [_delegate deleteButtonClickedOnPopFunctionView:self];
    }
}

/**
 *  隐藏
 */
- (void)dismiss:(UITapGestureRecognizer *)tap {
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0];
                         [_darkView setUserInteractionEnabled:NO];
                         
                         [_backGroundImage setAlpha:0.0] ;
                         
                     }
                     completion:^(BOOL finished) {
                         
                         _backWindow.hidden = YES;
                         
                         [self removeFromSuperview];
                     }];
}
/**
 *  显示
 */
- (void)show
{
    _backWindow.hidden = NO;
    
    [UIView animateWithDuration:0.3f
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         
                         [_darkView setAlpha:0.2f];
                         [_darkView setUserInteractionEnabled:YES];
                         
                         [_backGroundImage setAlpha:1.0] ;
                         
                     }
                     completion:nil];
}

#pragma mark - 懒加载window
- (UIWindow *)backWindow {
    
    if (_backWindow == nil) {
        
        _backWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backWindow.windowLevel       = UIWindowLevelStatusBar;
        _backWindow.backgroundColor   = [UIColor clearColor];
        _backWindow.hidden = NO;
    }
    
    return _backWindow;
}

/**
 *  拉伸图片
 */
- (UIImage *)imageWithStretchableName:(NSString *)imageName
{
    UIImage *img = [UIImage imageNamed:imageName] ;
    
    return [img stretchableImageWithLeftCapWidth:img.size.width * 0.5 topCapHeight:img.size.height * 0.5] ;
}

@end
