//
//  MainViewController.m
//  DYMD
//
//  Created by 蒋华阳 on 14-10-1.
//  Copyright (c) 2014年 蒋华阳. All rights reserved.
//

#import "MainViewController.h"
#import "RightView.h"
#import "Message.h"
#import "RightView.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize dic;
@synthesize innerSubType = _innerSubType;
@synthesize playBtn;
@synthesize stopBtn;
@synthesize compu1;
@synthesize compu2;
@synthesize compu3;
@synthesize compu4;
@synthesize pro1;
@synthesize pro2;
@synthesize pro3;
@synthesize pro4;
@synthesize pro5;
@synthesize pro6;
@synthesize pro7;
@synthesize pro8;
@synthesize powerBtn;
@synthesize powerOnBtn;
@synthesize powerOffBtn;
@synthesize type;
//@synthesize sliderA = _sliderA;


@synthesize addressDic;
@synthesize message;
@synthesize TCpaddress;
-(IBAction)changeZhanTing:(UIButton*)sender{
    self.type = (int)sender.tag;
    [self ZhanTingInfo];
    
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
    
}

- (void) videoPressed:(UIButton *)sender
{
    
}

-(void) projectPressed:(UIButton *)sender
{
    
}

-(void) sendMessage:(int)type
{
    
}

-(void) showLeftView:(UIButton *)sender
{
    
}

- (void)ZhanTingInfo{
    
    [self.playBtn setHidden:YES];
    [self.stopBtn setHidden:YES];
    [self.powerOnBtn setHidden:YES];
    [self.powerOffBtn setHidden:YES];
    [self.volPBtn setHidden:YES];
    [self.volMBtn setHidden:YES];
    //[self.sliderA setHidden:YES];
    self.rightView =  (RightView*)[self.view viewWithTag:100];
    [self.rightView setInfos:[self.dic objectForKey:[NSString stringWithFormat:@"展厅%d",self.type]]];
    
    
    
    NSLog(@"展厅ID=%@",[NSString stringWithFormat:@"%d",self.type]);
    
    NSDictionary *exhibitionHallDic = [self.dic objectForKey:[NSString stringWithFormat:@"展厅%d",self.type]];
    NSLog(@"展项ID=%d",self.innerSubType-1);
    NSDictionary *exhibitionItemDic =[exhibitionHallDic objectForKey:[NSString stringWithFormat:@"展项%d",self.innerSubType]];
    NSDictionary *computersDic = [exhibitionItemDic objectForKey:@"computers"];
    NSDictionary *projectorsDic = [exhibitionItemDic objectForKey:@"projectors"];
    int computerCount = (int)[[computersDic objectForKey:@"count"] integerValue];
    int projectorCount = (int)[[projectorsDic objectForKey:@"count"] integerValue];
    
    if(computerCount > 4) {
        computerCount = 4;
    }
    if(projectorCount > 8) {
        projectorCount = 8;
    }
    
    for (int i=1; i<=computerCount; i++) {
        NSDictionary *computer = [computersDic objectForKey:[NSString stringWithFormat:@"computer%i",i]];
        UIButton *btn = (UIButton*)[self.view viewWithTag:i+20];
        [btn setTitle:[computer objectForKey:@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"电脑投影-02.png"]] forState:UIControlStateNormal];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 5, 0);
        [btn setHidden:NO];
    }
    for(int i=computerCount+1;i<=4;i++) {
        UIButton *btn = (UIButton*)[self.view viewWithTag:i+20];
        [btn setHidden:YES];
    }
    for (int i=1; i<=projectorCount; i++) {
        NSDictionary *projector = [projectorsDic objectForKey:[NSString stringWithFormat:@"projector%i",i]];
        UIButton *btn = (UIButton*)[self.view viewWithTag:i+30];
        [btn setTitle:[projector objectForKey:@"name"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"电脑投影-03.png"]] forState:UIControlStateNormal];
        btn.contentEdgeInsets = UIEdgeInsetsMake(0,0, 5, 0);
        [btn setHidden:NO];
    }
    for(int i=projectorCount+1;i<=8;i++) {
        UIButton *btn = (UIButton*)[self.view viewWithTag:i+30];
        [btn setHidden:YES];
    }
    
    [self initMessage];
}


- (void) initMessage
{
    
}

