//
//  ApiCommentResponse.h
//  WordOfMouthEngine
//
//  Created by Bijit Halder on 11/24/14.
//  Copyright (c) 2014 Bijit Halder. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    kApiCommentResponseTypeDislike=0,
    kApiCommentResponseTypeLike=1,
} kApiCommentResponseType;

@interface ApiCommentResponse : NSObject{
    
}

@property   NSNumber *commentResponseId;
@property   NSNumber *userId;
@property   NSNumber *commentId;
@property   NSNumber *commentResponse;

#pragma mark - Init Methods
- (ApiCommentResponse *)initWithResponseId:(NSNumber *)commentResponseId_
                                    userId:(NSNumber *)userId_
                          commentId:(NSNumber *)commentId_
                       commentResponse:(NSNumber *)commentResponse_;

- (ApiCommentResponse *)initWithResponseId:(NSNumber *)commentResponseId_
                                    userId:(NSNumber *)userId_
                             commentId:(NSNumber *)commentId_;


#pragma mark - Utility Methods
/*!
 *  Valdiates existence of user response properties: userid and contentid
 *  @param user An ApiCommentResponse Object
 *  @return BOOL value indicating validity of the user object
 *  @discussion To be valid userId and commentId must be a positive integer (>=1)
 */
+(BOOL)isValidCommentResponse:(ApiCommentResponse *)commentResponse;
/*!
 *  Prints ApiCommentResponse Object with all the properties
 *  @param content An ApiCommentResponse Object to be printed
 */
+(void)printApiCommentResponse:(ApiCommentResponse  *)commentResponse;

@end