//
//  MJMichael.h
//  MJMichael
//
//  Created by 李宏贵 on 2019/9/10.
//  Copyright © 2019 李宏贵. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface MJMichael : NSObject

#pragma mark-:隐藏导航栏底部黑线
+(void)mjHiddenBottomLine:(UIViewController*)vc;
#pragma mark-screenHeight
+ (CGFloat)mjScreenHeight;
#pragma mark-screenWidth
+ (CGFloat)mjScreenWidth;
#pragma mark-状态栏高度
+ (CGFloat)mjStatusHeight;
#pragma mark-导航栏高度
+ (CGFloat)mjNavBarHeight;
#pragma mark-statusBarStyle
+(void)statusBarStyleColor:(UIColor *)statusColor;
#pragma mark-:是否是iPhoneX
+ (BOOL)isIphoneX;
#pragma mark-:设置状态栏颜色
+ (void)setStatusBarBackgroundColor:(UIColor*)color;
#pragma mark-:设置导航栏背景色
+(void)mjNaviBarColor:(UIViewController *)vc withColor:(UIColor *)color withAlpha:(CGFloat )alpha;
#pragma mark-:设置导航栏左右字体颜色
+(void)mjNaviBarItemColor:(UIViewController *)vc withColor:(UIColor *)color;
#pragma mark-:隐藏导航栏
+(void)mjHiddenNaviBar:(UIViewController *)vc;
#pragma mark-:ios暗黑模式
/**
 *是否是暗黑模式
 */
+(BOOL )mjDarkModeChange;
#pragma mark-:判断控制器是否显示
/**
*判断控制器是否显示
*/
+(BOOL)vcIsAppear:(UIViewController *)vc;
/**
 *判断null,nil
 */
+ (BOOL)stringIsNullOrEmpty:(id)str;


@end
@interface MJWKWebView : WKWebView
typedef void (^JSSendNativeBlack)(NSString *jsSendNativeStr);
typedef void (^NativeSendJSBlack)(NSString *NativeSendJSStr);
+(MJWKWebView *)shareManagerFrame:(CGRect)frame ByVC:(UIViewController *)vc loadHTML:(NSString *)html;
-(void)mjBridgJSSendNative:(NSString *)bridgeMethod jsSendNative:(JSSendNativeBlack)jsSendNative;
@property (nonatomic, strong) JSContext *jsContext;

@end
@interface MJDevice : NSObject
typedef void (^MJDeviceBlockWH)(NSString *wh);
typedef void (^MJDeviceBlockType)(NSInteger deviceType);
+ (NSString *)getUUID;
+(BOOL)isPadDevice;
+(void)deviceType:(MJDeviceBlockType)deviceType wh:(MJDeviceBlockWH)wh;

@end
@interface MJColor : UIColor
/**
 *图片颜色
 */
+(UIImage*) createImageWithColor:(UIColor*)color withRect:(CGRect)rect;
/*
 *自定义图片大小:UISlider的大小等等
 */
+(UIImage*)OriginImage:(UIImage*)image scaleToSize:(CGSize)size;
#pragma mark-:地址----->图片
/*
 *地址转图片
 */
+(UIImage *)imageWithUrlStr:(NSString *)urlStr;
#pragma mark-:#D83B23--->UIColor
/**
 *color:色号:#D83B23
 */
+ (UIColor *) colorWithHexString: (NSString *)color;

@end
@interface MJLabel : UILabel
#pragma mark-: *Label缩进
/**
*indexHeadSpacingValue:头部缩进距离
*str:内容
*font:label的font大小
*alignment:NSTextAlignment
*/
+(NSAttributedString *)setIndexHeadSpacing:(CGFloat)indexHeadSpacingValue withText:(NSString*)str withFont:(CGFloat )font withAlignment:(NSTextAlignment)alignment;
/**
 *width:宽度
 *title:内容
 *fontSize:label的font
 */
+ (CGFloat)getHeightByWidth:(CGFloat)width title:(NSString *)title withFontSize:(CGFloat )fontSize;
;
/**
 *title:内容
 *fontSize:label的font
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title withFontSize:(CGFloat )fontSize;
/**
 *title:内容
 *fontSize:label的font
 */
+ (CGFloat)getHeightWithTitle:(NSString *)title withFontSize:(CGFloat )fontSize;
/**
 *lineSpacingValue:label行间距
 *fontSize:label的font
 *number:字间距
 *alignment:label朝向
 */
