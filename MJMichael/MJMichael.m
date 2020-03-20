//
//  MJMichael.m
//  MJMichael
//
//  Created by 李宏贵 on 2019/9/10.
//  Copyright © 2019 李宏贵. All rights reserved.
//

#import "MJMichael.h"
#import "AFNetworking.h"
//#import "WSProgressHUD.h"
//#import "MJExtension.h"
#import "MJRefresh.h"
#import "TZImagePickerController.h"

#define kUIScreen [UIScreen mainScreen].bounds
#define kUIS_W [UIScreen mainScreen].bounds.size.width
#define kUIS_H [UIScreen mainScreen].bounds.size.height
//#ifdef DEBUG
//#define //XLog(...) //XLog(__VA_ARGS__)
//#else
//#define //XLog(...)
//#endif
#define kLabel102Color [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]
static UIView *statusBar = nil;
@implementation MJMichael
#pragma mark-screenWidth
+ (CGFloat)mjScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}

#pragma mark-screenHeight
+ (CGFloat)mjScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}
#pragma mark-:隐藏导航栏底部黑线
+(void)mjHiddenBottomLine:(UIViewController*)vc
{
    [vc.navigationController.navigationBar setShadowImage:[UIImage new]];
}
#pragma mark-:导航栏高度
+ (CGFloat)mjNaviHeight
{
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        return 32;
    } else {
        if ([self isIphoneX]) {
            NSLog(@"isIphoneX");
            return 88;
        } else {
            return 64;
        }
    }
}
#pragma mark-状态栏高度
+ (CGFloat)mjStatusHeight
{
    return [UIApplication sharedApplication].statusBarFrame.size.height;
}
#pragma mark-导航栏高度
+ (CGFloat)mjNavBarHeight
{
    if (UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])) {
        return 32;
    } else {
        if ([self isIphoneX]) {
            NSLog(@"isIphoneX");
            return 88;
        } else {
            return 64;
        }
    }
}
#pragma mark-statusBarStyle
+(void)statusBarStyleColor:(UIColor *)statusColor
{
    if (CGColorEqualToColor(statusColor.CGColor,[UIColor whiteColor].CGColor)) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    }else {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
}
#pragma mark-:是否是iPhoneX
+ (BOOL)isIphoneX {
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    if (@available(iOS 11.0, *)) {
        if (window.safeAreaInsets.bottom > 0.0) {
            NSLog(@"isIphoneX");
            return YES;
        } else {
            NSLog(@"NotIsIphoneX");
            return NO;
        }
    } else {
        return NO;
    }
}
#pragma mark-:设置状态栏颜色
+ (void)setStatusBarBackgroundColor:(UIColor*)color
{
    if (@available(iOS 13.0, *)) {
        if (!statusBar) {
                 UIWindow *keyWindow = [UIApplication sharedApplication].windows[0];
                 statusBar = [[UIView alloc] initWithFrame:keyWindow.windowScene.statusBarManager.statusBarFrame];
                 [keyWindow addSubview:statusBar];
        }
    } else {
        // Fallback on earlier versions
        statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    }
    if([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
#pragma mark-:设置导航栏背景色
+(void)mjNaviBarColor:(UIViewController *)vc withColor:(UIColor *)color withAlpha:(CGFloat )alpha
{

    [vc.navigationController.navigationBar setBackgroundImage:[MJColor createImageWithColor:[color colorWithAlphaComponent:alpha] withRect:CGRectMake(0, 0, 1, 1)] forBarMetrics:UIBarMetricsDefault];
    [vc.navigationController.navigationBar setShadowImage:[UIImage new]];

    if (alpha>=1) {
        [vc.navigationController setNavigationBarHidden:NO animated:NO];
        vc.navigationController.navigationBar.translucent = NO;
    }else {
        vc.navigationController.navigationBar.translucent = YES;
    }
}
#pragma mark-:隐藏导航栏
+(void)mjHiddenNaviBar:(UIViewController *)vc
{
    vc.navigationController.navigationBar.translucent = YES;
    [vc.navigationController.navigationBar setShadowImage:[UIImage new]];
    [vc.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
}
#pragma mark-:设置导航栏左右字体颜色
+(void)mjNaviBarItemColor:(UIViewController *)vc withColor:(UIColor *)color
{
    [vc.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:color} forState:UIControlStateNormal];
    [vc.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:color} forState:UIControlStateNormal];
    [vc.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
}
#pragma mark-:ios暗黑模式
+(BOOL )mjDarkModeChange;
{
    if (@available(iOS 13.0, *)) {
        if (UITraitCollection.currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
            NSLog(@"mjDarkMode-------------------");
//            return @"darkMode";
            return YES;
        }else {
            NSLog(@"mjLightMode---------------------");
//            return @"lightMode";
            return NO;
        }
    } else {
//        return @"lightMode";
        return NO;
    }
}
#pragma mark-:判断控制器是否显示
+(BOOL)vcIsAppear:(UIViewController *)vc
{
    if (vc.isViewLoaded &&vc.view.window != nil) {
        return YES;
    }else {
        return NO;
    }
}
#pragma mark-:*判断null,nil
+ (BOOL)stringIsNullOrEmpty:(id)str
{
    return (str == nil || [str isKindOfClass:[NSNull class]] || [NSString stringWithFormat:@"%@",str].length == 0||[str isEqual:[NSNull null]]);
}


@end
#pragma mark-:MJColor
@interface MJColor()

@end
@implementation MJColor
#pragma mark-: *自定义图片大小:UISlider的大小等等
+(UIImage*)createImageWithColor:(UIColor*)color withRect:(CGRect)rect
{
    //    rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
#pragma mark-: *地址转图片
+(UIImage*)OriginImage:(UIImage*)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);//size为CGSize类型，即你所需要的图片尺寸
    [image drawInRect:CGRectMake(0,0, size.width, size.height)];
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
#pragma mark-: *url----->图片颜色
+(UIImage *)imageWithUrlStr:(NSString *)urlStr
{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    return [UIImage imageWithData:data];
}
#pragma mark-:#D83B23--->UIColor
+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // 判断前缀
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // 从六位数值中找到RGB对应的位数并转换
    NSRange range;
    range.location = 0;
    range.length = 2;
    //R、G、B
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];

    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end
#pragma mark-:MJLabel
@interface MJLabel()
@property(nonatomic,strong) UILabel *markLabel;
@end
@implementation MJLabel
#pragma mark-: *Label缩进
+(NSAttributedString *)setIndexHeadSpacing:(CGFloat)indexHeadSpacingValue withText:(NSString*)str withFont:(CGFloat )font withAlignment:(NSTextAlignment)alignment
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
//    paraStyle.lineSpacing = lineSpacingValue; //设置行间距
//    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = indexHeadSpacingValue;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = indexHeadSpacingValue;
    paraStyle.tailIndent = 0;
     //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:font],NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f                        };
      NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    return attributeStr;
}
#pragma mark-: *Label高度
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title withFontSize:(CGFloat )fontSize
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, 0)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    [label sizeToFit];
    CGFloat height = label.frame.size.height;
    return height;
}
#pragma mark-: *Label宽度
+ (CGFloat)getWidthWithTitle:(NSString *)title withFontSize:(CGFloat )fontSize{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kUIScreen.size.width, 0)];
    label.text = title;
    label.font = [UIFont systemFontOfSize:fontSize];
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize defaultSize = [title boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    [label sizeToFit];

    return defaultSize.width;
}
#pragma mark-: *Label高度
+ (CGFloat)getHeightWithTitle:(NSString *)title withFontSize:(CGFloat )fontSize
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kUIScreen.size.width, 0)];
    label.text = title;
    label.numberOfLines = 0;
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize defaultSize = [title boundingRectWithSize:CGSizeMake(kUIScreen.size.width, MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return defaultSize.height;
}
#pragma mark-:Label行间距
+(NSAttributedString *)setlineSpacing:(CGFloat)lineSpacingValue withText:(NSString*)str withFontSize:(CGFloat )fontSize withAlignment:(NSTextAlignment)alignment
{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = alignment;
    paraStyle.lineSpacing = lineSpacingValue; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize],NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@1.5f                        };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:str attributes:dic];
    return attributeStr;
}
#pragma mark-:Label行间距---height
+(CGFloat)attributeStrHeightWithText:(NSString*)str withWidth:(CGFloat)width withFontSize:(CGFloat )fontSize{
    CGSize maxSize = CGSizeMake(width, MAXFLOAT);
    //设定attributedString的字体及大小，一定要设置这个，否则计算出来的height是非常不准确的
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str attributes:nil];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, attributedString.length)];
    //计算attributedString的rect
    CGRect contentRect = [attributedString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return contentRect.size.height;
}
#pragma mark-:Label行间距---width
+(CGFloat)attributeStrWidthWithText:(NSString*)str withHeight:(CGFloat)height withFontSize:(CGFloat )fontSize{
    CGSize maxSize = CGSizeMake(MAXFLOAT, height);
    //设定attributedString的字体及大小，一定要设置这个，否则计算出来的height是非常不准确的
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str attributes:nil];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:NSMakeRange(0, attributedString.length)];
    //计算attributedString的rect
    CGRect contentRect = [attributedString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return contentRect.size.width;
}
#pragma mark-:自动布局后---高度
+(float)totalsArray:(NSArray *)totalsArray withMaxNum:(NSInteger)maxNum withFontSize:(CGFloat )fontSize withMarginTop:(NSInteger)marginTop withMarginLeft:(NSInteger)marginLeft withMarginRight:(NSInteger)marginRight withMargin:(NSInteger)margin
{
    NSInteger num  = totalsArray.count;
    CGFloat height = 0;
    if (num > maxNum) {
        num = maxNum;
    }
    CGFloat widthX = 0;
    for (int i = 0; i < num; i++) {
        CGFloat w = [MJLabel getWidthWithTitle:totalsArray[i] withFontSize:fontSize]+20;
        if ( w > kUIScreen.size.width -marginRight-marginLeft) {
            w = kUIScreen.size.width -marginRight-marginLeft;
        }
        CGFloat h = [MJLabel getHeightByWidth:kUIScreen.size.width-marginRight-marginLeft title:totalsArray[i] withFontSize:fontSize]+10;
        height = h+marginTop;
        if (widthX + w >kUIScreen.size.width -marginRight-marginLeft) {
            widthX = marginLeft;
            height += h+5;
        }
        widthX += w +margin;
    }
    return height;
}
@end
#define scale 0.5
#define titleFont [UIFont systemFontOfSize:18.0]
@implementation MJButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = titleFont;
        self.buttonStyle = imageLeft;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //自定义
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        UIImage *imageNor = [UIImage imageNamed:@"btn_nor_xiaosanjiao"];
        UIImage *imageHig = [UIImage imageNamed:@"btn_click_xiaosanjiao"];
        [self setImage:[UIImage imageNamed:@"btn_choose_xiaosanjiao"] forState:UIControlStateHighlighted];
        [self setImage:imageNor forState:UIControlStateNormal];
        [self setImage:imageHig forState:UIControlStateSelected];
    }

    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.titleLabel.font = titleFont;
        self.buttonStyle = imageLeft;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //自定义
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        UIImage *imageNor = [UIImage imageNamed:@"btn_nor_xiaosanjiao"];
        UIImage *imageHig = [UIImage imageNamed:@"btn_click_xiaosanjiao"];
        [self setImage:imageNor forState:UIControlStateNormal];
        [self setImage:imageHig forState:UIControlStateSelected];
    }

    return self;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (self.buttonStyle == imageRight) {
        return [self imageRectWithImageRightForContentTect:contentRect];
    }else if (self.buttonStyle == imageRightSide) {
        return [self imageRectWithImageRightSideForContentTect:contentRect];
    }else if (self.buttonStyle == imageTop){
        return [self imageRectWithImageTopForContentTect:contentRect];
    }else if (self.buttonStyle == imageBottom){
        return [self imageRectWithImageBottomForContentTect:contentRect];
    }else if (self.buttonStyle == colorCreatImageBottom) {
        return [self imageRectWithColorCreatImageBottomForContentTect:contentRect];
    }else if (self.buttonStyle == imageBottomNone) {
        return [self imageRectWithImageBottomNoneForContentTect:contentRect];
    }
    else {
        return [self imageRectWithImageLeftForContentTect:contentRect];
    }

}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (self.buttonStyle == imageRight) {
        return [self titleRectWithImageRightForContentTect:contentRect];
    }else if (self.buttonStyle == imageRightSide) {
        return [self titleRectWithImageRightSideForContentTect:contentRect];
    }else if (self.buttonStyle == imageTop){
        return [self titleRectWithImageTopForContentTect:contentRect];
    }else if (self.buttonStyle == imageBottom){
        return [self titleRectWithImageBottomForContentTect:contentRect];
    }else if (self.buttonStyle == colorCreatImageBottom) {
        return [self titleRectWithColorCreatImageBottomForContentTect:contentRect];
    }else if (self.buttonStyle == imageBottomNone) {
        return [self titleRectWithImageBottomNoneForContentTect:contentRect];
    }else {
        return [self titleRectWithImageLeftForContentTect:contentRect];
    }
}

