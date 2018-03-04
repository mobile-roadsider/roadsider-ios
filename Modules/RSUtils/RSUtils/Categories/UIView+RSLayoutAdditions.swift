//
//  UIView+RSAdditions.swift
//  RSUtils
//
//  Created by Niyaz Ahmed Amanullah on 10/26/17.
//  Copyright © 2017 Roadsider. All rights reserved.
//

import Foundation
import UIKit


//MARK: - Align views
extension UIView {
    /**
     Aligns this view's leading attribute to another view
     - parameter view:   The other view to align this view to
     *                    |[view]
     *                    |-(offset)-[self]
     - parameter offset: The offset to align this view
     - returns: The constraint added if this was a valid request
     */
    public func alignLeading(toView view: UIView, offset: Float) -> NSLayoutConstraint {
        return leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: CGFloat(offset))
    }
    
    /**
     Aligns this view's leading attribute to another view
     - parameter view:   The other view to align this view to
     *                    |[view]
     *                    |[self]
     - returns: The constraint added if this was a valid request
     */
    public func alignLeading(toView view: UIView) -> NSLayoutConstraint {
        return alignLeading(toView: view, offset: 0.0)
    }
    
    /**
     Aligns this view's trailing attribute to another view
     - parameter view:   The other view to align this view to
     *                                [view]|
     *                    [self]-(offset)-|
     - parameter offset: The offset to align this view
     - returns: The constraint added if this was a valid request
     */
    public func alignTrailing(toView view: UIView, offset: Float) -> NSLayoutConstraint {
        return view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: CGFloat(offset))
    }
    
    /**
     Aligns this view's trailing attribute to another view
     - parameter view:   The other view to align this view to
     *                    [view]|
     *                    [self]|
     - returns: The constraint added if this was a valid request
     */
    public func alignTrailing(toView view: UIView) -> NSLayoutConstraint {
        return alignTrailing(toView: view, offset: 0)
    }
    
    /**
     Aligns this view's Left attribute to another view. (Not recommended - should use Leading if possible)
     - parameter view:   The other view to align this view to
     *                    |[view]
     *                    |-(offset)-[self]
     - parameter offset: The offset to align this view
     - returns: The constraint added if this was a valid request
     */
    public func alignLeft(toView view: UIView, offset: Float) -> NSLayoutConstraint {
        return leftAnchor.constraint(equalTo: view.leftAnchor, constant: CGFloat(offset))
    }
    
    /**
     Aligns this view's Left attribute to another view (Not recommended - should use Leading if possible)
     - parameter view:   The other view to align this view to
     *                   |[view]
     *                   |[self]
     - returns: The constraint added if this was a valid request
     */
    public func alignLeft(toView view: UIView) -> NSLayoutConstraint {
        return alignLeft(toView: view, offset: 0.0)
    }
    
    /**
     Aligns this view's Right attribute to another view (Not recommended - should use Trailing if possible)
     - parameter view:   The other view to align this view to
     *                               [view]|
     *                   [self]-(offset)-|
     - parameter offset: The offset to align this view
     - returns: The constraint added if this was a valid request
     */
    public func alignRight(toView view: UIView, offset: Float) -> NSLayoutConstraint {
        return view.rightAnchor.constraint(equalTo: rightAnchor, constant: CGFloat(offset))
    }
    
    /**
     Aligns this view's Right attribute to another view (Not recommended - should use Trailing if possible)
     - parameter view:   The other view to align this view to
     *                   [view]|
     *                   [self]|
     - returns: The constraint added if this was a valid request
     */
    public func alignRight(toView view: UIView) -> NSLayoutConstraint {
        return alignRight(toView: view, offset: 0.0)
    }
    
    /**
     Aligns this view's top attribute to another view
     - parameter view:   The other view to align this view to
     *                    ______________
     *                    [view]    |
     *                            (offset)
     *                              |
     *                            [self]
     - returns: The constraint added if this was a valid request
     */
    public func alignTop(toView view: UIView, offset: Float) -> NSLayoutConstraint {
        return topAnchor.constraint(equalTo: view.topAnchor, constant: CGFloat(offset))
    }
    
    /**
     Aligns this view's top attribute to another view
     - parameter view:   The other view to align this view to
     *                    ______________
     *                    [view]  [self]
     - returns: The constraint added if this was a valid request
     */
    public func alignTop(toView view: UIView) -> NSLayoutConstraint {
        return alignTop(toView: view, offset: 0.0)
    }
    
    /**
     Aligns this view's bottom attribute to another view
     - parameter view:   The other view to align this view to
     *                            [self]
     *                               |
     *                           (offset)
     *                    [view]     |
     *                    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯
     - returns: The constraint added if this was a valid request
     */
    public func alignBottom(toView view: UIView, offset: Float) -> NSLayoutConstraint {
        return view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: CGFloat(offset))
    }
    
    /**
     Aligns this view's bottom attribute to another view
     - parameter view:   The other view to align this view to
     *                    [view]  [self]
     *                    ¯¯¯¯¯¯¯¯¯¯¯¯¯¯
     - returns: The constraint added if this was a valid request
     */
    public func alignBottom(toView view: UIView) -> NSLayoutConstraint {
        return alignBottom(toView: view, offset: 0)
    }
    
    
    /**
     Matches x center of the two views
     - parameter view: The view to be aligned by x center
     - returns: Thew newly added constraint if possible
     */
    public func alignVertically(toView view: UIView) -> NSLayoutConstraint {
        return centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }
    
    /**
     Matches y center of the two views
     - parameter view: The view to be aligned by y center
     - returns: Thew newly added constraint if possible
     */
    public func alignHorizontally(toView view: UIView) -> NSLayoutConstraint {
        return centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }
    
    /**
     Matches x center of the two views
     - parameter view: The view to be aligned by x center
     - returns: Thew newly added constraint if possible
     */
    public func alignVertically(toView view: UIView, offset: Float) -> NSLayoutConstraint {
        return centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: CGFloat(offset))
    }
    
    /**
     Matches y center of the two views
     - parameter view: The view to be aligned by y center
     - returns: Thew newly added constraint if possible
     */
    public func alignHorizontally(toView view: UIView, offset: Float) -> NSLayoutConstraint {
        return centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: CGFloat(offset))
    }
}