+(NSAttributedString *)setlineSpacing:(CGFloat)lineSpacingValue withText:(NSString*)str withFontSize:(CGFloat )fontSize withAlignment:(NSTextAlignment)alignment;
/**label行间距---height
 *str:内容
 *width:宽度
 *fontSize:label的font
 */
+(CGFloat)attributeStrHeightWithText:(NSString*)str withWidth:(CGFloat)width withFontSize:(CGFloat )fontSize;
/**label行间距---width
 *str:内容
 *height:高度
 *fontSize:label的font
 */
+(CGFloat)attributeStrWidthWithText:(NSString*)str withHeight:(CGFloat)height withFontSize:(CGFloat )fontSize;

/**自动布局后---高度
 *totalsArray:总数
 *maxNum:允许同行显示最大数
 *fontSize:label的font
 *marginTop:上下间距
 *marginLeft:左间距
 *marginRight:右间距
 *margin:间距
 */
+(float)totalsArray:(NSArray *)totalsArray withMaxNum:(NSInteger)maxNum withFontSize:(CGFloat )fontSize withMarginTop:(NSInteger)marginTop withMarginLeft:(NSInteger)marginLeft withMarginRight:(NSInteger)marginRight withMargin:(NSInteger)margin;
@end

typedef enum {
    imageTop = 0,   // 图片上 标题下
    imageLeft,      // 图片左 标题右
    imageBottom,    // 图片下 标题上
    colorCreatImageBottom,    // 图片下 标题上
    imageRight,     // 图片右 标题左
    imageRightSide,//图片在右边
    imageBottomNone,//无图片
    imageNone
} ImageStyle;

@interface MJButton : UIButton

@property (nonatomic, assign) ImageStyle buttonStyle;
/**
 *title:button的内容
 *fontSize:button的font
 *image:button上的图片
 */
+ (CGFloat)getWidthWithTitle:(NSString *)title withFontSize:(CGFloat )fontSize withImage:(UIImage *)image;
/**
 *title:button的内容
 *fontSize:button的font
 *image:button上的图片
 */
+ (CGFloat)getHeightWithTitle:(NSString *)title withFontSize:(CGFloat )fontSize withImage:(UIImage *)image;

@end
typedef void (^Title)(id title);
typedef void (^Message)(id message);
typedef void (^Message)(id message);
typedef void (^CancelAction)(BOOL cancelAction);
typedef void (^SureAction)(BOOL sureAction);
@interface MJAlertView : NSObject
/**
 *title:弹窗标题
 *message:弹窗小标题
 *cancelTitle:cancel标题
 *cancelAction:cancelAction回调
 *sureTitle:cancel标题
 *sureAction:sureAction回调
 *vc:当前UIViewController
 *count:action个数
 */
+(void)mjAlertTitle:(NSString *)title withMessage:(NSString *)message withCancelTitle:(NSString *)cancelTitle withCancelAction:(CancelAction)cancelAction withSureTitle:(NSString *)sureTitle withSureAction:(SureAction)sureAction withVC:(UIViewController *)vc withCount:(NSInteger)count sureIndex:(NSInteger)index;
@end
typedef void (^VersionBlock)(double version);
typedef void (^ReleaseNotesBlock)(id releaseNotes);
typedef void (^UpdateShowBlock)(BOOL latestVersion);
@interface MJCheckVersion : NSObject

/**
 *getAPPInfo:获取当前版本
 *getAPPStoreInfo:获取App Store版本
 *getAPPInfo<getAPPStoreInfo弹出更新视图
 *releaseNotes:App Store版本更新记录
 */
+(void)compareVersionForReleaseNotes:(ReleaseNotesBlock )releaseNotes withLatestVersion:(UpdateShowBlock)latestVersion;
/**
 *获取当前版本
 */
+(double)getAPPInfo;
/**
 *获取App Store版本
 */
+(double)getAPPStoreInfo;
/**
 *检测版本号
 */
//+(void)chectVersion;
/**
 *计时器检测版本号
 */
+(void)timerAction;
@end

typedef void (^SuccessBlock)(id obj);
typedef void (^FailureBlock)(NSError *error);
typedef void (^Completion)(BOOL finished);
//completion:<#^(BOOL finished)completion#>]  completion:(void (^ __nullable)(BOOL finished))completion

@interface MJHttpManager : NSObject

@property (nonatomic, copy) SuccessBlock successBlock;
@property (nonatomic, copy) FailureBlock failureBlock;
@property(nonatomic,strong) NSArray *tempURL;
/**
 *  post请求
 */