#pragma mark imageTop 图片在上 文字在下
- (CGRect)imageRectWithImageTopForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2;
    CGFloat imageX = (CGRectGetWidth(contentRect) - imageWH)/2;
    CGRect rect = CGRectMake(imageX, imageY, imageWH, imageWH);

    return rect;
}

- (CGRect)titleRectWithImageTopForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2+imageWH+8;

    CGRect rect = CGRectMake(0, titleY, CGRectGetWidth(contentRect) , titleH);

    return rect;
}

#pragma mark imageLeft 图片在左 文字在右
- (CGRect)imageRectWithImageLeftForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat inteval = (CGRectGetHeight(contentRect)-imageWH)/2;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (imageX < 0) {
        imageX = 0;
    }
    CGRect rect = CGRectMake(imageX, inteval, imageWH, imageWH);

    return rect;
}

- (CGRect)titleRectWithImageLeftForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (imageX < 0) {
        imageX = 0;
    }
    CGRect rect = CGRectMake(imageWH+imageX, 0, titleW , CGRectGetHeight(contentRect));

    return rect;
}

#pragma mark imageBottom 图片在下 文字在上
- (CGRect)imageRectWithImageBottomForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2+titleH;
    CGFloat imageX = (CGRectGetWidth(contentRect) - imageWH)/2;
    CGRect rect = CGRectMake(imageX, imageY, imageWH, imageWH);

    return rect;
#warning 我自定义
    ////    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    //    CGFloat w = contentRect.size.width;
    //    CGFloat x = (CGRectGetWidth(contentRect))/2 -w/2;
    //    CGFloat y = (CGRectGetHeight(contentRect)) -5;
    //    CGFloat h = 3;
    //    return CGRectMake(x, y, w, h);
}
- (CGRect)titleRectWithImageBottomForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2;
#warning 自定义
    //    CGFloat titleY = (CGRectGetHeight(contentRect)-titleH)/2-5/2;
    CGRect rect = CGRectMake(0, titleY, CGRectGetWidth(contentRect) , titleH);

    return rect;
}
#warning 图片不显示
- (CGRect)imageRectWithImageBottomNoneForContentTect:(CGRect)contentRect{
    return CGRectMake(0, 0, 0, 0);
}
- (CGRect)titleRectWithImageBottomNoneForContentTect:(CGRect)contentRect{
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
#warning 自定义
    CGFloat titleY = (CGRectGetHeight(contentRect)-titleH)/2;
    CGRect rect = CGRectMake(0, titleY, CGRectGetWidth(contentRect) , titleH);

    return rect;
}
#warning imageRectWithColorCreatImageBottomForContentTect
- (CGRect)imageRectWithColorCreatImageBottomForContentTect:(CGRect)contentRect{
    //    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    //    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    //    CGFloat imageY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2+titleH;
    //    CGFloat imageX = (CGRectGetWidth(contentRect) - imageWH)/2;
    //    CGRect rect = CGRectMake(imageX, imageY, imageWH, imageWH);
    //
    //    return rect;
#warning 我自定义
    //    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat w = contentRect.size.width;
    CGFloat x = 0;
    CGFloat h = 2;
    CGFloat y = (CGRectGetHeight(contentRect)) -h;
    return CGRectMake(x, y, w, h);
}
- (CGRect)titleRectWithColorCreatImageBottomForContentTect:(CGRect)contentRect{
    CGFloat imageWH = 3;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2;
#warning 自定义
    //    CGFloat titleY = (CGRectGetHeight(contentRect)-titleH)/2-5/2;
    CGRect rect = CGRectMake(0, titleY, CGRectGetWidth(contentRect) , titleH);

    return rect;
}
//imageRectWithImageRightSideForContentTect
- (CGRect)imageRectWithImageRightSideForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat inteval = (CGRectGetHeight(contentRect)-imageWH)/2;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    if (titleW > CGRectGetWidth(contentRect)*0.8) {
        titleW = CGRectGetWidth(contentRect)*0.8;
    }
    CGFloat titleX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (titleX < 0) {
        titleX = 0;
    }
    CGRect rect = CGRectMake(CGRectGetWidth(contentRect) -imageWH , inteval, imageWH, imageWH);

    return rect;

    //    #warning 我自定义
    //    CGFloat w = 25/2;
    //    CGFloat x = (CGRectGetWidth(contentRect))/2 + titleW/2.2;
    //    CGFloat h = 16/2;
    //    CGFloat y = self.frame.size.height/2 - h/2;
    //    return CGRectMake(x, y, w, h);
}
//titleRectWithImageRightSideForContentTect
- (CGRect)titleRectWithImageRightSideForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    //    CGFloat titleW = [MCButton getWidthWithTitle:[self currentTitle] withFontSize:13];
    CGFloat titleX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
