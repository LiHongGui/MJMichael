MJMichael
更新记录:
v4.2.7:
1:添加MJWKWebView
//WKWebView加载本地H5
+(MJWKWebView *)shareManagerFrame:(CGRect)frame ByVC:(UIViewController *)vc loadHTML:(NSString *)html
v4.2.6:
1:添加MJDevice
获取UUID
+ (NSString *)getUUID;

//pad和iPhone设备判断
+(BOOL)isPadDevice;

//根据屏幕宽高判断机型
+(void)deviceType:(MJDeviceBlockType)deviceType wh:(MJDeviceBlockWH)wh;
