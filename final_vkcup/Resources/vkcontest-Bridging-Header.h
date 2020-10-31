//
//  VKSdkFramework.h
//
//  Copyright (c) 2015 VK.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


#import "UIKit/UIKit.h"

//! Project version number for VKSdkFramework.
FOUNDATION_EXPORT double VKSdkFrameworkVersionNumber;

//! Project version string for VKSdkFramework.
FOUNDATION_EXPORT const unsigned char VKSdkFrameworkVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import "VKSdkFramework/PublicHeader.h"
#import "VKSdk.h"
#import "VKAccessToken.h"
#import "VKPermissions.h"
#import "VKUtil.h"
#import "VKApi.h"
#import "VKApiConst.h"
#import "VKSdkVersion.h"
#import "VKCaptchaViewController.h"
#import "VKRequest.h"
#import "VKBatchRequest.h"
#import "NSError+VKError.h"
#import "VKApiModels.h"
#import "VKUploadImage.h"
#import "VKShareDialogController.h"
#import "VKActivity.h"
#import "OrderedDictionary.h"
#import "VKAuthorizeController.h"
#import "VKBundle.h"
#import "VKCaptchaView.h"
#import "VKUploadMessagesPhotoRequest.h"
#import "VKUploadPhotoBase.h"
#import "VKUploadPhotoRequest.h"
#import "VKUploadWallPhotoRequest.h"
#import "VKHTTPClient.h"
#import "VKHTTPOperation.h"
#import "VKJSONOperation.h"
#import "VKRequestsScheduler.h"
#import "VKSharedTransitioningObject.h"
#import "NSString+MD5.h"