#warning 我自定义
    //    CGFloat titleX = (CGRectGetWidth(contentRect))/2 - titleW/2;
    //    if (titleX < 0) {
    //        titleX = 0;
    //    }
    if (titleW > CGRectGetWidth(contentRect)*0.8) {
        titleW = CGRectGetWidth(contentRect)*0.8;
        CGRect rect = CGRectMake(titleX, 0, titleW , CGRectGetHeight(contentRect));
        return rect;
    }
    CGRect rect = CGRectMake(titleX, 0, titleW , CGRectGetHeight(contentRect));
    return rect;

}
#pragma mark imageRight 图片在右 文字在左
- (CGRect)imageRectWithImageRightForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat inteval = (CGRectGetHeight(contentRect)-imageWH)/2;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    if (titleW > CGRectGetWidth(contentRect)*0.8) {
        titleW = CGRectGetWidth(contentRect)*0.8;
    }
    CGFloat titleX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (titleX < 0) {
        titleX = 0;
    }
    CGRect rect = CGRectMake( titleW +titleX+5, inteval, imageWH, imageWH);

    return rect;

    //    #warning 我自定义
    //    CGFloat w = 25/2;
    //    CGFloat x = (CGRectGetWidth(contentRect))/2 + titleW/2.2;
    //    CGFloat h = 16/2;
    //    CGFloat y = self.frame.size.height/2 - h/2;
    //    return CGRectMake(x, y, w, h);
}

- (CGRect)titleRectWithImageRightForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    //[MCButton getWidthWithTitle:model.name withFontSize:13]
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
#warning 我自定义
    //    CGFloat titleX = (CGRectGetWidth(contentRect))/2 - titleW/2;
    //    if (titleX < 0) {
    //        titleX = 0;
    //    }
    if (titleW > CGRectGetWidth(contentRect)*0.8) {
        titleW = CGRectGetWidth(contentRect)*0.8;
        CGRect rect = CGRectMake(titleX, 0, titleW , CGRectGetHeight(contentRect));
        return rect;
    }
    CGRect rect = CGRectMake(titleX, 0, titleW , CGRectGetHeight(contentRect));
    return rect;

}
//imageRectWithImageEdgeRightForContentTect
- (CGRect)imageRectWithImageEdgeRightForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*0.4;
    CGFloat inteval = (CGRectGetHeight(contentRect)-imageWH)/2;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    if (titleW > CGRectGetWidth(contentRect)*0.8) {
        titleW = CGRectGetWidth(contentRect)*0.8;
    }
    CGFloat titleX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (titleX < 0) {
        titleX = 0;
    }
    CGRect rect = CGRectMake(CGRectGetWidth(contentRect)- imageWH, inteval, imageWH, imageWH);

    return rect;

}
//titleRectWithImageEdgeRightForContentTect
- (CGRect)titleRectWithImageEdgeRightForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*0.4;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleX = (CGRectGetWidth(contentRect)-titleW-imageWH-5);
#warning 我自定义
    //    CGFloat titleX = (CGRectGetWidth(contentRect))/2 - titleW/2;
    //    if (titleX < 0) {
    //        titleX = 0;
    //    }
    if (titleW > CGRectGetWidth(contentRect)*0.8) {
        titleW = CGRectGetWidth(contentRect)*0.8;
        CGRect rect = CGRectMake(titleX, 0, titleW , CGRectGetHeight(contentRect));
        return rect;
    }
    CGRect rect = CGRectMake(titleX, 0, titleW , CGRectGetHeight(contentRect));
    return rect;

}
#pragma mark 计算标题内容宽度
- (CGFloat)widthForTitleString:(NSString *)string ContentRect:(CGRect)contentRect{
    if (string) {
        CGSize constraint = contentRect.size;
        //        NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string  attributes:@{NSFontAttributeName: self.titleLabel.font}];
        NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string];
        CGRect rect = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        CGFloat width = MAX(size.width, 30);
        CGFloat imageW = [self imageForState:UIControlStateNormal].size.width;

        if (width+imageW > CGRectGetWidth(contentRect)) { // 当标题和图片宽度超过按钮宽度时不能越界
            return  CGRectGetWidth(contentRect) - imageW;
        }
        return width*1.2;
    }
    else {
        return CGRectGetWidth(contentRect);
    }
}

#pragma mark 计算标题文字内容的高度
- (CGFloat)heightForTitleString:(NSString *)string ContentRect:(CGRect)contentRect{
    if (string) {
        CGSize constraint = contentRect.size;
        NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.titleLabel.font}];
        CGRect rect = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        CGFloat height = MAX(size.height, 5);

        if (height > CGRectGetHeight(contentRect)/2) { // 当标题高度超过按钮1/2宽度时
            return  CGRectGetHeight(contentRect)/2 ;
        }
        return height;
    }
    else {
        return CGRectGetHeight(contentRect)/2;
    }
}
#pragma mark-:butto的width
+ (CGFloat)getWidthWithTitle:(NSString *)title withFontSize:(CGFloat )fontSize withImage:(UIImage *)image
{
    CGFloat imageW = image.size.width;
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size.width+imageW;
}
#pragma mark-:butto的height
+ (CGFloat)getHeightWithTitle:(NSString *)title withFontSize:(CGFloat )fontSize withImage:(UIImage *)image
{
    CGFloat imageW = image.size.width;
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:options attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
    return size.height+imageW;
}
@end

@implementation MJAlertView
#pragma mark-:弹窗按钮
+(void)mjAlertTitle:(NSString *)title withMessage:(NSString *)message withCancelTitle:(NSString *)cancelTitle withCancelAction:(CancelAction)cancelAction withSureTitle:(NSString *)sureTitle withSureAction:(SureAction)sureAction withVC:(UIViewController *)vc withCount:(NSInteger)count sureIndex:(NSInteger)index
{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        cancelAction(NO);
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        sureAction(YES);
    }];
    if (count == 0) {

    }else if (count == 1) {
        [alertVC addAction:sure];
    }else {
        if (index == 0) {
            [alertVC addAction:sure];
            [alertVC addAction:cancel];
        }else {
            [alertVC addAction:cancel];
            [alertVC addAction:sure];
        }
    }

    [vc presentViewController:alertVC animated:YES completion:^{

    }];
}
@end

#define kID 1323880244
@interface MJCheckVersion()
@end
@implementation MJCheckVersion

#pragma mark-代理:检测版本
+(void)chectVersion
{
    NSString *currentTime = [TimeHelper currentZeroTime];
    NSTimeInterval nextTime = [TimeHelper whichTime:@"2019/2/20"];
    if ([currentTime integerValue]>nextTime ) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:0 target:self selector:@selector(timerAction) userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
}
+(void)timerAction
{
    //    NSString *getLocalVersion = [CheckVersion getAPPInfo];
    //    //最新的获取数据的地址：
    //    //https://itunes.apple.com/lookup?id=1441941518
    //    NSString *urlStr=[NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%d",kID];
    //    NSURL *url=[NSURL URLWithString:urlStr];
    //    NSData *json = [NSData dataWithContentsOfURL:url];
    //    //        //XLog(@"json:%@",json);
    //    NSDictionary *dictVersion = [NSJSONSerialization JSONObjectWithData:json options:0 error:NULL];//解析json文件
    //    //XLog(@"dictVersion:%@",dictVersion);
    //    NSArray *results = [dictVersion objectForKey:@"results"];
    //    NSDictionary *dictSub = results[0];
    //    //XLog(@"results:%@",results);
    //    NSString  *message = [dictSub objectForKey:@"releaseNotes"];
    //    NSString *version = [dictSub objectForKey:@"version"];
    //    //XLog(@"version:%@",version);
    //    if (![version isEqualToString:getLocalVersion]) {
    //        TYAlertView *alertView = [TYAlertView alertViewWithTitle:[NSString stringWithFormat:@"发现新版本v%@",version] message:@""];
    //        alertView.messageLabel.text = message;
    //        alertView.messageLabel.textAlignment = NSTextAlignmentJustified;
    //        [alertView addAction:[TYAlertAction actionWithTitle:@"立即更新" style:TYAlertActionStyleDefault handler:^(TYAlertAction *action) {
    //            // 1441941518
    //            //                NSString *str = urlStr //更换id即可
    //            //https://itunes.apple.com/cn/app/id1441941518
    //            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%d",kID]]];
    //            ////XLog(@"%@",action.title);
    //        }]];
    //        TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationDropDown];
    //        [self presentViewController:alertController animated:YES completion:nil];
    //    }
}
/**
 *getAPPInfo:获取当前版本
 *getAPPStoreInfo:获取App Store版本
 *getAPPInfo<getAPPStoreInfo弹出更新视图
 *releaseNotes:App Store版本更新记录
 */
