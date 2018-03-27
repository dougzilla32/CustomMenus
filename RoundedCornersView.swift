//  Converted to Swift 4 by Swiftify v4.1.6654 - https://objectivec2swift.com/
/*
 File: RoundedCornersView.m
 Abstract: A view that draws a rounded rect with the window background. It is used to draw the background for the suggestions window and expose the suggestions to accessibility.
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

class RoundedCornersView: NSView {
    var rcvCornerRadius: CGFloat = 0.0
    private var cornerRadius: CGFloat = 0.0

    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }

    override init(frame: NSRect) {
        super.init(frame: frame)

        rcvCornerRadius = 10.0

    }

    override func draw(_ dirtyRect: NSRect) {
        let cornerRadius: CGFloat = rcvCornerRadius
        let borderPath = NSBezierPath(roundedRect: bounds, xRadius: cornerRadius, yRadius: cornerRadius)
        NSColor.windowBackgroundColor.setFill()
        borderPath.fill()
    }
    func isFlipped() -> Bool {
        return true
    }

    /*
// MARK: -
// MARK: Accessibility
    /* This view contains the list of selections.  It should be exposed to accessibility, and should report itself with the role 'AXList'.  Because this is an NSView subclass, most of the basic accessibility behavior (accessibility parent, children, size, position, window, and more) is inherited from NSView.  Note that even the role description attribute will update accordingly and its behavior does not need to be overridden.  However, since the role AXList has a number of additional required attributes, we need to declare them and implement them.
     */
    /* Make sure we are reported by accessibility.  NSView's default return value is YES.
     */
    override func accessibilityIsIgnored() -> Bool {
        return false
    }
    /* The suggestions will be an AXList of suggestions.  AXList requires additional attributes beyond what NSView provides.
     */
    func accessibilityAttributeNames() -> [Any]? {
        var attributeNames = super.accessibilityAttributeNames()
        attributeNames.append(.orientation)
        attributeNames.append(.enabled)
        attributeNames.append(.visibleChildren)
        attributeNames.append(.selectedChildren)
        return attributeNames
    }
    /* Return a different value for the role attribute, and the values for the additional attributes declared above.
     */
    override func accessibilityAttributeValue(_ attribute: NSAccessibilityAttributeName?) -> Any? {
        // Report our role as AXList
        if (attribute == .role) {
            return NSAccessibilityRole.list
            // Our orientation is vertical
        }
        else if (attribute == .orientation) {
            return NSAccessibilityOrientation.vertical
            // The list is always enabled
        }
        else if (attribute == .enabled) {
            return 1
            // There is no scroll bar in this example - all children are always visible
        }
        else if (attribute == .visibleChildren) {
            return accessibilityAttributeValue(.children)
            // Run through children, and if they respond to 'isHighlighted' put them in the list
        }
        else if (attribute == .selectedChildren) {
            var selectedChildren = [AnyHashable]()
            for element: Any in (NSObject.accessibilityAttributeValue(.children) as! Array<Any>) {
                if (element as AnyObject).responds(to: #selector(self.isHighlighted)) && element.isHighlighted() {
                    selectedChildren.append(element as! AnyHashable)
                }
            }
            return selectedChildren
            // Otherwise, return what super returns
        }
        else {
            return super.accessibilityAttributeValue(NSAccessibilityAttributeName(rawValue: attribute!.rawValue))
        }
    }
    /* In addition to reporting the value for an attribute, we need to return whether value of the attribute can be set.
     */
    func accessibilityIsAttributeSettable(_ attribute: String?) -> Bool {
        // Three of the four attributes we added are not settable
        if (attribute == .orientation) || (attribute == .enabled) || (attribute == .visibleChildren) || (attribute == .selectedChildren) {
            return false
        }
        else if (attribute == .selectedChildren) {
            return true
            // Otherwise, return what super returns
        }
        else {
            return super.accessibilityIsAttributeSettable(NSAccessibilityAttributeName(attribute))
        }
    }
    func accessibilitySetValue(_ value: Any?, forAttribute attribute: NSAccessibilityAttributeName) {
        if (attribute == .selectedChildren) {
            var windowController: NSWindowController? = window().windowController
            if windowController != nil {
                // Our subclass of NSWindowController has a selectedView property
                windowController?.setValue(value, forKey: "selectedView")
            }
        }
        else {
            super.accessibilitySetValue(value, forAttribute: NSAccessibilityAttributeName(attribute))
        }
    }
    */
}