// MARK: - Pin views side by side
extension UIView {
    
    /**
     Pins a view at the leading of this view
     - parameter leadingView: The view to be pinned to this view
     *                         [view]--(offset)--[self]
     - parameter offset:      The offset between this two views
     - returns: The newly added constraint
     */
    public func pinLeading(leadingView: UIView, offset: Float) -> NSLayoutConstraint {
        return leadingAnchor.constraint(equalTo: leadingView.trailingAnchor, constant: CGFloat(offset))
    }
    
    /**
     Pins a view at the leading of this view
     - parameter leadingView: The view to be pinned to this view
     *                         [view][self]
     - returns: The newly added constraint
     */
    public func pinLeading(_ leadingView: UIView) -> NSLayoutConstraint {
        return pinLeading(leadingView: leadingView, offset: 0.0)
    }
    
    /**
     Pins a view at the trailing of this view
     - parameter trailingView: The view to be pinned to this view
     *                         [self]--(offset)--[view]
     - parameter offset:      The offset between this two views
     - returns: The newly added constraint
     */
    public func pinTrailing(_ trailingView: UIView, offset: Float) -> NSLayoutConstraint {
        return trailingView.pinLeading(leadingView: self, offset: offset)
    }
    
    /**
     Pins a view at the trailing of this view
     - parameter trailingView: The view to be pinned to this view
     [self][view]
     - returns: The constraint to be added
     */
    public func pinTrailing(_ trailingView: UIView) -> NSLayoutConstraint {
        return pinTrailing(trailingView, offset: 0)
    }
    
    /**
     Pins a view at the leading of this view
     - parameter leftView: The view to be pinned to this view
     *                         [view]--(offset)--[self]
     - parameter offset:      The offset between this two views
     - returns: The newly added constraint
     */
    public func pinLeft(_ leftView: UIView, offset: Float) -> NSLayoutConstraint {
        return leftAnchor.constraint(equalTo: leftView.rightAnchor, constant: CGFloat(offset))
    }
    
    /**
     Pins a view at the leading of this view
     - parameter leftView: The view to be pinned to this view
     *                         [view][self]
     - returns: The newly added constraint
     */
    public func pinLeft(_ leftView: UIView) -> NSLayoutConstraint {
        return pinLeft(leftView, offset: 0.0)
    }
    
    /**
     Pins a view at the trailing of this view
     - parameter rightView: The view to be pinned to this view
     *                         [self][view]
     - parameter offset:      The offset between this two views
     - returns: The newly added constraint
     */
    public func pinRight(_ rightView: UIView, offset: Float) -> NSLayoutConstraint {
        return rightView.pinLeft(self, offset: offset)
    }
    
    /**
     Pins a view at the trailing of this view
     - parameter rightView: The view to be pinned to this view
     [self][view]
     - returns: The constraint to be added
     */
    public func pinRight(_ rightView: UIView) -> NSLayoutConstraint {
        return pinRight(rightView, offset: 0)
    }
    