+(void)compareVersionForReleaseNotes:(ReleaseNotesBlock )releaseNotes withLatestVersion:(UpdateShowBlock)latestVersion
{
    double app_Version = [[[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"]doubleValue];

    //最新的获取数据的地址：
    NSString *urlStr=[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%d",kID];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSData *json = [NSData dataWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:0 error:NULL];//解析json文件
    NSArray *resultsSub = [dict objectForKey:@"results"];

    //XLog(@"获取App Store版本:%@",resultsSub);
    NSDictionary *result = [resultsSub objectAtIndex:0];
    NSString *releaseMsg = [result objectForKey:@"releaseNotes"];
    //XLog(@"releaseMsg:%@",releaseMsg);
    double appStore = [[result objectForKey:@"version"]doubleValue];//获得AppStore中的app的版本
    if (app_Version < appStore) {
        releaseNotes(releaseMsg);
    }else {
        latestVersion(YES);
    }

}
//获取当前版本
+(double )getAPPInfo{
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    // app版本
    double app_Version = [[infoDictionary objectForKey:@"CFBundleShortVersionString"]doubleValue];
    return app_Version;
}
////获取App Store版本
+(double )getAPPStoreInfo{
    //最新的获取数据的地址：
    NSString *urlStr=[NSString stringWithFormat:@"https://itunes.apple.com/cn/lookup?id=%d",kID];
    NSURL *url=[NSURL URLWithString:urlStr];
    NSData *json = [NSData dataWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json options:0 error:NULL];//解析json文件
    NSArray *resultsSub = [dict objectForKey:@"results"];
    //XLog(@"获取App Store版本:%@",resultsSub);
    NSDictionary *result = [resultsSub objectAtIndex:0];
    NSString  *message = [result objectForKey:@"releaseNotes"];
    double versionStr = [[result objectForKey:@"version"]doubleValue];//获得AppStore中的app的版本
    return versionStr;
}
@end

//上线
//#define kRootPath @"http://202.109.75.181:9080/"
//测试
#define kRootPath @"http://tt.kakacaifu.com/baby_product/"
//本地
//#define kRootPath @"http://192.168.50.26/"
@interface MJHttpManager()

@end
@implementation MJHttpManager
/**
 self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
 */
+ (void)PostWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock callBackJSON:(BOOL)callBackJSON withAFMediaType:(BOOL )afMediaType
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];



    if (afMediaType) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
    }
    [manager POST:[NSString stringWithFormat:@"%@%@",kRootPath,urlString] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {

            NSDictionary *dict = [NSDictionary dictionary];
            if (callBackJSON) {
                dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                successBlock(dict);
                NSLog(@"MJHttpManagerDict:%@",dict);
                NSLog(@"json:%@",[responseObject mj_JSONString]);
            }else {
                NSLog(@"responseObject:%@",responseObject);
                successBlock(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            //XLog(@"error:%@",error);
        }
    }];

}
/**
 *filePathType:.png,.caf
 *mimeType:@"image/png",audio/caf
 */
+ (void)PostAFMultipartWithUrlString:(NSString *)urlString
                          parameters:(id)parameters withFileData:(NSData *)fileData withFilePathType:(NSString *)filePathType mimeType:(NSString *)mimeType
                             success:(SuccessBlock)successBlock
                             failure:(FailureBlock)failureBlock callBackJSON:(BOOL)callBackJSON withAFMediaType:(BOOL )afMediaType
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];



    if (afMediaType) {
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
    }
    [manager POST:[NSString stringWithFormat:@"%@%@",kRootPath,urlString] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *outputPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/%@", [[formatter stringFromDate:[NSDate date]] stringByAppendingString:filePathType]];
        [formData appendPartWithFileData:fileData name:@"file" fileName:outputPath mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        float update = uploadProgress.fractionCompleted*100;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //[WSProgressHUD showWithStatus:[NSString stringWithFormat:@"%.f%%",update] maskType:WSProgressHUDMaskTypeClear maskWithout:WSProgressHUDMaskWithoutDefault];
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            //[WSProgressHUD showImage:[UIImage imageNamed:@""] status:@"上传成功"];
            //[WSProgressHUD dismiss];
            NSDictionary *dict = [NSDictionary dictionary];
            if (callBackJSON) {
                dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                successBlock(dict);
                //XLog(@"MJHttpManagerDict:%@",dict);
//                //XLog(@"json:%@",[responseObject mj_JSONString]);
            }else {
                //XLog(@"responseObject:%@",responseObject);
                successBlock(responseObject);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            //[WSProgressHUD showImage:[UIImage imageNamed:@""] status:@"上传失败,请重试..."];
            //XLog(@"error:%@",error);
            //            //[WSProgressHUD dismiss];
        }
    }];


}
- (id)mj_JSONObject
{
    if ([self isKindOfClass:[NSString class]]) {
        return [NSJSONSerialization JSONObjectWithData:[((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    } else if ([self isKindOfClass:[NSData class]]) {
        return [NSJSONSerialization JSONObjectWithData:(NSData *)self options:kNilOptions error:nil];
    }

    return nil;
}
- (NSString *)mj_JSONString
{
    if ([self isKindOfClass:[NSString class]]) {
        return (NSString *)self;
    } else if ([self isKindOfClass:[NSData class]]) {
        return [[NSString alloc] initWithData:(NSData *)self encoding:NSUTF8StringEncoding];
    }

    return [[NSString alloc] initWithData:[self mj_JSONData] encoding:NSUTF8StringEncoding];
}
#pragma mark - 转换为JSON
- (NSData *)mj_JSONData
{
    if ([self isKindOfClass:[NSString class]]) {
        return [((NSString *)self) dataUsingEncoding:NSUTF8StringEncoding];
    } else if ([self isKindOfClass:[NSData class]]) {
        return (NSData *)self;
    }

    return [NSJSONSerialization dataWithJSONObject:[self mj_JSONObject] options:kNilOptions error:nil];
}
//[UIView animateWithDuration:1 animations:^{
//
//} completion:^(BOOL finished) {
//
//}];
/**/
/**
 *  异步网络(parameters相同)
 */
+ (void)PostAsyncWithUrlString:(NSString *)urlString withArray:(NSArray *)array
                    parameters:(id)parameters
                       success:(SuccessBlock)successBlock
                       failure:(FailureBlock)failureBlock callBackJSON:(BOOL)callBackJSON completion:(Completion)completion
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    //使用GCD的信号量 dispatch_semaphore_t 创建同步请求
    dispatch_group_t group =dispatch_group_create();
    dispatch_queue_t globalQueue=dispatch_get_global_queue(0, 0);
    dispatch_semaphore_t semaphore= dispatch_semaphore_create(0);
    dispatch_group_async(group, globalQueue, ^{
        for (int i = 0; i<array.count; i++) {
            NSDictionary *dict = @{
                                   @"id":array[i]
                                   };
            [manager POST:[NSString stringWithFormat:@"%@%@",kRootPath,urlString] parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                //XLog(@"HomeresponseObject:%@",responseObject);
                if (successBlock) {
                    NSDictionary *dict = [NSDictionary dictionary];
                    if (callBackJSON) {
                        dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
                        successBlock(dict);
                        //XLog(@"MJHttpManagerDict:%@",dict);
                        //XLog(@"json:%@",[responseObject mj_JSONString]);
                    }else {
                        //XLog(@"responseObject:%@",responseObject);
                        successBlock(responseObject);
                    }
                }
                dispatch_semaphore_signal(semaphore);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                //[WSProgressHUD dismiss];
                dispatch_semaphore_signal(semaphore);
            }];
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        }

    });

    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            //[WSProgressHUD dismiss];
            completion(YES);
        });
    });

}
+ (void)GetWithUrlString:(NSString *)urlString
              parameters:(id)parameters
                 success:(SuccessBlock)successBlock
                 failure:(FailureBlock)failureBlock callBackJSON:(BOOL)callBackJSON withAFMediaType:(BOOL )afMediaType;
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (afMediaType) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/javascript", nil];
    }
    [manager GET:[NSString stringWithFormat:@"%@%@",kRootPath,urlString] parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            NSArray *dict = [NSArray array];
            if (callBackJSON) {
                dict = [responseObject mj_JSONObject];
                successBlock(dict);
                //XLog(@"MJHttpManagerDict:%@",dict);
                //XLog(@"json:%@",[responseObject mj_JSONString]);
            }else {
                //XLog(@"responseObject:%@",responseObject);
                successBlock(responseObject);
            }
        }
        //[WSProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
            //[WSProgressHUD dismiss];
        }

    }];
}
@end

@implementation MJMutableAttributedString
#pragma mark-:移除空格,横线
+ (NSString *)removeSpaceAndEnter:(NSString *)str
{
    NSString *temp = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    temp = [temp stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return temp;
}
#pragma mark-代理:超链接
+(NSMutableAttributedString *)openUrlString:(NSString *)urlStr withDefaultString:(NSString *)defaultString
{

    NSMutableAttributedString *attaStr = [[NSMutableAttributedString alloc] initWithString:defaultString];
    NSMutableAttributedString *linkStr = [[NSMutableAttributedString alloc] initWithString:urlStr];
    [linkStr addAttributes:@{NSLinkAttributeName: [NSURL URLWithString:urlStr]} range:NSMakeRange(0, urlStr.length)];
    [attaStr appendAttributedString:linkStr];
    return attaStr;
}


#pragma mark-:label斜线
+(NSMutableAttributedString *)underlineStyleSingleDefaultString:(NSString *)defaultString
{
    return [[NSMutableAttributedString alloc] initWithString:defaultString attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
}
#pragma mark-:字体颜色变换
+(NSMutableAttributedString *)defaultString:(NSString *)defaultString changeColor:(UIColor *)color forCharStr:(NSString *)charStr
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:defaultString];
    [attrStr  addAttribute:NSForegroundColorAttributeName value:color range:[defaultString rangeOfString:charStr]];
    return attrStr;
}
#pragma mark-:字体大小变换
+(NSMutableAttributedString *)defaultString:(NSString *)defaultString changeFontNumber:(CGFloat )fontNumber forCharStr:(NSString *)charStr
{
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:defaultString];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontNumber] range:[defaultString rangeOfString:charStr]];
    return attrStr;
}
@end
@interface MJRefreshHF()

