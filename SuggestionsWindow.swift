//  Converted to Swift 4 by Swiftify v4.1.6654 - https://objectivec2swift.com/
/*
 File: SuggestionsWindow.m
 Abstract: A custom window that acts as a popup menu of sorts.  Since this isn't semantically a window, we ignore it for accessibility purposes. However, we need to inform accessibility of the logical relationship between this window and it parent UI element in the parent window.
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

class SuggestionsWindow: NSWindow {
    var parentElement: Any?

    /* Convience initializer that removes the syleMask and backing parameters since they are static values for this class.
     */
    convenience init(contentRect: NSRect, defer flag: Bool) {
        self.init(contentRect: contentRect, styleMask: .borderless, backing: .buffered, defer: true)
    }
    /*  We still need to override the NSWindow designated initializer to properly setup our custom window. This allows us to set the class of a window in IB to SuggestionWindow and still get the correct properties (borderless and transparent).
     */
    override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool) {
        // Regardless of what is passed via the styleMask paramenter, always create a NSBorderlessWindowMask window
        super.init(contentRect: contentRect, styleMask: .borderless, backing: .buffered, defer: flag)

        // This window is always has a shadow and is transparent. Force those setting here.
        hasShadow = true
        backgroundColor = NSColor.clear
        isOpaque = false

    }

    // MARK: -
    // MARK: Accessibility
    /* This window is acting as a popup menu of sorts.  Since this isn't semantically a window, we ignore it for accessibility purposes.  Similarly, the parent of this window is its logical parent in the parent window.  In this code sample, the text field, but essentially any UI element that is the logical 'parent' of the window.
     */
    override public func isAccessibilityEnabled() -> Bool {
        return true
    }
    /* If we are asked for our AXParent, return the unignored anscestor of our parent element
     */
    override public func accessibilityParent() -> Any? {
        return (parentElement != nil) ? NSAccessibilityUnignoredAncestor(parentElement!) : (nil as Any?)
    }
}
