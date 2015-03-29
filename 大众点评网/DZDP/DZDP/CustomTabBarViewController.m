//
//  CustomTabBarViewController.m
//  DZDP
//
//  Created by yangheng on 15/3/16.
//  Copyright (c) 2015年 yangheng. All rights reserved.
//

#import "CustomTabBarViewController.h"
#import "FirstPageViewController.h"
#import "BuyViewController.h"
#import "FindingViewController.h"
#import "MyInfoViewController.h"


@interface CustomTabBarViewController ()

@end

@implementation CustomTabBarViewController

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
    
//    [self creatViewControllers];
    
}

+(CustomTabBarViewController *)createTabBarController {
    CustomTabBarViewController *tabCon = [[CustomTabBarViewController alloc]init];
    //隐藏父类的标签栏
    tabCon.tabBar.hidden = YES;
    
    //创建自己的标签栏
    CGRect screenR = [UIScreen mainScreen].bounds;
    
    UIView *myTabBar = [[UIView alloc]initWithFrame:CGRectMake(0, screenR.size.height-49, screenR.size.width, 49)];
    
    myTabBar.backgroundColor = [UIColor grayColor];
    
    [tabCon.view addSubview:myTabBar];
    
    //设置标题与图像
    
    NSArray *titles = @[@"首页",@"团购",@"发现",@"我的"];
    NSArray *images = @[@"shouye",@"tuangou",@"faxian",@"wode"];
    
    for (int i = 0; i<4; i++) {
        //创建按钮
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        CGFloat butW = screenR.size.width/4;
        CGFloat butH = 49;
        
        CGFloat butX = butW*i;
        CGFloat butY = 0;
        
        button.frame = CGRectMake(butX, butY, butW, butH);
        
        [button addTarget:tabCon action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = i+1;
        
        [myTabBar addSubview:button];
        
        //添加图片
        UIImage *image = [UIImage imageNamed:images[i]];
        
//        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        [button setImage:image forState:UIControlStateNormal];
        [button setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        
        //标题
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 49, butW, 19)];
        title.text = titles[i];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont systemFontOfSize:12];
        [button addSubview:title];
        
    }
    
    //添加元素
    FirstPageViewController *news = [[FirstPageViewController alloc]init];
    news.title = @"新闻";
    UINavigationController *navNews = [[UINavigationController alloc]initWithRootViewController:news];
    
    BuyViewController *forum = [[BuyViewController alloc]init];
    forum.title = @"论坛";
    UINavigationController *navForum = [[UINavigationController alloc]initWithRootViewController:forum];
    
    FindingViewController *activity = [[FindingViewController alloc]init];
    activity.title = @"活动";
    UINavigationController *navActivity = [[UINavigationController alloc]initWithRootViewController:activity];
    
    MyInfoViewController *agent = [[MyInfoViewController alloc]init];
    agent.title = @"助理";
    UINavigationController *navAgent = [[UINavigationController alloc]initWithRootViewController:agent];
    
    tabCon.viewControllers = @[navNews,navForum, navActivity, navAgent];
    
    return tabCon;

}

-(void)buttonClicked:(UIButton *)button{
    NSLog(@"buttonClicked");
    //选择相应的元素
    self.selectedIndex = button.tag -1;

    //将值存起来
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    [user setInteger:self.selectedIndex forKey:@"selectedIndex"];
    //同步（立即执行）
    [user synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