@end
@implementation MJRefreshHF
+(MJRefreshHF *)mjManager
{
    return [[self alloc]init];
}
#pragma mark---:加载MJRefreshNormalHeader,scrollView:tableView,collectionView,completion:下拉加载
+(void)mjRefreshHeaderInScrollView:(UIScrollView *)scrollView beginRefreshing:(BOOL)beginRefreshing completion:(MJRefreshHFComponentBlock)completion
{
    MJRefreshNormalHeader *normalHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        completion();
    }];
    //初始化时开始刷新
    if (beginRefreshing) {
        [normalHeader beginRefreshing];
    }
    scrollView.mj_header = normalHeader;
}
#pragma mark---:加载MJRefreshAutoNormalFooter,scrollView:tableView,collectionView,completion:下拉加载
+(void)mjRefreshFooterInScrollView:(UIScrollView *)scrollView completion:(MJRefreshHFComponentBlock)completion
{
    MJRefreshAutoNormalFooter *normalFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        completion();
    }];
    //    normalFooter.frame = CGRectMake(CGRectGetMinX(scrollView.mj_footer.frame), CGRectGetMinY(scrollView.mj_footer.frame), scrollView.mj_footer.frame.size.width, 0);
    normalFooter.hidden = YES;
    scrollView.mj_footer = normalFooter;
}
#pragma mark---:mj_footer隐藏
+(void)mjRefreshFooterHiddenInScrollView:(UIScrollView *)scrollView
{
    scrollView.mj_footer.hidden = YES;
}
#pragma mark---:mj_footer设置高度
+(void)mjRefreshSetupFooterFrameInScrollView:(UIScrollView *)scrollView
{
    scrollView.mj_footer.hidden = NO;
    //    scrollView.mj_footer.frame = CGRectMake(CGRectGetMinX(scrollView.mj_footer.frame), CGRectGetMinY(scrollView.mj_footer.frame), scrollView.mj_footer.frame.size.width, 44);
}
#pragma mark---:上拉,下拉加载结束
+(void)mjHFEndRefreshingByScrollView:(UIScrollView *)scrollView withCount:(NSInteger)count
{

    [scrollView.mj_header endRefreshing];
    scrollView.mj_header.hidden = NO;
    scrollView.mj_footer.hidden = NO;
    if (count < 15) {
        scrollView.mj_footer.state = MJRefreshStateNoMoreData;
    }else if (count == 15)
    {
        [scrollView.mj_footer endRefreshing];
    }
    for (id obj in scrollView.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView *iv = (UIImageView *)obj;
            if (iv.tag == 1000) {
                [iv removeFromSuperview];
            }
        }else  if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)obj;
            if (label.tag == 1001) {
                [label removeFromSuperview];
            }
        }
    }
}
#pragma mark---:mj_footer状态:没有更多数据了
+(void)mjFooterStateNoMoreDataByScrollView:(UIScrollView *)scrollView
{
    scrollView.mj_footer.state = MJRefreshStateNoMoreData;
}
#pragma mark---:没有数据,清除MJRefreshNormalHeader,MJRefreshAutoNormalFooter
+(void)clearHFByScrollView:(UIScrollView *)scrollView
{
    scrollView.mj_header.hidden = YES;
    scrollView.mj_footer.hidden = YES;

}
#pragma mark---:没有数据,显示占位符图片
+ (void)emptyDataSet:(UIScrollView *)scrollView y:(CGFloat )y{
    UIImage *image = [UIImage imageNamed:@"empty"];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 75, 54)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, kUIScreen.size.width, 17)];
    for (id obj in scrollView.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            UIImageView *iv = (UIImageView *)obj;
            if (iv.tag != 1000) {
                imageView.image = image;
                imageView.tag = 1000;
                imageView.center = CGPointMake(scrollView.center.x, y);
                [scrollView addSubview:imageView];
                label.tag = 1001;
                label.text = @"暂无数据";
                label.textAlignment = NSTextAlignmentCenter;
                label.textColor = kLabel102Color;
                label.font = [UIFont systemFontOfSize:14];
                label.center = CGPointMake(scrollView.center.x, CGRectGetMaxY(imageView.frame)+15);
                [scrollView addSubview:label];
            }
        }
    }
}
#pragma mark---:删除,显示占位符图片
+ (void)clearEmptyDataSet:(UIScrollView *)scrollView
{
    for (id obj in scrollView.subviews) {
        if ([obj isKindOfClass:[UIImageView class]]) {
            //XLog(@"obj:%@",obj);
            UIImageView *iv = (UIImageView *)obj;
            UILabel *label = (UILabel *)obj;
            if (iv.tag == 1000) {
                [iv removeFromSuperview];
            }else if (label.tag == 1001) {
                [label removeFromSuperview];
            }
        }
    }
}

#pragma mark---:没有数据,显示占位符语句
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSString *title = @"暂无数据";
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont boldSystemFontOfSize:14],
                                 NSForegroundColorAttributeName:kLabel102Color
                                 };
    return [[NSAttributedString alloc] initWithString:title attributes:attributes];
}
@end
@interface MJUpdateImageVideo()<UINavigationControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate,TZImagePickerControllerDelegate>
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,strong) NSData *imageData;
@property(nonatomic,strong) NSData *vedioData;
@end
@implementation MJUpdateImageVideo
+ (instancetype)updateManager {
    return [[[self class] alloc] init];
}
-(void)updateImageVideoView:(UIView *)customeView withVC:(UIViewController *)vc allowPickingMultipleVideo:(BOOL )allowPickingMultipleVideo
{
    ////    //打开照相机和图片
    //    UIAlertController *sheetControler = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //    CustomePickerImageVC *picker = [[CustomePickerImageVC alloc]init];
    //    picker.edgesForExtendedLayout =  UIRectEdgeNone;
    //    picker.automaticallyAdjustsScrollViewInsets = NO;
    //    picker.allowsEditing = YES;
    //    picker.delegate = self;
    //    sheetControler.popoverPresentationController.sourceView = customeView;
    //    sheetControler.popoverPresentationController.sourceRect = customeView.frame;
    //    [self pushTZImagePickerControllerWithVC:vc allowPickingMultipleVideo:allowPickingMultipleVideo];
    //    [vc presentViewController:sheetControler animated:YES completion:nil] ;
}
#pragma mark-代理:上传图片
- (void)pushTZImagePickerControllerWithVC:(UIViewController *)vc allowPickingMultipleVideo:(BOOL )allowPickingMultipleVideo successImageBlock:(SuccessImageBlock)successImageBlock{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES allowPickingMultipleVideo:allowPickingMultipleVideo];
    [imagePickerVc setUiImagePickerControllerSettingBlock:^(UIImagePickerController *imagePickerController) {
        imagePickerController.videoQuality = UIImagePickerControllerQualityTypeHigh;
    }];
    [imagePickerVc.navigationBar setBackgroundImage:[MJColor createImageWithColor:[UIColor colorWithRed:170/255.0 green:43/255.0 blue:36/255.0 alpha:1] withRect:CGRectMake(0.0f, 0.0f, 1.0f, 1.0f)] forBarMetrics:UIBarMetricsDefault];
    imagePickerVc.navigationBar.shadowImage = [MJColor createImageWithColor:[UIColor colorWithRed:170/255.0 green:43/255.0 blue:36/255.0 alpha:1] withRect:CGRectMake(0.0f, 0.0f, 1.0f, 1.0f)];
    imagePickerVc.iconThemeColor = [UIColor colorWithRed:170/255.0 green:43/255.0 blue:36/255.0 alpha:1];
    imagePickerVc.showPhotoCannotSelectLayer = YES;
    imagePickerVc.cannotSelectLayerColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [imagePickerVc setPhotoPickerPageUIConfigBlock:^(UICollectionView *collectionView, UIView *bottomToolBar, UIButton *previewButton, UIButton *originalPhotoButton, UILabel *originalPhotoLabel, UIButton *doneButton, UIImageView *numberImageView, UILabel *numberLabel, UIView *divideLine) {
        [doneButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }];

    imagePickerVc.allowPickingImage = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.allowPickingGif = NO;
    imagePickerVc.allowPickingMultipleVideo = allowPickingMultipleVideo; // 是否可以多选视频
    imagePickerVc.sortAscendingByModificationDate = YES;
    imagePickerVc.allowTakePicture = YES;

    imagePickerVc.showSelectBtn = YES;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.needCircleCrop = NO;
    imagePickerVc.statusBarStyle = UIStatusBarStyleLightContent;
    imagePickerVc.showSelectedIndex = YES;

    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        //XLog(@"photos:%@---assets:%@",photos,assets);
        self.image = photos[0];
        self.imageData = UIImageJPEGRepresentation(self.image, 0.6);
        //选择回调
        if (successImageBlock) {
            successImageBlock(self.imageData,self.image);
        }

    }];

    [vc presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark-代理:上传视频
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(PHAsset *)asset
{
    PHAssetResource * resource = [[PHAssetResource assetResourcesForAsset: asset] firstObject];

    NSString *string1 = [resource.description stringByReplacingOccurrencesOfString:@"{" withString:@""];
    NSString *string2 = [string1 stringByReplacingOccurrencesOfString:@"}" withString:@""];
    NSString *string3 = [string2 stringByReplacingOccurrencesOfString:@", " withString:@","];
    NSMutableArray *resourceArray =  [NSMutableArray arrayWithArray:[string3 componentsSeparatedByString:@" "]];
    [resourceArray removeObjectAtIndex:0];
    [resourceArray removeObjectAtIndex:0];

    for (NSInteger index = 0; index<resourceArray.count; index++) {
        NSString *string = resourceArray[index];
        NSString *ret = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        resourceArray[index] = ret;
    }

    NSMutableDictionary *videoInfo = [[NSMutableDictionary alloc] init];

    for (NSString *string in resourceArray) {
        NSArray *array = [string componentsSeparatedByString:@"="];
        videoInfo[array[0]] = array[1];
    }

    NSString *filenam = [videoInfo objectForKey:@"filename"];

    /*
     {
     assetLocalIdentifier = "A99AA1C3-7D59-4E10-A8D3-BF4FAD7A1BC6/L0/001";
     fileSize = 2212572;
     filename = "IMG_0049.MOV";
     size = "1080,1920";
     type = video;
     uti = "com.apple.quicktime-movie";
     }
     */

    PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
    options.version = PHImageRequestOptionsVersionCurrent;
    options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;

    PHImageManager *manager = [PHImageManager defaultManager];
    [manager requestAVAssetForVideo:asset
                            options:options
                      resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
                          // asset 类型为 AVURLAsset  为此资源的fileURL
                          // <AVURLAsset: 0x283386e60, URL = file:///var/mobile/Media/DCIM/100APPLE/IMG_0049.MOV>
                          AVURLAsset *urlAsset = (AVURLAsset *)asset;
                          // 视频数据
                          self.vedioData = [NSData dataWithContentsOfURL:urlAsset.URL];
                          if (self.successVedioBlock) {
                              self.successVedioBlock(self.vedioData);
                          }

                      }];
}
-(void)updateImageSuccessImage:(SuccessImageBlock)successImageBlock
{
    if (successImageBlock) {
        successImageBlock(self.imageData,self.image);
    }

    //    if (failureImageBlock) {
    //        successImageBlock(imageData);
    //    }
    //    if (failureVedioBlock) {
    //        successVedioBlock(vedioData);
    //    }
}
-(void)updateVideoSuccessVedio:(SuccessVedioBlock)successVedioBlock
{
    if (successVedioBlock) {
        successVedioBlock(self.vedioData);
    }
}
@end

