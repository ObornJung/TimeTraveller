//
//  Popover.swift
//  Popover
//
//  Created by corin8823 on 8/16/15.
//  Copyright (c) 2015 corin8823. All rights reserved.
//

import UIKit
import SnapKit

public enum PopoverOption {
  case ArrowSize(CGSize)
  case AnimationIn(NSTimeInterval)
  case AnimationOut(NSTimeInterval)
  case CornerRadius(CGFloat)
  case SideEdge(CGFloat)
  case BlackOverlayColor(UIColor)
  case OverlayBlur(UIBlurEffectStyle)
  case Type(Popover.PopoverType)
  case Color(UIColor)
}

public class Popover: UIView {

  public enum PopoverType {
    case Up
    case Down
  }

  // custom property
  private var arrowSize: CGSize = CGSize(width: 16.0, height: 10.0)
  private var animationIn: NSTimeInterval = 0.6
  private var animationOut: NSTimeInterval = 0.3
  private var cornerRadius: CGFloat = 6.0
  private var sideEdge: CGFloat = 20.0
  private var popoverType: PopoverType = .Down
  private var blackOverlayColor: UIColor = UIColor(white: 0.0, alpha: 0.2)
  private var overlayBlur: UIBlurEffect?
  private var popoverColor: UIColor = UIColor.whiteColor()

  // custom closure
  private var didShowHandler: (() -> ())?
  private var didDismissHandler: (() -> ())?

  private var blackOverlay: UIControl = UIControl()
  private var containerView: UIView!
  private var contentView: UIView!
  private var contentViewFrame: CGRect!
  private var arrowShowPoint: CGPoint!

  public init() {
    super.init(frame: CGRectZero)
    self.backgroundColor = UIColor.clearColor()
  }

  public init(options: [PopoverOption]?) {
    super.init(frame: CGRectZero)
    self.backgroundColor = UIColor.clearColor()
    self.setOptions(options)
  }

  public init(showHandler: (() -> ())?, dismissHandler: (() -> ())?) {
    super.init(frame: CGRectZero)
    self.backgroundColor = UIColor.clearColor()
    self.didShowHandler = showHandler
    self.didDismissHandler = dismissHandler
  }

  public init(options: [PopoverOption]?, showHandler: (() -> ())?, dismissHandler: (() -> ())?) {
    super.init(frame: CGRectZero)
    self.backgroundColor = UIColor.clearColor()
    self.setOptions(options)
    self.didShowHandler = showHandler
    self.didDismissHandler = dismissHandler
  }

  private func setOptions(options: [PopoverOption]?){
    if let options = options {
      for option in options {
        switch option {
        case let .ArrowSize(value):
          self.arrowSize = value
        case let .AnimationIn(value):
          self.animationIn = value
        case let .AnimationOut(value):
          self.animationOut = value
        case let .CornerRadius(value):
          self.cornerRadius = value
        case let .SideEdge(value):
          self.sideEdge = value
        case let .BlackOverlayColor(value):
          self.blackOverlayColor = value
        case let .OverlayBlur(style):
          self.overlayBlur = UIBlurEffect(style: style)
        case let .Type(value):
          self.popoverType = value
        case let .Color(value):
          self.popoverColor = value
        }
      }
    }
  }

  required public init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  public func show(contentView: UIView, fromView: UIView) {
    self.show(contentView, fromView: fromView, inView: UIApplication.sharedApplication().keyWindow!)
  }

  public func show(contentView: UIView, fromView: UIView, inView: UIView) {
    let point: CGPoint
    switch self.popoverType {
    case .Up:
      point = CGPoint(x: fromView.frame.origin.x + (fromView.frame.size.width / 2), y: fromView.frame.origin.y)
    case .Down:
      point = CGPoint(x: fromView.frame.origin.x + (fromView.frame.size.width / 2), y: fromView.frame.origin.y + fromView.frame.size.height)
    }
    self.show(contentView, point: point, inView: inView)
  }