- (void)setInnerSubType:(int)innerSubType{
    _innerSubType = innerSubType;
    [self ZhanTingInfo];
}

///进度条改变
- (void)sliderValueChanged:(UISlider*)sender{
    
    float value = 1- sender.value;
    NSString *command = [NSString stringWithFormat:@"/%@/video/vol",self.TCpaddress];
    NSLog(@"%@ |%f",command,value);
    [self.message sendMessage:command Float:value];}

//进度条拖动
- (void)sliderDragUp:(UISlider*)sender{
}

//- (void)MySlider{
//    
//    UISlider *sliderA=[[UISlider alloc]initWithFrame:CGRectMake(620, 630, 150, 50)];
//    
//    [sliderA setMinimumTrackImage:[UIImage imageNamed:@"声音条.png"] forState:UIControlStateNormal];
//    [sliderA setMaximumTrackImage:[UIImage imageNamed:@"声音条2.png"] forState:UIControlStateNormal];
//    
//    [sliderA setThumbImage:[UIImage imageNamed:@"声音条annn.png"] forState:UIControlStateHighlighted];
//    [sliderA setThumbImage:[UIImage imageNamed:@"声音条annn.png"] forState:UIControlStateNormal];
//    
//    
//    sliderA.transform = CGAffineTransformMakeRotation(1.57079633);
//    
//    sliderA.value=1.0;
//    sliderA.minimumValue=0.0;
//    sliderA.maximumValue=1.0;
//    
//    sliderA.backgroundColor = [UIColor clearColor];
//    //滑块拖动时的事件
//    [sliderA addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
//    //滑动拖动后的事件
//    [sliderA addTarget:self action:@selector(sliderDragUp:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:sliderA];
//    //self.sliderA = sliderA;
//}


- (void)setRightView{
    RightView *rightView = [[[NSBundle mainBundle] loadNibNamed:@"RightView" owner:self options:nil] objectAtIndex:0];
    CGRect rect = rightView.frame;
    rect.origin.x = 819;
    rect.origin.y = 173;
    [rightView setFrame:rect];
    [rightView setTag:100];
    
    [rightView setInfos:[self.dic objectForKey:[NSString stringWithFormat:@"展厅%d",self.type]]];
    rightView.controller = self;
    [self.view addSubview:rightView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self MySlider];
    volume1 = 0;
    volume2 = 0;
    
    
    self.dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"conf.plist" ofType:nil]];
    

    [self setRightView];
    
    
    type = (int)[[self.dic objectForKey:@"currentSelect"] integerValue];
    _innerSubType = 1;
    allSwitch = 0;
    [self ZhanTingInfo];
    
    [self.rightView beginInit];
    
    NSDictionary *centerControllerConfigDic = [dic objectForKey:@"centerController"];
    NSString *ip = [centerControllerConfigDic objectForKey:@"ip"];
    int port = (int)[[centerControllerConfigDic objectForKey:@"port"] integerValue];
    
    self.message = [[Message alloc] initWithAddress:ip port:port];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)touchDownSingal:(UIButton *)sender {

    UIButton *btn =(UIButton*)[self.view viewWithTag:[sender tag]];
   // NSLog(@"touchdown %li",[sender tag]);
    NSString *command;
    float volume;
    switch ([sender tag]) {
        case 50:
            [btn setBackgroundImage:[UIImage imageNamed:@"小on变.png"] forState:UIControlStateNormal];
            command = [NSString stringWithFormat:@"/%@/power",self.TCpaddress];
            command = [command stringByAppendingString:@"on"];
            [self.message sendMessage:command Float:1.0000];
            break;
        case 51:
            [btn setBackgroundImage:[UIImage imageNamed:@"小off变.png"] forState:UIControlStateNormal];
            command = [NSString stringWithFormat:@"/%@/power",self.TCpaddress];
            command = [command stringByAppendingString:@"off"];
            [self.message sendMessage:command Float:1.0000];
            break;
        case 52:
            [btn setBackgroundImage:[UIImage imageNamed:@"△变.png"] forState:UIControlStateNormal];
            command = [NSString stringWithFormat:@"/%@/video",self.TCpaddress];
            command = [command stringByAppendingString:@"/play"];
            [self.message sendMessage:command Float:1.0000];
            break;
        case 53:
            [btn setBackgroundImage:[UIImage imageNamed:@"停止变.png"] forState:UIControlStateNormal];
            command = [NSString stringWithFormat:@"/%@/video",self.TCpaddress];
            command = [command stringByAppendingString:@"/stop"];
            [self.message sendMessage:command Float:1.0000];
            break;
        case 54:
            [btn setBackgroundImage:[UIImage imageNamed:@"声音加变.png"] forState:UIControlStateNormal];
            if([self.TCpaddress  isEqual: @"192.168.0.51"]) {
                NSLog(@"volume+51");
                if(volume1 <1.00) {
                    volume1+=0.05;
                }
                volume = volume1;
            } else if([self.TCpaddress isEqualToString:@"192.168.0.52"]) {
                NSLog(@"vol+52");
                if(volume2 <1.00) {
                    volume2+=0.05;
                }
                volume = volume2;
            }
            command = [NSString stringWithFormat:@"/%@/video/vol",self.TCpaddress];
            NSLog(@"%@ |%f",command,volume);
            [self.message sendMessage:command Float:volume];
            break;
        case 55:
            [btn setBackgroundImage:[UIImage imageNamed:@"声音减变.png"] forState:UIControlStateNormal];
            if([self.TCpaddress  isEqual: @"192.168.0.51"]) {
                NSLog(@"volume-51");
                if(volume1 >0.01) {
                    volume1-=0.05;
                }
                volume = volume1;
            } else if([self.TCpaddress isEqualToString:@"192.168.0.52"]) {
                NSLog(@"volume-52");
                if(volume2 >0.01) {
                    volume2-=0.05;
                }
                volume = volume2;
            }
            command = [NSString stringWithFormat:@"/%@/video/vol",self.TCpaddress];
            NSLog(@"%@ |%f",command,volume);
            [self.message sendMessage:command Float:volume];
            break;
        default:
            break;
    }
    NSLog(@"%@",command);
}