@implementation MJNumberSwitchString
+(NSString *)mjNumberSwitchString:(NSInteger )number
{
    return [NSString stringWithFormat:@"%ld",number];
}
+(NSString *)mjObjSwitchString:(NSObject *)obj
{
    return [NSString stringWithFormat:@"%@",obj];
}
+ (BOOL)isNumber:(NSString *)strValue
{
    if (strValue == nil || [strValue length] <= 0)
    {
        return NO;
    }

    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *filtered = [[strValue componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];

    if (![strValue isEqualToString:filtered])
    {
        return NO;
    }
    return YES;
}
+(NSInteger)mjStringSwitchNumber:(NSString *)numberString
{
    return [numberString integerValue];
}
+(NSMutableArray *)mjStringSwitchArray:(NSString *)numberString
{
    return [NSMutableArray arrayWithArray:[numberString componentsSeparatedByString:@"-"]];
}
+(NSMutableString *)mjArraySwitchString:(NSMutableArray *)stringArray withCharStr:(NSString *)charStr
{
    NSMutableString *mutaStr = [NSMutableString string];
    for (int i = 0; i < stringArray.count; i++) {
        if ( i == 0) {
            [mutaStr appendString:stringArray[i]];
        }else {
            [mutaStr appendString:[NSString stringWithFormat:@"%@%@",charStr,stringArray[i]]];
        }
    }
    return mutaStr;
}
@end



@implementation MJPhoneAndMailCheckObject
+(BOOL)phoneNumberIsTrue:(NSString *)phoneNumber{

    /**
     * 移动号段正则表达式
     */
    NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
    /**
     * 联通号段正则表达式
     */
    NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
    /**
     * 电信号段正则表达式
     */
    NSString *CT_NUM = @"^((13[0-9])|(14[0-9])|(15[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\\d{8}$";
    NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
    BOOL isMatch1 = [pred1 evaluateWithObject:phoneNumber]&&phoneNumber.length == 11;
    NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
    BOOL isMatch2 = [pred2 evaluateWithObject:phoneNumber]&&phoneNumber.length == 11;
    NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
    BOOL isMatch3 = [pred3 evaluateWithObject:phoneNumber]&&phoneNumber.length == 11;

    if (isMatch1 || isMatch2 || isMatch3 ) {
        return YES;
    }else{
        return NO;
    }

}
+(BOOL)checkEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
@interface TimeHelper()
@property (nonatomic,assign)YMDMS yMinDMSStyle;

@end
@implementation TimeHelper
//#pragma mark-代理:当前哪年那月
#pragma mark-代理:当前月多少天
+(NSUInteger)numberOfDaysInMonthWithDate:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}
/*当前0点0分*/
+(NSString *)currentZeroTime
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSDate *zeroDate = [calendar dateFromComponents:components];
    NSTimeInterval currentZeroTime = [zeroDate timeIntervalSince1970]*1000;
    NSString *currentZeroTimeStr = [NSString stringWithFormat:@"%.0f",currentZeroTime];
    return currentZeroTimeStr;
}
/*某一天0点0分*/
+(NSString *)WhichDayZeroTime:(NSInteger )yearTime withMonthTime:(NSInteger )monthTime withDayTime:(NSInteger )dayTime
{
    NSString *dataTime = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)yearTime,(long)monthTime,(long)dayTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString* beginStr = [NSString stringWithFormat:@"%@ 00:00:00",dataTime];
    NSDate *beginDate=[formatter dateFromString:beginStr];
    NSTimeInterval dayZeroTime = [beginDate timeIntervalSince1970]*1000;
    NSString *dayZeroTimeStr = [NSString stringWithFormat:@"%.0f",dayZeroTime];
    return dayZeroTimeStr;
}
/*本周日0点0分*/
+(NSString *)currentWeekZeroTime
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:now];
    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    ////XLog(@"weekDay:%ld",(long)weekDay);//5
    // 得到几号
    NSInteger day = [comp day];
    ////XLog(@"day:%ld",(long)day);//2
    //    ////XLog(@"weekDay:%ld  day:%ld",weekDay,day);

    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 7 - weekDay;
    }

    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];

    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [lastDayComp setDay:day + lastDiff];
    //    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];

    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    ////XLog(@"一周开始 %@",[formater stringFromDate:firstDayOfWeek]);
    NSString *sundayString = [NSString stringWithFormat:@"%@",[formater stringFromDate:firstDayOfWeek]];
    NSDate *lastDate = [formater dateFromString:sundayString];
    long firstStamp = [lastDate timeIntervalSince1970]*1000;
    ////XLog(@"firstStamp:%ld",firstStamp);
    ////XLog(@"当前 %@",[formater stringFromDate:now]);
    ////XLog(@"一周结束 %@",[formater stringFromDate:lastDayOfWeek]);
    NSString *timeStr = [NSString stringWithFormat:@"%ld",firstStamp];
    ////XLog(@"timeStr:%@",timeStr);
    return timeStr;
}
/*当前时间毫秒*/
+(NSTimeInterval )whichTime:(NSString *)time
{
    //    NSString *dataTime = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)yearTime,(long)monthTime,(long)dayTime];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    //    NSString* beginStr = [NSString stringWithFormat:@"%@ 00:00:00",dataTime];
    NSDate *beginDate=[formatter dateFromString:time];
    NSTimeInterval dayZeroTime = [beginDate timeIntervalSince1970]*1000;
    return dayZeroTime;
}
//当月第一天
+(NSString *)currentMonthFirstDayTime
{
    NSDate*currentDate = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];NSInteger year=[components year];
    NSInteger month=[components month];
    //构造当月的1号时间
    NSDateComponents *firstDayCurrentMonth = [[NSDateComponents alloc] init];
    [firstDayCurrentMonth setYear:year];
    [firstDayCurrentMonth setMonth:month];
    [firstDayCurrentMonth setDay:1];
    //当月1号
    NSDate *firstDayOfCurrentMonth = [calendar dateFromComponents:firstDayCurrentMonth];
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[firstDayOfCurrentMonth timeIntervalSince1970]*1000];
    return timeStr;
}
#pragma mark-:当前先星期几
+ (NSString *)getCurrentWeekDay
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:now];
    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    //    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    NSInteger weekDay = [comp weekday];

    return chineseNumeralsArray[weekDay -1];
}
#pragma mark-:NSDate转化---YMDMS
+ (NSString *)getWhichYMDDate:(YMDMS)yMinDMSStyle withDate:(NSDate *)date
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    switch (yMinDMSStyle) {
        case YMDMinS:
        {
            [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        }
            break;
        case YMD:
        {
            [formatter setDateFormat:@"yyyy-MM-dd"];
        }
            break;
        case YM:
        {
            [formatter setDateFormat:@"yyyy-MM"];
        }
            break;
        case MD:
        {
            [formatter setDateFormat:@"MM-dd"];
        }
            break;
        case HM:
        {
            [formatter setDateFormat:@" hh:mm"];
        }
            break;
        case Y:
        {
            [formatter setDateFormat:@"yyyy"];
        }
            break;
        case M:
        {
            [formatter setDateFormat:@"MM"];
        }
            break;

        default:
        {
            [formatter setDateFormat:@"dd hh:mm"];
        }
            break;
    }
    NSString *dateTime=[formatter stringFromDate:date];
    NSDate *dateChange = [formatter dateFromString:dateTime];
    NSString *dateString       = [formatter stringFromDate: dateChange];
    return dateString;
}
+ (NSString *)getSelectWhichweekDayForSelectWhichData:(NSDate *)selectDate;
{
    //    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:selectDate];
    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    //    NSArray *arabicNumeralsArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chineseNumeralsArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    NSInteger weekDay = [comp weekday];

    return chineseNumeralsArray[weekDay -1];
}
/**
 *时间转换NSDate
 */