    /**
     Pins a view at the top of this view
     - parameter topView: The view to be pinned to this view
     *                     [view]
     *                       |
     *                    (offset)
     *                       |
     *                     [self]
     - parameter offset:  The offset between this two views
     - returns: The newly added constraint
     */
    public func pinTop(_ topView: UIView, offset: Float) -> NSLayoutConstraint {
        return topAnchor.constraint(equalTo: topView.bottomAnchor, constant: CGFloat(offset))
    }
    
    
    /**
     Pins a view at the top of this view
     - parameter topView: The view to be pinned to this view
     *                     [view]
     *                       | >=
     *                    (offset)
     *                       |
     *                     [self]
     - parameter offset:  The offset between this two views
     - returns: The newly added constraint
     */
    public func pinTopGreaterThanEqualTo(_ topView: UIView, offset: Float) -> NSLayoutConstraint {
        return topAnchor.constraint(greaterThanOrEqualTo: topView.bottomAnchor, constant:  CGFloat(offset))
    }
    
    /**
     Pins a view at the top of this view
     - parameter topView: The view to be pinned to this view
     *                    [view]
     *                       |
     *                    [self]
     - returns: The newly added constraint
     */
    public func pinTop(_ topView: UIView) -> NSLayoutConstraint {
        return pinTop(topView, offset: 0)
    }
    
    /**
     Pins a view at the bottom of this view
     - parameter bottomView: The view to be pinned to this view
     *                    [self]
     *                       |
     *                    (offset)
     *                       |
     *                    [view]
     - parameter offset:  The offset between this two views
     - returns: The newly added constraint
     */
    public func pinBottom(_ bottomView: UIView, offset: Float) -> NSLayoutConstraint {
        return bottomView.pinTop(self, offset: offset)
    }
    
    /**
     Pins a view at the bottom of this view
     - parameter bottomView: The view to be pinned to this view
     *                    [self]
     *                       |
     *                    (offset)
     *                       |
     *                    [view]
     - parameter offset:  The offset between this two views
     - returns: The newly added constraint
     */
    public func pinBottomGreaterThanEqual(_ bottomView: UIView, offset: Float) -> NSLayoutConstraint {
        return bottomView.pinTopGreaterThanEqualTo(self, offset: offset)
    }
    
    /**
     Pins a view at the bottom of this view
     - parameter bottomView: The view to be pinned to this view
     *                    [view]
     *                       |
     *                    [self]
     - returns: The newly added constraint
     */
    public func pinBottom(_ bottomView: UIView) -> NSLayoutConstraint {
        return pinBottom(bottomView, offset: 0)
    }
}

// MARK: - Equal views dimensions
extension UIView {
    
    /**
     Creates a constraint that matches the width between this view and another view: width = view.width
     - parameter view: The other view that should have equal width as this view
     - returns: The newly added constraint if possible
     */
    public func matchWidth(toView view: UIView) -> NSLayoutConstraint {
        return matchWidth(toView: view, ratio: 1.0)
    }
    
    /**
     Creates a constraint that matches the width between this view and another view: width = view.width
     - parameter view: The other view that should have equal width as this view
     - returns: The newly added constraint if possible
     */
    public func matchWidth(toView view: UIView, ratio: Float) -> NSLayoutConstraint {
        return widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: CGFloat(ratio))
    }
    
    
    /**
     Creates a constraint that matches the height between this view and another view: height = view.height
     - parameter view: The other view that should have equal height as this view
     - returns: The newly added constraint if possible
     */
    public func matchHeight(toView view: UIView) -> NSLayoutConstraint {
        return matchHeight(toView: view, ratio: 1.0)
    }
    
    /**
     Creates a constraint that matches the height between this view and another view: height = view.height
     - parameter view: The other view that should have equal height as this view
     - returns: The newly added constraint if possible
     */
    public func matchHeight(toView view: UIView, ratio: Float) -> NSLayoutConstraint {
        return heightAnchor.constraint(equalTo:view.heightAnchor, multiplier: CGFloat(ratio))
    }
    
    /**
     Checks if two views are in the same view hierarchy
     - parameter view: The other view used to check to check its hierarchy with this view
     - returns: True if the views are in the same view hierarchy, false otherwise
     */
    public func hasCommonAncestorWith(view: UIView) -> Bool {
        var superview: UIView? = self
        while let ancestor = superview {
            if view.isDescendant(of: ancestor) {
                return true
            }
            superview = ancestor.superview
        }
        return false
    }
}

