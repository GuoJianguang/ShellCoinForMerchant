//
//  JAlertViewHelper.h
//  TourguideSecond
//
//  Created by tongbu_jinzhongjun on 14/11/20.
//  Copyright (c) 2014年 tongbu_jinzhongjun. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HttpClientAlertViewHelper : NSObject

+(HttpClientAlertViewHelper*) sharedAlterHelper;
-(void) showTint:(NSString*)message duration:(NSTimeInterval) timeInterval;
@end