  public func show(contentView: UIView, point: CGPoint) {
    self.show(contentView, point: point, inView: UIApplication.sharedApplication().keyWindow!)
  }

  public func show(contentView: UIView, point: CGPoint, inView: UIView) {
    self.blackOverlay.frame = inView.bounds

    if let overlayBlur = self.overlayBlur {
      let effectView = UIVisualEffectView(effect: overlayBlur)
      effectView.frame = self.blackOverlay.bounds
      effectView.userInteractionEnabled = false
      self.blackOverlay.addSubview(effectView)
    } else {
      self.blackOverlay.backgroundColor = self.blackOverlayColor
      self.blackOverlay.alpha = 0
    }

    inView.addSubview(self.blackOverlay)
    self.blackOverlay.snp_updateConstraints { [unowned inView] make in
        make.edges.equalTo(inView);
    }
    self.blackOverlay.addTarget(self, action: "dismiss", forControlEvents: .TouchUpInside)

    self.containerView = inView
    self.contentView = contentView
    self.contentView.backgroundColor = UIColor.clearColor()
    self.contentView.layer.cornerRadius = self.cornerRadius
    self.contentView.layer.masksToBounds = true
    self.arrowShowPoint = point
    self.show()
  }

  private func show() {
    self.setNeedsDisplay()
    
    self.addSubview(self.contentView)
    self.containerView.addSubview(self)
    
    self.contentView.snp_updateConstraints { [unowned self] make in
        switch self.popoverType {
        case .Up:
            make.top.equalTo(self);
            make.bottom.equalTo(self).offset(-self.arrowSize.height);
        case .Down:
            make.top.equalTo(self).offset(self.arrowSize.height);
            make.bottom.equalTo(self);
        }
        make.leading.trailing.equalTo(self);
    }
    self.snp_updateConstraints { [unowned self] make in
        make.centerX.equalTo(-10);
        switch self.popoverType {
        case .Up:
            make.bottom.equalTo(self.arrowShowPoint.y - self.containerView.bounds.size.height);
        case .Down:
            make.top.equalTo(self.arrowShowPoint.y);
        }
    }

    self.transform = CGAffineTransformMakeScale(0.0, 0.0)
    UIView.animateWithDuration(self.animationIn, delay: 0,
      usingSpringWithDamping: 0.7,
      initialSpringVelocity: 3,
      options: .CurveEaseInOut,
      animations: {
        self.transform = CGAffineTransformIdentity
      }){ _ in
        self.didShowHandler?()
    }
    UIView.animateWithDuration(self.animationIn / 3,
      delay: 0,
      options: .CurveLinear,
      animations: { () -> Void in
        self.blackOverlay.alpha = 1
      }, completion: { (_) -> Void in
    })
  }

  public func dismiss() {
    if self.superview != nil {
      UIView.animateWithDuration(self.animationOut, delay: 0,
        options: .CurveEaseInOut,
        animations: {
          self.transform = CGAffineTransformMakeScale(0.0001, 0.0001)
          self.blackOverlay.alpha = 0
        }){ _ in
          self.contentView.removeFromSuperview()
          self.blackOverlay.removeFromSuperview()
          self.removeFromSuperview()
          self.didDismissHandler?()
      }
    }
  }