// MARK: - Set dimensions values
extension UIView {
    
    /**
     Creates a constraint that sets the width of this view
     - parameter width: The width value to be set
     - returns: The newly added constraint
     */
    public func makeWidth(_ width: Float) -> NSLayoutConstraint {
        return widthAnchor.constraint(equalToConstant: CGFloat(width))
    }
    
    /**
     Creates a constraint that sets the width of this view to be equal or greater than the value passed in
     - parameter width: The width value to be set
     - returns: The newly added constraint
     */
    public func makeWidthGreaterThanOrEqualTo(width: Float) -> NSLayoutConstraint {
        return widthAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(width))
    }
    
    /**
     Creates a constraint that sets the width of this view to be equal or lesser than the value passed in
     - parameter width: The width value to be set
     - returns: The newly added constraint
     */
    public func makeWidthLessThanOrEqualTo(width: Float) -> NSLayoutConstraint {
        return widthAnchor.constraint(lessThanOrEqualToConstant: CGFloat(width))
    }
    
    /**
     Creates a constraint that sets the height of this view
     - parameter height: The height value to be set
     - returns: The newly added constraint
     */
    public func makeHeight(_ height: Float) -> NSLayoutConstraint {
        return heightAnchor.constraint(equalToConstant: CGFloat(height))
    }
    
    /**
     Creates a constraint that sets the height of this view to be equal or greater than the value passed in
     - parameter height: The height value to be set
     - returns: The newly added constraint
     */
    public func makeHeightGreaterThanOrEqualTo(height: Float) -> NSLayoutConstraint {
        return heightAnchor.constraint(greaterThanOrEqualToConstant: CGFloat(height))
    }
    
    /**
     Creates a constraint that sets the height of this view to be equal or less than the value passed in
     - parameter height: The height value to be set
     - returns: The newly added constraint
     */
    public func makeHeightLessThanOrEqualTo(height: Float) -> NSLayoutConstraint {
        return heightAnchor.constraint(lessThanOrEqualToConstant: CGFloat(height))
    }
    
    /**
     Creates a constraint for setting an aspect ratio to this view: width = height * ratio
     - parameter ratio: The desired aspect ratio
     - returns: The newly added constraint
     */
    public func makeAspectRatio(ratio: Float) -> NSLayoutConstraint {
        return widthAnchor.constraint(equalTo: heightAnchor, multiplier: CGFloat(ratio))
    }
}

extension UIView {
    /**
     aligns the view top,bottom,left and right with its super view with zero insets
     */
    public func attachToSuperView() -> [NSLayoutConstraint] {
        return attachToSuperView(insets: UIEdgeInsets.zero)
    }
    
    /**
     aligns the view top,bottom,left and right with its super view with provided insets
     */
    public func attachToSuperView(insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        guard let superview = self.superview  else {return [] }
        return attachToView(view: superview, insets: insets)
    }
    
    /**
     aligns the view top,bottom,left and right with the given view with provided insets
     */
    public func attachToView(view: UIView , insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        return [
            alignTop(toView: view, offset:Float(insets.top)),
            alignLeft(toView: view, offset:Float(insets.left)),
            alignBottom(toView: view, offset:Float(insets.bottom)),
            alignRight(toView: view, offset:Float(insets.right))
        ]
    }
    
    /**
     Aligns the view horizontally in its superview by forcing minimum leading and trailing offsets.
     */
    public func alignHorizontallyInSuperview(minLeading: CGFloat, minTrailing: CGFloat) -> [NSLayoutConstraint] {
        guard let superview = superview else {
            return []
        }
        return [
            leadingAnchor.constraint(greaterThanOrEqualTo: superview.leadingAnchor, constant: minLeading),
            trailingAnchor.constraint(lessThanOrEqualTo: superview.trailingAnchor, constant: minTrailing)
        ]
    }
    
    public func layoutVertical(margin: CGFloat) -> [NSLayoutConstraint] {
        let metrics = ["margin": margin ]
        return NSLayoutConstraint.constraints(withVisualFormat:"V:|-margin-[view]-margin-|",
                                              options:NSLayoutFormatOptions(rawValue: 0),
                                              metrics: metrics,
                                              views:["view": self])
        
        
        
    }
    
    public func layoutHorizontal(margin: CGFloat)  -> [NSLayoutConstraint] {
        let metrics = ["margin": margin ]
        
        return NSLayoutConstraint.constraints(withVisualFormat:"H:|-margin-[view]-margin-|",
                                              options:NSLayoutFormatOptions(rawValue: 0),
                                              metrics: metrics,
                                              views:["view": self])
    }
}
