# ShowLog
将log打印显示在自定义的view中
```
       一般人用嘴说话，聪明人用脑说话，智者用心说话
```
在做聊天功能的时候，当做完丢给测试员测试时，有好几次测试员直接把手机放到我面前说：“大哥，你看这个bug是怎么回事？”。当时我一看，“我靠，你这个问题是怎么弄出来的，不应该阿”。然后他说：“我特意走到27楼测试，那里信号比较差，甚至会断网，所以问题就出来了”。我心想：“测试还真是尽心尽力的，哎 改吧”。可想要改的时候，却很难下手，因为很难调试，要是我可以看看测试机的打印日志的话，那就好办多了。
所以这篇博客就诞生了！先看看效果
![Untitled2.gif](http://upload-images.jianshu.io/upload_images/3950574-17bb4cedcc807ed6.gif?imageMogr2/auto-orient/strip)
```
用法很简单，只需要创建添加到视图中就行了
JLogView *logView = [[JLogView alloc] initWithFrame:CGRectMake(20, 100, 300, 500)];
    [[UIApplication sharedApplication].keyWindow addSubview:logView];
```
```
关键代码
+(void)saveLog {
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *document = [path objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"dr.log"];
    NSString *logPath = [document stringByAppendingPathComponent:fileName];
    
    NSFileManager *defaulManager = [NSFileManager defaultManager];
    [defaulManager removeItemAtPath:logPath error:nil];
    
    // 重定向输入输出流
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logPath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}
```
demo地址：https://github.com/iOSHJH/ShowLog.git
另外非常感谢yyMae的分享
有问题欢迎issues，若项目对你有用还望不吝给个star让我动力十足😀