+(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}
#pragma mark-:当前几号
+ (NSInteger )getCurrentDayDate
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:now];
    // 得到几号
    NSInteger day = [comp day];
    return day;
}
+ (NSInteger )getSelectWhichNumberForSelectDate:(NSDate *)selectDate
{
    //    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:selectDate];
    // 得到几号
    NSInteger day = [comp day];
    return day;
}

- (void)getCurrentWeek
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                                         fromDate:now];
    // 得到星期几
    // 1(星期天) 2(星期二) 3(星期三) 4(星期四) 5(星期五) 6(星期六) 7(星期天)
    NSInteger weekDay = [comp weekday];
    // 得到几号
    NSInteger day = [comp day];

    //    ////XLog(@"weekDay:%ld  day:%ld",weekDay,day);

    // 计算当前日期和这周的星期一和星期天差的天数
    long firstDiff,lastDiff;
    if (weekDay == 1) {
        firstDiff = 1;
        lastDiff = 0;
    }else{
        firstDiff = [calendar firstWeekday] - weekDay;
        lastDiff = 7 - weekDay;
    }

    // 在当前日期(去掉了时分秒)基础上加上差的天数
    NSDateComponents *firstDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [firstDayComp setDay:day + firstDiff];
    NSDate *firstDayOfWeek= [calendar dateFromComponents:firstDayComp];

    NSDateComponents *lastDayComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [lastDayComp setDay:day + lastDiff];
    //    NSDate *lastDayOfWeek= [calendar dateFromComponents:lastDayComp];

    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd"];
    ////XLog(@"一周开始 %@",[formater stringFromDate:firstDayOfWeek]);
    //    NSString *sundayString = [NSString stringWithFormat:@"%@",[formater stringFromDate:firstDayOfWeek]];
    //    NSDate *lastDate = [formater dateFromString:sundayString];
    //    long firstStamp = [lastDate timeIntervalSince1970]*1000;
    ////XLog(@"firstStamp:%ld",firstStamp);
    ////XLog(@"当前 %@",[formater stringFromDate:now]);
    ////XLog(@"一周结束 %@",[formater stringFromDate:lastDayOfWeek]);

    /**
     2018-08-02 11:05:51.836838+0800 KamunShangCheng[916:169288] 一周开始 2018-07-29
     2018-08-02 11:05:51.837603+0800 KamunShangCheng[916:169288] 当前 2018-08-02
     2018-08-02 11:06:07.599108+0800 KamunShangCheng[916:169288] 一周结束
     */

}
#pragma mark-:2个日期对比先后
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    ////XLog(@"oneDay : %@, anotherDay : %@", oneDay, anotherDay);
    /**
     //该方法用于排序时调用:
     . 当实例保存的日期值与anotherDate相同时返回NSOrderedSame
     . 当实例保存的日期值晚于anotherDate时返回NSOrderedDescending
     . 当实例保存的日期值早于anotherDate时返回NSOrderedAscending
     */
    if (result == NSOrderedDescending) {
        //在指定时间前面 过了指定时间 过期
        ////XLog(@"oneDay  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //没过指定时间 没过期
        //////XLog(@"Date1 is in the past");
        return -1;
    }else {
        return 0;

    }
    //刚好时间一样.
    //////XLog(@"Both dates are the same");

}

#pragma mark-:当前时间
+ (NSString *)getCurrentYMDMS:(YMDMS)yMinDMSStyle{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    switch (yMinDMSStyle) {
        case YMDMinS:
        {
            [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        }
            break;
        case YMD:
        {
            [formatter setDateFormat:@"yyyy-MM-dd"];
        }
            break;
        case YM:
        {
            [formatter setDateFormat:@"yyyy-MM"];
        }
            break;
        case MD:
        {
            [formatter setDateFormat:@"MM-dd"];
        }
            break;
        case HM:
        {
            [formatter setDateFormat:@" hh:mm"];
        }
            break;
        case Y:
        {
            [formatter setDateFormat:@"yyyy"];
        }
            break;
        case M:
        {
            [formatter setDateFormat:@"MM"];
        }
            break;

        default:
        {
            [formatter setDateFormat:@"dd hh:mm"];
        }
            break;
    }

    //    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}
/*当前时间戳*/
+(NSInteger)getNowTimestamp{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];//现在时间
    //XLog(@"设备当前的时间:%@",[formatter stringFromDate:datenow]);
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[datenow timeIntervalSince1970]] integerValue]*1000;
    //XLog(@"设备当前的时间戳:%ld",(long)timeSp); //时间戳的值

    return timeSp;

}
#pragma mark-代理:时间戳(毫秒转时间格式)
+(NSString *)backGroundWith:(NSInteger)timestamp withYMDMS:(YMDMS)yMinDMSStyle
{
    // iOS 生成的时间戳是10位
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    switch (yMinDMSStyle) {
        case YMDMinS:
        {
            [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
        }
            break;
        case YMD:
        {
            [formatter setDateFormat:@"yyyy-MM-dd"];
        }
            break;
        case YM:
        {
            [formatter setDateFormat:@"yyyy-MM"];
        }
            break;
        case MD:
        {
            [formatter setDateFormat:@"MM-dd"];
        }
            break;
        case HM:
        {
            [formatter setDateFormat:@"hh:mm"];
        }
            break;
        case Y:
        {
            [formatter setDateFormat:@"yyyy"];
        }
            break;
        case M:
        {
            [formatter setDateFormat:@"MM"];
        }
            break;

        default:
        {
            [formatter setDateFormat:@"dd hh:mm"];
        }
            break;
    }
    NSTimeInterval interval    = timestamp / 1000.0;
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    NSString *dateString       = [formatter stringFromDate: date];
    return dateString;
}

@end
@interface UserDefaultsHelper()
@end
@implementation UserDefaultsHelper
+(NSUserDefaults *)userDefaultManager
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    return userDefaults;
}
+(void)checkLogIn:(UIViewController *)vc completion:(Completion)completion
{
    if (![UserDefaultsHelper readUserId].length) {
        [UserDefaultsHelper presentVC:vc];
        completion(NO);
    }else {
        completion(YES);
    }
}
+(void)presentVC:(UIViewController *)vc
{
//    LogInOrOutVC *logInVC = [[LogInOrOutVC alloc]init];
//    MainNavC *navi = [[MainNavC alloc]initWithRootViewController:logInVC];
//    [vc presentViewController:navi animated:YES completion:^{
//        [UserDefaultsHelper clearUserDafault];
//    }];
}
+(void)clearUserDafault
{
    //XLog(@"id:%@",[UserDefaultsHelper readUserId]);
    [[UserDefaultsHelper userDefaultManager] removeObjectForKey:@"headimg"];
    [[UserDefaultsHelper userDefaultManager] removeObjectForKey:@"sex"];
    [[UserDefaultsHelper userDefaultManager] removeObjectForKey:@"nickname"];
    [[UserDefaultsHelper userDefaultManager] removeObjectForKey:@"sign"];
    [[UserDefaultsHelper userDefaultManager] removeObjectForKey:@"userAccount"];
    [[UserDefaultsHelper userDefaultManager] removeObjectForKey:@"userId"];
    //XLog(@"id:%@",[UserDefaultsHelper readUserId]);
}
+(void)saveAutoLogIn:(id)autoLogIn value:(NSString *)autoLogInYESORNO
{
    [[UserDefaultsHelper userDefaultManager] setValue:autoLogInYESORNO forKey:@"autoLogIn"];
    [[UserDefaultsHelper userDefaultManager] synchronize];
}
+(NSString *)readAutoLogIn;
{
    NSString *autoLogIn = [[UserDefaultsHelper userDefaultManager] objectForKey:@"autoLogIn"];
    return autoLogIn;
}
+(NSString *)readSex
{
    NSString *autoLogIn = [[UserDefaultsHelper userDefaultManager] objectForKey:@"sex"];
    return autoLogIn;
}
+(void)saveSex:(id)sex value:(NSString *)sexValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:sexValue forKey:@"sex"];
    [[UserDefaultsHelper userDefaultManager] synchronize];
}
+(void)saveQQHeadImg:(id)headImg withHeadImgValue:(NSString *)headImgValue saveNickname:(id)nickname withNicknameValue:(NSString *)nicknameValue saveIsAgreement:(id)isAgreement withIsAgreementValue:(NSString *)isAgreementValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:nicknameValue forKey:@"nickname"];
    [[UserDefaultsHelper userDefaultManager] setValue:headImgValue forKey:@"headimg"];
    [[UserDefaultsHelper userDefaultManager] setValue:isAgreementValue forKey:@"isAgreement"];
}
+(void)saveQQNONickNameHeadImg:(id)headImg withHeadImgValue:(NSString *)headImgValue saveIsAgreement:(id)isAgreement withIsAgreementValue:(NSString *)isAgreementValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:headImgValue forKey:@"headimg"];
    [[UserDefaultsHelper userDefaultManager] setValue:isAgreementValue forKey:@"isAgreement"];
}
+(void)saveQQNOHeadImgNickname:(id)nickname withNicknameValue:(NSString *)nicknameValue saveIsAgreement:(id)isAgreement withIsAgreementValue:(NSString *)isAgreementValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:nicknameValue forKey:@"nickname"];
    [[UserDefaultsHelper userDefaultManager] setValue:isAgreementValue forKey:@"isAgreement"];
}
+(void)saveWechatHeadImg:(id)headImg withHeadImgValue:(NSString *)headImgValue saveNickname:(id)nickname withNicknameValue:(NSString *)nicknameValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:nicknameValue forKey:@"nickname"];
    [[UserDefaultsHelper userDefaultManager] setValue:headImgValue forKey:@"headimg"];
}
+(void)saveWechatNONickNameHeadImg:(id)headImg withHeadImgValue:(NSString *)headImgValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:headImgValue forKey:@"headimg"];
}
+(void)saveWechatNOHeadImgNickname:(id)nickname withNicknameValue:(NSString *)nicknameValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:nicknameValue forKey:@"nickname"];
}