-(IBAction)touchUpInSideSingal:(UIButton*)sender{
    
    UIButton *btn =(UIButton*)[self.view viewWithTag:[sender tag]];
    //NSLog(@"touchupinside %li",[sender tag]);
    switch ([sender tag]) {
        case 50:
            [btn setBackgroundImage:[UIImage imageNamed:@"小on.png"] forState:UIControlStateNormal];
            break;
        case 51:
            [btn setBackgroundImage:[UIImage imageNamed:@"小off.png"] forState:UIControlStateNormal];
            break;
        case 52:
            [btn setBackgroundImage:[UIImage imageNamed:@"△.png"] forState:UIControlStateNormal];
            break;
        case 53:
            [btn setBackgroundImage:[UIImage imageNamed:@"停止.png"] forState:UIControlStateNormal];
            break;
        case 54:
            [btn setBackgroundImage:[UIImage imageNamed:@"声音加.png"] forState:UIControlStateNormal];
            break;
        case 55:
            [btn setBackgroundImage:[UIImage imageNamed:@"声音减.png"] forState:UIControlStateNormal];
            break;
        default:
            break;
    }
}



-(BOOL)isHideVolumeBtn{
    /*
     NSDictionary *dic = [self.dic objectForKey:[NSString stringWithFormat:@"展厅%d",self.type]];
     NSLog(@"%d",self.subType-1);
     NSDictionary *infoDic =[dic objectForKey:[NSString stringWithFormat:@"展项%d",self.subType]];
     NSLog(@"%@",infoDic);
     NSArray *compArr = [infoDic objectForKey:@"comp"];
     return [[compArr objectAtIndex:comType-21] componentsSeparatedByString:@";"].count;*/
    return true;
}
-(NSString*)getAddress{
    
    NSDictionary *exhibitionHallDic = [self.dic objectForKey:[NSString stringWithFormat:@"展厅%d",self.type]];
    NSDictionary *exhibitionItemDic =[exhibitionHallDic objectForKey:[NSString stringWithFormat:@"展项%d",self.innerSubType]];
    NSDictionary *computersDic = [exhibitionItemDic objectForKey:@"computers"];
    NSDictionary *projectorsDic = [exhibitionItemDic objectForKey:@"projectors"];
    
    if(comType > 0) {
        NSDictionary *computer = [computersDic objectForKey:[NSString stringWithFormat:@"computer%i",comType-20]];
        NSLog(@"%@",[computer objectForKey:@"ip"]);
        return [computer objectForKey:@"ip"];
    } else if(proType > 0) {
        NSDictionary *projector = [projectorsDic objectForKey:[NSString stringWithFormat:@"projector%i",proType-30]];
        NSLog(@"%@",[projector objectForKey:@"ip"]);
        return [projector objectForKey:@"ip"];
    } else{
        return nil;
    }
    
}
-(IBAction)showRightView:(UIButton*)sender{
    self.rightView.hidden = ! self.rightView.hidden;
}