+ (void)PostWithUrlString:(NSString *)urlString
               parameters:(id)parameters
                  success:(SuccessBlock)successBlock
                  failure:(FailureBlock)failureBlock callBackJSON:(BOOL)callBackJSON withAFMediaType:(BOOL )afMediaType;
/**
 *  post表单上传附件
 *filePathType:.png,.caf
 *mimeType:@"image/png",audio/caf
 */
+ (void)PostAFMultipartWithUrlString:(NSString *)urlString
                          parameters:(id)parameters withFileData:(NSData *)fileData withFilePathType:(NSString *)filePathType mimeType:(NSString *)mimeType
                             success:(SuccessBlock)successBlock
                             failure:(FailureBlock)failureBlock callBackJSON:(BOOL)callBackJSON withAFMediaType:(BOOL )afMediaType;
/**
 *  get请求
 */
+ (void)GetWithUrlString:(NSString *)urlString
              parameters:(id)parameters
                 success:(SuccessBlock)successBlock
                 failure:(FailureBlock)failureBlock callBackJSON:(BOOL)callBackJSON withAFMediaType:(BOOL )afMediaType;
/**
 *  异步网络(parameters相同)
 */
+ (void)PostAsyncWithUrlString:(NSString *)urlString withArray:(NSArray *)array
                    parameters:(id)parameters success:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock callBackJSON:(BOOL)callBackJSON completion:(Completion)completion;
@end

@interface MJMutableAttributedString : NSObject
#pragma mark-:移除空格,横线
+ (NSString *)removeSpaceAndEnter:(NSString *)str;
/**
 *defaultString:内容
 *urlStr:链接
 */
+(NSMutableAttributedString *)openUrlString:(NSString *)urlStr withDefaultString:(NSString *)defaultString;
/**
 *label删除线
 */
+(NSMutableAttributedString *)underlineStyleSingleDefaultString:(NSString *)defaultString;
/**
 *字体颜色变换
 */
+(NSMutableAttributedString *)defaultString:(NSString *)defaultString changeColor:(UIColor *)color forCharStr:(NSString *)charStr;
/**
 *字体大小变换
 */
+(NSMutableAttributedString *)defaultString:(NSString *)defaultString changeFontNumber:(CGFloat )fontNumber forCharStr:(NSString *)charStr;
@end

typedef void (^Completion)(BOOL finished);
typedef void (^MJRefreshHFComponentBlock)(void);
@interface MJRefreshHF : NSObject
@property (nonatomic, copy) Completion finished;
/**
 *初始化
 */
+ (instancetype)mjManager;
/**
 *加载MJRefreshNormalHeader
 *scrollView:tableView,collectionView
 *completion:下拉加载
 */
+(void)mjRefreshHeaderInScrollView:(UIScrollView *)scrollView beginRefreshing:(BOOL)beginRefreshing completion:(MJRefreshHFComponentBlock)completion;
/**
 *加载MJRefreshAutoNormalFooter
 *scrollView:tableView,collectionView
 *completion:下拉加载
 */
+(void)mjRefreshFooterInScrollView:(UIScrollView *)scrollView completion:(MJRefreshHFComponentBlock)completion;
/**
 *mj_footer设置高度
 */
+(void)mjRefreshSetupFooterFrameInScrollView:(UIScrollView *)scrollView;
/**
 *上拉,下拉加载结束
 */
+(void)mjHFEndRefreshingByScrollView:(UIScrollView *)scrollView withCount:(NSInteger)count;
/**
 *mj_footer隐藏
 */
+(void)mjRefreshFooterHiddenInScrollView:(UIScrollView *)scrollView;
/**
 *mj_footer状态:没有更多数据了
 */
+(void)mjFooterStateNoMoreDataByScrollView:(UIScrollView *)scrollView;
/**
 *没有数据,清除MJRefreshNormalHeader,MJRefreshAutoNormalFooter
 */
+(void)clearHFByScrollView:(UIScrollView *)scrollView;
/**
 *没有数据,显示占位符图片
 */
+ (void)emptyDataSet:(UIScrollView *)scrollView y:(CGFloat )y;
/**
 *删除,显示占位符图片
 */
+ (void)clearEmptyDataSet:(UIScrollView *)scrollView;
/**
 *没有数据,显示占位符语句
 */
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView;