+(void)savePhoneHeadImg:(id)headImg withHeadImgValue:(NSString *)headImgValue saveUid:(id)uid withUidValue:(NSString *)uidValue saveNickname:(id)nickname withNicknameValue:(NSString *)nicknameValue savePhone:(id)phone withPhone:(NSString *)phoneValue saveType:(id)type andType:(NSString *)typeValue saveToken:(id)token withTokenValue:(NSString *)tokenValue saveIsAgreement:(id)isAgreement withIsAgreementValue:(NSString *)isAgreementValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:nicknameValue forKey:@"nickname"];
    [[UserDefaultsHelper userDefaultManager] setValue:tokenValue forKey:@"token"];
    [[UserDefaultsHelper userDefaultManager] setValue:phoneValue forKey:@"phone"];
    [[UserDefaultsHelper userDefaultManager] setValue:typeValue forKey:@"type"];
    [[UserDefaultsHelper userDefaultManager] setValue:uidValue forKey:@"uid"];
    [[UserDefaultsHelper userDefaultManager] setValue:headImgValue forKey:@"headimg"];
    [[UserDefaultsHelper userDefaultManager] setValue:isAgreementValue forKey:@"isAgreement"];
    [[UserDefaultsHelper userDefaultManager] synchronize];
}
+(void)savePhoneNOHeadImgUid:(id)uid withUidValue:(NSString *)uidValue saveNickname:(id)nickname withNicknameValue:(NSString *)nicknameValue savePhone:(id)phone withPhone:(NSString *)phoneValue saveType:(id)type andType:(NSString *)typeValue saveToken:(id)token withTokenValue:(NSString *)tokenValue saveIsAgreement:(id)isAgreement withIsAgreementValue:(NSString *)isAgreementValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:uidValue forKey:@"uid"];
    [[UserDefaultsHelper userDefaultManager] setValue:nicknameValue forKey:@"nickname"];
    [[UserDefaultsHelper userDefaultManager] setValue:tokenValue forKey:@"token"];
    [[UserDefaultsHelper userDefaultManager] setValue:phoneValue forKey:@"phone"];
    [[UserDefaultsHelper userDefaultManager] setValue:typeValue forKey:@"type"];
    [[UserDefaultsHelper userDefaultManager] setValue:isAgreementValue forKey:@"isAgreement"];
    [[UserDefaultsHelper userDefaultManager] synchronize];
}
+(void)savePhoneNONickNameHeadImg:(id)headImg withHeadImgValue:(NSString *)headImgValue saveUid:(id)uid withUidValue:(NSString *)uidValue savePhone:(id)phone withPhone:(NSString *)phoneValue saveType:(id)type andType:(NSString *)typeValue saveToken:(id)token withTokenValue:(NSString *)tokenValue saveIsAgreement:(id)isAgreement withIsAgreementValue:(NSString *)isAgreementValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:tokenValue forKey:@"token"];
    [[UserDefaultsHelper userDefaultManager] setValue:phoneValue forKey:@"phone"];
    [[UserDefaultsHelper userDefaultManager] setValue:typeValue forKey:@"type"];
    [[UserDefaultsHelper userDefaultManager] setValue:headImgValue forKey:@"headimg"];
    [[UserDefaultsHelper userDefaultManager] setValue:uidValue forKey:@"uid"];
    [[UserDefaultsHelper userDefaultManager] setValue:isAgreementValue forKey:@"isAgreement"];
    [[UserDefaultsHelper userDefaultManager] synchronize];
}
+(void)saveHeadimg:(id)headimg value:(NSString *)headimgValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:headimgValue forKey:@"headimg"];
}
+(void)saveNickName:(id)nickName value:(NSString *)nickNameValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:nickNameValue forKey:@"nickname"];
}
+(void)saveIphone:(id)iphone value:(NSString *)iphoneValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:iphoneValue forKey:@"phone"];
}
+(NSString *)readNickName
{
    NSString *nickName = [[UserDefaultsHelper userDefaultManager] objectForKey:@"nickname"];
    return nickName;
}
+(NSString *)readUserId;
{
    NSString *uid = [[UserDefaultsHelper userDefaultManager] objectForKey:@"userId"];
    return uid;
}
+(NSString *)readToken
{
    NSString *token = [[UserDefaultsHelper userDefaultManager] objectForKey:@"token"];
    return token;
}
+(void)saveToken:(id)token value:(NSString *)tokenValue;
{
    [[UserDefaultsHelper userDefaultManager] setValue:tokenValue forKey:@"token"];
}
+(NSString *)readIphone
{
    NSString *phone = [[UserDefaultsHelper userDefaultManager] objectForKey:@"phone"];
    return phone;
}
+(NSString *)readType
{
    NSString *type = [[UserDefaultsHelper userDefaultManager] objectForKey:@"type"];
    return type;
}
+(void)saveUserId:(id)userId value:(NSString *)userIdValue;
{
    [[UserDefaultsHelper userDefaultManager] setValue:userId forKey:@"userId"];
}
+(void)saveType:(id)token value:(NSString *)typeValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:typeValue forKey:@"type"];
}
+(NSString *)readCreatetime
{
    NSString *createtime = [[UserDefaultsHelper userDefaultManager] objectForKey:@"createtime"];
    return createtime;
}
+(NSString *)readIsAgreement
{
    NSString *isAgreement = [[UserDefaultsHelper userDefaultManager] objectForKey:@"isAgreement"];
    return isAgreement;
}
+(void)saveIsAgreement:(id)isAgreement value:(NSString *)isAgreementValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:isAgreementValue forKey:@"isAgreement"];
}
+(NSString *)readHeadimg
{
    NSString *headimg = [[UserDefaultsHelper userDefaultManager] objectForKey:@"headimg"];
    return headimg;
}
+(NSString *)readSign
{
    return [[UserDefaultsHelper userDefaultManager] objectForKey:@"sign"];
}
+(void)savesSign:(id)sign value:(NSString *)signValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:signValue forKey:@"sign"];
}
+(NSString *)readUserAccount
{
    return [[UserDefaultsHelper userDefaultManager] objectForKey:@"userAccount"];
}
+(void)savesUserAccount:(id)userAccount value:(NSString *)userAccountValue
{
    [[UserDefaultsHelper userDefaultManager] setValue:userAccountValue forKey:@"userAccount"];
}
+(NSString *)readQQOpenID
{
    NSString *qqOpenID = [[UserDefaultsHelper userDefaultManager] objectForKey:@"qqOpenID"];
    return qqOpenID;
}
@end
