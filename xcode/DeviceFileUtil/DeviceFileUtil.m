//
//  DeviceFileUtil.m
//  DeviceFileUtil
//
//  Created by Todsaporn Banjerdkit (katopz) on 12/2/12.
//  Copyright (c) 2012 Todsaporn Banjerdkit. All rights reserved.
//

#import "FlashRuntimeExtensions.h"

#import <UIKit/UIKit.h>

//------------------------------------
//
// Helper Methods.
//
//------------------------------------

NSString *toNSString(FREObject *str)
{
    NSString *nsStr = nil;
    
    if(str)
    {
        // Temporary values to hold our actionscript code.
        uint32_t retStrLength;
        const uint8_t *retStr;
    
        // Turn our actionscrpt code into native code.
        FREGetObjectAsUTF8(str, &retStrLength, &retStr);
    
        // Get str as NSString
        nsStr = [NSString stringWithUTF8String:(char*)retStr];
        [nsStr retain];
    }
    
    return [nsStr autorelease];
}

//------------------------------------
//
// Core Methods.
//
//------------------------------------

FREObject openWith(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    // Get main controller
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIViewController *mainController = [keyWindow rootViewController];
    
    // Which path? bundle or doc?
    NSString *fileName = toNSString(argv[0]);
    NSString *basePath = toNSString(argv[1]);
    NSString *fileNameNoType = [fileName stringByDeletingPathExtension];
    
    NSString *fileURI;
      
    if ([basePath isEqualToString:@"bundle"])
    {        
        // Get bundle path
        fileURI= [[NSBundle mainBundle] pathForResource:fileNameNoType ofType:[fileName pathExtension]];
        [fileURI retain];
    }
    else
    {
        // Get doc path
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        // Get file path
        fileURI = [documentsDirectory stringByAppendingPathComponent:fileName];
        [fileURI retain];
    }
    
    // Get URL from file path
    NSURL *url = [NSURL fileURLWithPath:fileURI];
    [url retain];
    [fileURI release];
    
    // Try to open with...
    UIDocumentInteractionController *docController = [UIDocumentInteractionController interactionControllerWithURL:url];
    [docController retain];
    [url release];
    
    // Show me the view
    [docController presentOptionsMenuFromRect:CGRectZero inView:mainController.view animated:YES];
    
    return NULL;
}

//------------------------------------
//
// Required Methods.
//
//------------------------------------

// The context initializer is called when the runtime creates the extension context instance.

void DeviceFileUtilContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
	*numFunctionsToTest = 1;
	FRENamedFunction* func = (FRENamedFunction*)malloc(sizeof(FRENamedFunction)*1);
    
	func[0].name = (const uint8_t*)"openWith";
	func[0].functionData = NULL;
	func[0].function = &openWith;
    
	*functionsToSet = func;
}

// The context finalizer is called when the extension's ActionScript code
// calls the ExtensionContext instance's dispose() method.
// If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().

void DeviceFileUtilContextFinalizer(FREContext ctx)
{
	return;
}

// The extension initializer is called the first time the ActionScript side of the extension
// calls ExtensionContext.createExtensionContext() for any context.

void DeviceFileUtilExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet)
{
	*extDataToSet = NULL;
	*ctxInitializerToSet = &DeviceFileUtilContextInitializer;
	*ctxFinalizerToSet = &DeviceFileUtilContextFinalizer;
}

// The extension finalizer is called when the runtime unloads the extension. However, it is not always called.

void DeviceFileUtilExtFinalizer(void* extData)
{
	return;
}