-(void)changeComIcon{
    NSDictionary *exhibitionHallDic = [self.dic objectForKey:[NSString stringWithFormat:@"展厅%d",self.type]];
    NSDictionary *exhibitionItemDic =[exhibitionHallDic objectForKey:[NSString stringWithFormat:@"展项%d",self.innerSubType]];
    NSDictionary *computersDic = [exhibitionItemDic objectForKey:@"computers"];
    NSDictionary *projectorsDic = [exhibitionItemDic objectForKey:@"projectors"];
    
    int computerCount = (int)[[computersDic objectForKey:@"count"] integerValue];
    int projectorCount = (int)[[projectorsDic objectForKey:@"count"] integerValue];
    
    if(comType > 0) {
        NSDictionary *computer = [computersDic objectForKey:[NSString stringWithFormat:@"computer%i",comType-20]];
        NSLog(@"%@",[computer objectForKey:@"ip"]);
        BOOL canPoweOn = (BOOL)[[computer objectForKey:@"canpoweron"] boolValue];
        BOOL canPoweOff = (BOOL)[[computer objectForKey:@"canpoweroff"] boolValue];
        BOOL canPlay = (BOOL)[[computer objectForKey:@"canplay"] boolValue];
        BOOL canStop = (BOOL)[[computer objectForKey:@"canstop"] boolValue];
        BOOL canControlVol = (BOOL)[[computer objectForKey:@"cancontrolvol"] boolValue];
        
        for (int i=1; i<=computerCount; i++) {
            
            UIButton *btn =(UIButton*)[self.view viewWithTag:i+20];
            if(i+20==comType){
                [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"电脑投影变-06.png"]] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                if(canPoweOn) {
                    [self.powerOnBtn setHidden:NO];
                } else {
                    [self.powerOnBtn setHidden:YES];
                }
                if(canPoweOff) {
                    [self.powerOffBtn setHidden:NO];
                } else {
                    [self.powerOffBtn setHidden:YES];
                }
                if(canPlay) {
                    [self.playBtn setHidden:NO];
                } else {
                    [self.playBtn setHidden:YES];
                }
                if(canStop) {
                    [self.stopBtn setHidden:NO];
                } else {
                    [self.stopBtn setHidden:YES];
                }
                if(canControlVol) {
                    [self.volPBtn setHidden:NO];
                    [self.volMBtn setHidden:NO];
                    //[self.sliderA setHidden:NO];
                } else {
                    [self.volPBtn setHidden:YES];
                    [self.volMBtn setHidden:YES];
                    //[self.sliderA setHidden:YES];
                }
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"电脑投影-02.png"]] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
    
    for (int i=1; i<=projectorCount; i++) {
        UIButton *btn =(UIButton*)[self.view viewWithTag:i+30];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"电脑投影-03.png"]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    self.TCpaddress = [self getAddress];//@"192.168.199.193";//
    
}
-(void)changeProIcon{
    NSDictionary *exhibitionHallDic = [self.dic objectForKey:[NSString stringWithFormat:@"展厅%d",self.type]];
    NSDictionary *exhibitionItemDic =[exhibitionHallDic objectForKey:[NSString stringWithFormat:@"展项%d",self.innerSubType]];
    NSDictionary *computersDic = [exhibitionItemDic objectForKey:@"computers"];
    NSDictionary *projectorsDic = [exhibitionItemDic objectForKey:@"projectors"];
    int computerCount = (int)[[computersDic objectForKey:@"count"] integerValue];
    int projectorCount = (int)[[projectorsDic objectForKey:@"count"] integerValue];
    
    if(proType > 0) {
        
        NSDictionary *projector = [projectorsDic objectForKey:[NSString stringWithFormat:@"projector%i",proType-30]];
        NSLog(@"%@",[projectorsDic objectForKey:@"ip"]);
        
        BOOL canPoweOn = (BOOL)[[projector objectForKey:@"canpoweron"] boolValue];
        BOOL canPoweOff = (BOOL)[[projector objectForKey:@"canpoweroff"] boolValue];
        
        for (int i=1; i<=projectorCount; i++) {
            
            UIButton *btn =(UIButton*)[self.view viewWithTag:i+30];
            if(i+30==proType){
                [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"电脑投影变-07.png"]] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                if(canPoweOn) {
                    [self.powerOnBtn setHidden:NO];
                } else {
                    [self.powerOnBtn setHidden:YES];
                }
                if(canPoweOff) {
                    [self.powerOffBtn setHidden:NO];
                } else {
                    [self.powerOffBtn setHidden:YES];
                }
            }else{
                [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"电脑投影-03.png"]] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
        }
    }
    
    
    for (int i=1; i<=computerCount; i++) {
        UIButton *btn =(UIButton*)[self.view viewWithTag:i+20];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"电脑投影-02.png"]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    [self.playBtn setHidden:YES];
    [self.stopBtn setHidden:YES];
    [self.volMBtn setHidden:YES];
    [self.volPBtn setHidden:YES];
    //[self.sliderA setHidden:YES];
    self.TCpaddress = [self getAddress];
    
}

