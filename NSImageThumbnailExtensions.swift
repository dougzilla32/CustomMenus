//  Converted to Swift 4 by Swiftify v4.1.6654 - https://objectivec2swift.com/
/*
 File: NSImageThumbnailExtensions.m
 Abstract: A category on NSImage to create a thumbnail sized NSImage from an image URL.
 Version: 1.4
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple
 Inc. ("Apple") in consideration of your agreement to the following
 terms, and your use, installation, modification or redistribution of
 this Apple software constitutes acceptance of these terms.  If you do
 not agree with these terms, please do not use, install, modify or
 redistribute this Apple software.
 In consideration of your agreement to abide by the following terms, and
 subject to these terms, Apple grants you a personal, non-exclusive
 license, under Apple's copyrights in this original Apple software (the
 "Apple Software"), to use, reproduce, modify and redistribute the Apple
 Software, with or without modifications, in source and/or binary forms;
 provided that if you redistribute the Apple Software in its entirety and
 without modifications, you must retain this notice and the following
 text and disclaimers in all such redistributions of the Apple Software.
 Neither the name, trademarks, service marks or logos of Apple Inc. may
 be used to endorse or promote products derived from the Apple Software
 without specific prior written permission from Apple.  Except as
 expressly stated in this notice, no other rights or licenses, express or
 implied, are granted by Apple herein, including but not limited to any
 patent rights that may be infringed by your derivative works or by other
 works in which the Apple Software may be incorporated.
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS.
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION,
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE),
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE
 POSSIBILITY OF SUCH DAMAGE.
 Copyright (C) 2012 Apple Inc. All Rights Reserved.
 */
import Cocoa

extension NSImage {
    /* Create an NSImage from with the contents of the url of the specified width. The height of the resulting NSImage maintains the proportions in source.
     */
    class func iteThumbnailImage(withContentsOf url: URL?, width: CGFloat) -> Any? {
        var thumbnailImage: NSImage? = nil
        var image: NSImage? = nil
        if let anUrl = url {
            image = NSImage(contentsOf: anUrl)
        }
        if image != nil {
            let imageSize: NSSize = image!.size
            let imageAspectRatio: CGFloat = imageSize.width / imageSize.height
            // Create a thumbnail image from this image (this part of the slow operation)
            let thumbnailSize = NSSize(width: width, height: width * imageAspectRatio)
            thumbnailImage = NSImage(size: thumbnailSize)
            thumbnailImage?.lockFocus()
            image?.draw(in: NSRect(x: 0.0, y: 0.0, width: thumbnailSize.width, height: thumbnailSize.height), from: NSRect.zero, operation: .sourceOver, fraction: 1.0)
            thumbnailImage?.unlockFocus()
            /* In general, the accessibility description is a localized description of the image.  In this app, and in the Desktop & Screen Saver preference pane, the name of the desktop picture file is what is used as the localized description in the user interface, and so it is appropriate to use the file name in this case.
             
             When an accessibility description is set on an image, the description is automatically reported to accessibility when that image is displayed in image views/cells, buttons/button cells, segmented controls, etc.  In this case the description is set programatically.  For images retrieved by name, using +imageNamed:, you can use a strings file named AccessibilityImageDescriptions.strings, which uses the names of the images as keys and the description as the string value, to automatically provide accessibility descriptions for named images in your application.
             */
            let imageName = URL(fileURLWithPath: url?.lastPathComponent ?? "").deletingPathExtension().absoluteString
            thumbnailImage?.accessibilityDescription = imageName
        }
        /* This is a sample code feature that delays the creation of the thumbnail for demonstration purposes only.
         Hold down the control key to extend thumnail creation by 2 seconds.
         */
        if NSEvent.modifierFlags.contains(.control) {
            usleep(2000000)
        }
        return thumbnailImage
    }
}

/* A shared operation que that is used to generate thumbnails in the background.
 */
func ITESharedOperationQueue() -> OperationQueue? {
    var ITEImageSharedOperationQueue: OperationQueue? = nil
    if ITEImageSharedOperationQueue == nil {
        ITEImageSharedOperationQueue = OperationQueue()
        ITEImageSharedOperationQueue?.maxConcurrentOperationCount = OperationQueue.defaultMaxConcurrentOperationCount
    }
    return ITEImageSharedOperationQueue
}