@end
typedef void (^SuccessImageBlock)(id obj,UIImage *image);
typedef void (^SuccessVedioBlock)(id obj);
typedef void (^FailureImageBlock)(NSError *error);
typedef void (^FailureVedioBlock)(NSError *error);
@interface MJUpdateImageVideo : NSObject
/**
 *successImageBlock:(id obj,UIImage *image)
 *id obj:图片data
 */
@property (nonatomic, copy) SuccessImageBlock successImageBlock;
/**
 *successImageBlock:(id obj,UIImage *image)
 *id obj:视频data
 */
@property (nonatomic, copy) SuccessVedioBlock successVedioBlock;

@property (nonatomic, copy) FailureImageBlock failureImageBlock;
@property (nonatomic, copy) FailureVedioBlock failureVedioBlock;
/**
 *初始化
 */
+ (instancetype)updateManager;
/**
 *vc:当前控制器self
 */
//-(void)updateImageVideoView:(UIView *)customeView withVC:(UIViewController *)vc allowPickingMultipleVideo:(BOOL )allowPickingMultipleVideo;
/**
 *successImageBlock:(id obj,UIImage *image)
 *id obj:图片data
 */
- (void)pushTZImagePickerControllerWithVC:(UIViewController *)vc allowPickingMultipleVideo:(BOOL )allowPickingMultipleVideo successImageBlock:(SuccessImageBlock)successImageBlock;
/**
 *successImageBlock:(id obj,UIImage *image)
 *id obj:图片data
 */
//-(void)updateImageSuccessImage:(SuccessImageBlock)successImageBlock;
/**
 *successImageBlock:(id obj,UIImage *image)
 *id obj:视频data
 */
//-(void)updateVideoSuccessVedio:(SuccessVedioBlock)successVedioBlock;
@end
@interface MJNumberSwitchString : NSObject
+(NSString *)mjNumberSwitchString:(NSInteger )number;
+(NSString *)mjObjSwitchString:(NSObject *)obj;
+ (BOOL)isNumber:(NSString *)strValue;
+(NSInteger)mjStringSwitchNumber:(NSString *)numberString;
+(NSMutableArray *)mjStringSwitchArray:(NSString *)numberString;
+(NSMutableString *)mjArraySwitchString:(NSMutableArray *)stringArray withCharStr:(NSString *)charStr;
@end


@interface MJPhoneAndMailCheckObject : NSObject
+(BOOL)phoneNumberIsTrue:(NSString *)phoneNumber;
+(BOOL)checkEmail:(NSString *)email;
@end

/**
 *  弹出日期类型
 */
typedef enum{
    /**
     *年月日时分
     */
    YMDMinS  = 0,
    /**
     *年月日时分
     */
    YMD,
    /**
     *年月
     */
    YM,
    MD,//月日
    HM,//时分
    Y,//年
    M,//月
    DMinS,//日时分
}YMDMS;
@interface TimeHelper : NSObject
/**
 *当前月多少天
 */
+(NSUInteger)numberOfDaysInMonthWithDate:(NSDate *)date;
/**
 *当前0点0分
 */
+(NSString *)currentZeroTime;
/**
 *某一天0点0分
 */
+(NSString *)WhichDayZeroTime:(NSInteger )yearTime withMonthTime:(NSInteger )monthTime withDayTime:(NSInteger )dayTime;
/**
 *本周日0点0分
 */
+(NSString *)currentWeekZeroTime;
/**
 *当月第一天
 */
+(NSString *)currentMonthFirstDayTime;
/**
 *2个日期对比先后
 *1:在指定时间前面
 *-1:没过指定时间
 0:当前
 */
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
/**
 *当前时间戳
 */
+(NSInteger)getNowTimestamp;
/**
 *时间戳(毫秒转时间格式)
 */
+(NSString *)backGroundWith:(NSInteger)timestamp withYMDMS:(YMDMS)yMinDMSStyle;
/*当前时间毫秒*/
+(NSTimeInterval )whichTime:(NSString *)time;
/**
 *当前时间
 */
+ (NSString *)getCurrentYMDMS:(YMDMS)yMinDMSStyle;
/**
 *当前先星期几
 */
+ (NSString *)getCurrentWeekDay;
/**
 *当前几号
 */
+ (NSInteger )getCurrentDayDate;
/**
 *NSDate转化---YMDMS
 */
+ (NSString *)getWhichYMDDate:(YMDMS)yMinDMSStyle withDate:(NSDate *)date;
/**
 *NSDate转几号
 */
+ (NSInteger )getSelectWhichNumberForSelectDate:(NSDate *)selectDate;
/**
 *NSDate转星期几
 */