-(void)changeSize:(int)j
{
    //    UIButton * btn=(UIButton*)[self.view viewWithTag:j];
    //    CGSize size=btn.frame.size;
    //    size.width*=1.1;
    //    size.height*=1.1;
    //    [btn setFrame:CGRectMake(btn.center.x-size.width/2, btn.center.y-size.height/2, size.width, size.height)];
}

-(IBAction)compu:(UIButton*)sender{
    
    comType = (int)sender.tag;
    proType = 0;
    [self.powerOnBtn setHidden:FALSE];
    [self.powerOffBtn setHidden:FALSE];
    [self.playBtn setHidden:FALSE];
    [self.stopBtn setHidden:FALSE];
    
    //    [self changeSize:comType];
    
    [self changeComIcon];
}
-(IBAction)pro:(UIButton*)sender{
    proType = (int)sender.tag;
    comType = 0;
    [self.powerOnBtn setHidden:FALSE];
    [self.powerOffBtn setHidden:FALSE];
    
    
    [self changeProIcon];
}

-(IBAction)touchDownPower:(UIButton *)sender {
    
    UIButton *btn =(UIButton*)[self.view viewWithTag:[sender tag]];
    NSLog(@"touchdown %li",[sender tag]);
    NSString * command=[NSString stringWithFormat:@"/all/power"];
    switch ([sender tag]) {
        case 40:
            [btn setBackgroundImage:[UIImage imageNamed:@"ON变.png" ] forState:UIControlStateNormal];
            command = [command stringByAppendingString:@"on"];
            [self.message sendMessage:command Float:1.0000];
            break;
        case 41:
            [btn setBackgroundImage:[UIImage imageNamed:@"OFF变.png" ] forState:UIControlStateNormal];
            command = [command stringByAppendingString:@"off"];
            [self.message sendMessage:command Float:1.0000];
        default:
            break;
    }
    NSLog(@"%@",command);
}

-(IBAction)touchUpInSidePower:(UIButton*)sender{
    
    UIButton *btn =(UIButton*)[self.view viewWithTag:[sender tag]];
    
    
    switch ([sender tag]) {
        case 40:
            [btn setBackgroundImage:[UIImage imageNamed:@"ON.png" ] forState:UIControlStateNormal];
            break;
        case 41:
            [btn setBackgroundImage:[UIImage imageNamed:@"OFF.png" ] forState:UIControlStateNormal];
        default:
            break;
    }
}
- (void)dealloc {
    [compu1 release];
    [compu2 release];
    [compu3 release];
    [compu4 release];
    [pro1 release];
    [pro2 release];
    [pro3 release];
    [pro4 release];
    [pro5 release];
    [pro6 release];
    [pro7 release];
    [pro8 release];
    [powerBtn release];
    [powerOnBtn release];
    [powerOffBtn release];
    [playBtn release];
    [stopBtn release];
    [super dealloc];
}
@end