  override public func drawRect(rect: CGRect) {
    super.drawRect(rect)
    let arrow = UIBezierPath()
    let color = self.popoverColor
    let arrowPoint = self.containerView.convertPoint(self.arrowShowPoint, toView: self)
    switch self.popoverType {
    case .Up:
      arrow.moveToPoint(CGPoint(x: arrowPoint.x, y: self.bounds.height))
      arrow.addLineToPoint(
        CGPoint(
          x: arrowPoint.x - self.arrowSize.width * 0.5,
          y: isCornerLeftArrow() ? self.arrowSize.height : self.bounds.height - self.arrowSize.height
        )
      )

      arrow.addLineToPoint(CGPoint(x: self.cornerRadius, y: self.bounds.height - self.arrowSize.height))
      arrow.addArcWithCenter(
        CGPoint(
          x: self.cornerRadius,
          y: self.bounds.height - self.arrowSize.height - self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(90),
        endAngle: self.radians(180),
        clockwise: true)

      arrow.addLineToPoint(CGPoint(x: 0, y: self.cornerRadius))
      arrow.addArcWithCenter(
        CGPoint(
          x: self.cornerRadius,
          y: self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(180),
        endAngle: self.radians(270),
        clockwise: true)

      arrow.addLineToPoint(CGPoint(x: self.bounds.width - self.cornerRadius, y: 0))
      arrow.addArcWithCenter(
        CGPoint(
          x: self.bounds.width - self.cornerRadius,
          y: self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(270),
        endAngle: self.radians(0),
        clockwise: true)

      arrow.addLineToPoint(CGPoint(x: self.bounds.width, y: self.bounds.height - self.arrowSize.height - self.cornerRadius))
      arrow.addArcWithCenter(
        CGPoint(
          x: self.bounds.width - self.cornerRadius,
          y: self.bounds.height - self.arrowSize.height - self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(0),
        endAngle: self.radians(90),
        clockwise: true)

      arrow.addLineToPoint(CGPoint(x: arrowPoint.x + self.arrowSize.width * 0.5,
        y: isCornerRightArrow() ? self.arrowSize.height : self.bounds.height - self.arrowSize.height))

    case .Down:
      arrow.moveToPoint(CGPoint(x: arrowPoint.x, y: 0))
      arrow.addLineToPoint(
        CGPoint(
          x: arrowPoint.x + self.arrowSize.width * 0.5,
          y: isCornerRightArrow() ? self.arrowSize.height + self.bounds.height : self.arrowSize.height
        ))

      arrow.addLineToPoint(CGPoint(x: self.bounds.width - self.cornerRadius, y: self.arrowSize.height))
      arrow.addArcWithCenter(
        CGPoint(
          x: self.bounds.width - self.cornerRadius,
          y: self.arrowSize.height + self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(270.0),
        endAngle: self.radians(0),
        clockwise: true)

      arrow.addLineToPoint(CGPoint(x: self.bounds.width, y: self.bounds.height - self.cornerRadius))
      arrow.addArcWithCenter(
        CGPoint(
          x: self.bounds.width - self.cornerRadius,
          y: self.bounds.height - self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(0),
        endAngle: self.radians(90),
        clockwise: true)

      arrow.addLineToPoint(CGPoint(x: 0, y: self.bounds.height))
      arrow.addArcWithCenter(
        CGPoint(
          x: self.cornerRadius,
          y: self.bounds.height - self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(90),
        endAngle: self.radians(180),
        clockwise: true)

      arrow.addLineToPoint(CGPoint(x: 0, y: self.arrowSize.height + self.cornerRadius))
      arrow.addArcWithCenter(
        CGPoint(x: self.cornerRadius,
          y: self.arrowSize.height + self.cornerRadius
        ),
        radius: self.cornerRadius,
        startAngle: self.radians(180),
        endAngle: self.radians(270),
        clockwise: true)

      arrow.addLineToPoint(CGPoint(x: arrowPoint.x - self.arrowSize.width * 0.5,
        y: isCornerLeftArrow() ? self.arrowSize.height + self.bounds.height : self.arrowSize.height))
    }

    color.setFill()
    arrow.fill()
  }

  private func isCornerLeftArrow() -> Bool {
    return self.arrowShowPoint.x == self.frame.origin.x
  }

  private func isCornerRightArrow() -> Bool {
    return self.arrowShowPoint.x == self.frame.origin.x + self.bounds.width
  }

  private func radians(degrees: CGFloat) -> CGFloat {
    return (CGFloat(M_PI) * degrees / 180)
  }
}