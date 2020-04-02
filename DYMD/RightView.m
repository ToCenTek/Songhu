//
//  RightView.m
//  DYMD
//
//  Created by 蒋华阳 on 14-10-3.
//  Copyright (c) 2014年 蒋华阳. All rights reserved.
//

#import "RightView.h"

@implementation RightView
@synthesize tableview;
@synthesize infos=_infos;
@synthesize controller;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


-(void)setInfos:(NSDictionary *)infos{
    _infos = infos;
    self.tableview.scrollEnabled = false;
    [self.tableview reloadData];
}

-(void)beginInit
{
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    if ([tableview.delegate respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
        [tableview.delegate tableView:self.tableview willSelectRowAtIndexPath:indexPath];
    }
    
    [tableview selectRowAtIndexPath:indexPath animated:YES scrollPosition: UITableViewScrollPositionNone];
    
    if ([tableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        
        [tableview.delegate tableView:self.tableview didSelectRowAtIndexPath:indexPath];
        
    }
}

-(void)awakeFromNib{
    [self.tableview setBackgroundColor:[UIColor clearColor]];
    [self.tableview setBackgroundView:nil];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.infos==nil) return 0;
    
    return [[self.infos objectForKey:@"count"] integerValue];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    RightViewCell *cell  = (RightViewCell*)[tableView dequeueReusableCellWithIdentifier:@"EditViewCellIdentifier"];
    if (!cell) {
        cell = (RightViewCell*)[[[NSBundle mainBundle] loadNibNamed:@"RightViewCell" owner:self options:nil] objectAtIndex:0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //self.controller.innerSubType=1;
    }
    
    [cell setBackgroundView:nil];
    [cell setBackgroundColor:[UIColor clearColor]];
    NSDictionary *exhibitionItemDic = [_infos objectForKey:[NSString stringWithFormat:@"展项%d",(int)[indexPath row]+1]];
    NSString *itemName = [exhibitionItemDic objectForKey:@"name"] ;
    if ([itemName isEqualToString:@"展项"]) {
        cell.userInteractionEnabled = FALSE;
    }
    
    NSString *iconName = [exhibitionItemDic objectForKey:@"icon"];
    UIImage *im = [UIImage imageNamed:iconName];
    [cell.im setImage:im];
    
   
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *exhibitionItemDic = [_infos objectForKey:[NSString stringWithFormat:@"展项%d",(int)[indexPath row]+1]];
    NSString *itemName = [exhibitionItemDic objectForKey:@"name"];
    if ([itemName isEqualToString:@"展项"]) {
        return  60;
    }
    return 50;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger iRow = [indexPath row];
    int currentInnerSubType = self.controller.innerSubType ;
    if(currentInnerSubType != (int)iRow+1) {
        self.controller.innerSubType = (int)iRow+1;
    }
    
    NSInteger tableRow = [[self.infos objectForKey:@"count"] integerValue];
    for(int i=0;i<tableRow;i++) {
        NSIndexPath *ip = [NSIndexPath indexPathForRow:i inSection:0];
        NSInteger ipRow = [ip row];
        RightViewCell *cell=(RightViewCell*)[tableView cellForRowAtIndexPath:ip];
        
        if(ipRow == iRow) {
            UIImageView * imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ipad界面-17.png"]];
            [cell setBackgroundView:imageView];
        } else {
            [cell setBackgroundView:nil];
        }
    }
}
@end
@implementation RightViewCell
@synthesize im;

@end