+ (NSString *)getSelectWhichweekDayForSelectWhichData:(NSDate *)selectDate;
/**
 *字符串转时间
 */
+(NSDate *)nsstringConversionNSDate:(NSString *)dateStr;
@end
typedef void (^Completion)(BOOL finished);
@interface UserDefaultsHelper : NSObject
@property(nonatomic,assign) BOOL autoLogIn;
+(NSUserDefaults *)userDefaultManager;
+(void)saveAutoLogIn:(id)autoLogIn value:(NSString *)autoLogInYESORNO;
+(NSString *)readAutoLogIn;
+(void)saveQQHeadImg:(id)headImg withHeadImgValue:(NSString *)headImgValue saveNickname:(id)nickname withNicknameValue:(NSString *)nicknameValue;
+(void)saveQQNONickNameHeadImg:(id)headImg withHeadImgValue:(NSString *)headImg;
+(void)saveQQNOHeadImgNickname:(id)nickname withNicknameValue:(NSString *)nicknameValue;

+(void)savePhoneHeadImg:(id)headImg withHeadImgValue:(NSString *)headImgValue saveUid:(id)uid withUidValue:(NSString *)uidValue saveNickname:(id)nickname withNicknameValue:(NSString *)nicknameValue savePhone:(id)phone withPhone:(NSString *)phoneValue saveType:(id)type andType:(NSString *)typeValue saveToken:(id)token withTokenValue:(NSString *)tokenValue saveIsAgreement:(id)isAgreement withIsAgreementValue:(NSString *)isAgreementValue;

+(void)savePhoneNOHeadImgUid:(id)uid withUidValue:(NSString *)uidValue saveNickname:(id)nickname withNicknameValue:(NSString *)nicknameValue savePhone:(id)phone withPhone:(NSString *)phoneValue saveType:(id)type andType:(NSString *)typeValue saveToken:(id)token withTokenValue:(NSString *)tokenValue saveIsAgreement:(id)isAgreement withIsAgreementValue:(NSString *)isAgreementValue;
+(void)savePhoneNONickNameHeadImg:(id)headImg withHeadImgValue:(NSString *)headImgValue saveUid:(id)uid withUidValue:(NSString *)uidValue savePhone:(id)phone withPhone:(NSString *)phoneValue saveType:(id)type andType:(NSString *)typeValue saveToken:(id)token withTokenValue:(NSString *)tokenValue saveIsAgreement:(id)isAgreement withIsAgreementValue:(NSString *)isAgreementValue;


+(void)saveWechatHeadImg:(id)headImg withHeadImgValue:(NSString *)headImgValue saveNickname:(id)nickname withNicknameValue:(NSString *)nicknameValue;
+(void)saveWechatNONickNameHeadImg:(id)headImg withHeadImgValue:(NSString *)headImgValue;
+(void)saveWechatNOHeadImgNickname:(id)nickname withNicknameValue:(NSString *)nicknameValue;

+(void)saveHeadimg:(id)headimg value:(NSString *)headimgValue;
+(void)saveNickName:(id)nickName value:(NSString *)nickNameValue;
+(void)saveIphone:(id)iphone value:(NSString *)iphoneValue;
+(NSString *)readHeadimg;
+(NSString *)readUserId;
+(void)saveUserId:(id)userId value:(NSString *)userIdValue;
+(NSString *)readNickName;
+(NSString *)readToken;
+(void)saveToken:(id)token value:(NSString *)tokenValue;
+(NSString *)readIphone;
+(NSString *)readIsAgreement;
+(void)saveIsAgreement:(id)isAgreement value:(NSString *)isAgreementValue;
+(NSString *)readType;
+(void)saveType:(id)token value:(NSString *)typeValue;
+(NSString *)readSex;
+(void)saveSex:(id)sex value:(NSString *)sexValue;
+(NSString *)readQQOpenID;
+(NSString *)readWechatOpenID;
+(NSString *)readSign;
+(void)savesSign:(id)sign value:(NSString *)signValue;
+(NSString *)readUserAccount;
+(void)savesUserAccount:(id)userAccount value:(NSString *)userAccountValue;
+(void)clearUserDafault;
/**
 *present:一个vc,一般指登陆vc
 */
+(void)presentVC:(UIViewController *)vc;
/**
 *check账户登陆,没有进行登陆
 *present:一个vc,一般指登陆vc
 */
+(void)checkLogIn:(UIViewController *)vc completion:(Completion)completion;
@end

NS_ASSUME_NONNULL_END
