import UIKit


public extension Array where Element: NSLayoutConstraint {
    @discardableResult
    func activate() -> [NSLayoutConstraint] {
        NSLayoutConstraint.activate(self)
        return self
    }
    
    @discardableResult
    func deactivate() -> [NSLayoutConstraint] {
        NSLayoutConstraint.deactivate(self)
        return self
    }
}



// MARK: - LayoutAnchor Wrappers

public extension UIView {
    var height:   NSLayoutDimension { return heightAnchor }
    var width:    NSLayoutDimension { return widthAnchor }
    
    var leading:  NSLayoutXAxisAnchor { return leadingAnchor }
    var trailing: NSLayoutXAxisAnchor { return trailingAnchor }
    var centerX:  NSLayoutXAxisAnchor { return centerXAnchor }
    
    var top:      NSLayoutYAxisAnchor { return topAnchor }
    var bottom:   NSLayoutYAxisAnchor { return bottomAnchor }
    var centerY:  NSLayoutYAxisAnchor { return centerYAnchor }
    
    var marginsGuide: UILayoutGuide { return layoutMarginsGuide }
    
    var firstBaseLine: NSLayoutYAxisAnchor { return firstBaselineAnchor }
    var lastBaseline: NSLayoutYAxisAnchor { return lastBaselineAnchor }
    
}

public extension UILayoutGuide {
    var height:   NSLayoutDimension { return heightAnchor }
    var width:    NSLayoutDimension { return widthAnchor }
    
    var leading:  NSLayoutXAxisAnchor { return leadingAnchor }
    var trailing: NSLayoutXAxisAnchor { return trailingAnchor }
    var centerX:  NSLayoutXAxisAnchor { return centerXAnchor }
    
    var top:      NSLayoutYAxisAnchor { return topAnchor }
    var bottom:   NSLayoutYAxisAnchor { return bottomAnchor }
    var centerY:  NSLayoutYAxisAnchor { return centerYAnchor }
}

public extension UIViewController {
    var bottomGuide: NSLayoutYAxisAnchor { return bottomLayoutGuide.topAnchor }
    var topGuide: NSLayoutYAxisAnchor { return topLayoutGuide.bottomAnchor }
}

// MARK: - Layout Operators

// MARK: anchor = anchor

@discardableResult
public func === (left: NSLayoutDimension, right: NSLayoutDimension) -> NSLayoutConstraint {
    let c = left.constraint(equalTo: right); c.isActive = true; return c
}
@discardableResult
public func === (left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor) -> NSLayoutConstraint {
    let c = left.constraint(equalTo: right); c.isActive = true; return c
}
@discardableResult
public func === (left: NSLayoutYAxisAnchor, right: NSLayoutYAxisAnchor) -> NSLayoutConstraint {
    let c = left.constraint(equalTo: right); c.isActive = true; return c
}


// MARK: anchor = constant

@discardableResult
public func === (left: NSLayoutDimension, right: CGFloat)  -> NSLayoutConstraint {
    let c = left.constraint(equalToConstant: right); c.isActive = true; return c
}


// MARK: anchor = anchor + constant

@discardableResult
public func === (left: NSLayoutDimension, right: (anchor: NSLayoutDimension, constant: CGFloat)) -> NSLayoutConstraint {
    let c = left.constraint(equalTo: right.anchor, constant: right.constant); c.isActive = true; return c
}
@discardableResult
public func === (left: NSLayoutXAxisAnchor, right: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)) -> NSLayoutConstraint {
    let c = left.constraint(equalTo: right.anchor, constant: right.constant); c.isActive = true; return c
}
@discardableResult
public func === (left: NSLayoutYAxisAnchor, right: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)) -> NSLayoutConstraint {
    let c = left.constraint(equalTo: right.anchor, constant: right.constant); c.isActive = true; return c
}


// MARK: dimension = dimension * multiplier
public struct LayoutDimensionMultiplication {
    let dimension: NSLayoutDimension
    let multiplier: CGFloat
}
public func * (dimension: NSLayoutDimension, multiplier: CGFloat) -> LayoutDimensionMultiplication {
    return LayoutDimensionMultiplication(dimension: dimension, multiplier: multiplier)
}
@discardableResult
public func === (left: NSLayoutDimension, right: LayoutDimensionMultiplication) -> NSLayoutConstraint {
    let c = left.constraint(equalTo: right.dimension, multiplier: right.multiplier); c.isActive = true; return c
}


// MARK: `+`  anchor + constant

public func + (anchor: NSLayoutDimension, constant: CGFloat) -> (NSLayoutDimension , CGFloat) { return (anchor, constant) }
public func + (anchor: NSLayoutXAxisAnchor, constant: CGFloat) -> (NSLayoutXAxisAnchor , CGFloat) { return (anchor, constant) }
public func + (anchor: NSLayoutYAxisAnchor, constant: CGFloat) -> (NSLayoutYAxisAnchor , CGFloat) { return (anchor, constant) }


// MARK: `-`  anchor - constant

public func - (anchor: NSLayoutDimension, constant: CGFloat) -> (NSLayoutDimension, CGFloat) { return (anchor, -constant) }
public func - (anchor: NSLayoutXAxisAnchor, constant: CGFloat) -> (NSLayoutXAxisAnchor, CGFloat) { return (anchor, -constant) }
public func - (anchor: NSLayoutYAxisAnchor, constant: CGFloat) -> (NSLayoutYAxisAnchor, CGFloat) { return (anchor, -constant) }



// MARK: `>==` Operators
infix operator >==: ComparisonPrecedence

/* anchor >== constant */
@discardableResult
public func >== (dimension: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
    let c = dimension.constraint(greaterThanOrEqualToConstant: constant); c.isActive = true; return c
}

/* anchor >== anchor +/- constant */
@discardableResult
public func >== (left: NSLayoutDimension, right: (anchor: NSLayoutDimension, constant: CGFloat)) -> NSLayoutConstraint {
    let c = left.constraint(greaterThanOrEqualTo: right.anchor, constant: right.constant); c.isActive = true; return c
}
@discardableResult
public func >== (left: NSLayoutXAxisAnchor, right: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)) -> NSLayoutConstraint {
    let c = left.constraint(greaterThanOrEqualTo: right.anchor, constant: right.constant); c.isActive = true; return c
}
@discardableResult
public func >== (left: NSLayoutYAxisAnchor, right: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)) -> NSLayoutConstraint {
    let c = left.constraint(greaterThanOrEqualTo: right.anchor, constant: right.constant); c.isActive = true; return c
}


// MARK: - `<==` Operators
infix operator <==: ComparisonPrecedence

/* anchor <== constant */
@discardableResult
public func <== (dimension: NSLayoutDimension, constant: CGFloat) -> NSLayoutConstraint {
    let c = dimension.constraint(lessThanOrEqualToConstant: constant); c.isActive = true; return c
}

/* anchor <== anchor +/- constant */
@discardableResult
public func <== (left: NSLayoutDimension, right: (anchor: NSLayoutDimension, constant: CGFloat)) -> NSLayoutConstraint {
    let c = left.constraint(lessThanOrEqualTo: right.anchor, constant: right.constant); c.isActive = true; return c
}
@discardableResult
public func <== (left: NSLayoutXAxisAnchor, right: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)) -> NSLayoutConstraint {
    let c = left.constraint(lessThanOrEqualTo: right.anchor, constant: right.constant); c.isActive = true; return c
}
@discardableResult
public func <== (left: NSLayoutYAxisAnchor, right: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)) -> NSLayoutConstraint {
    let c = left.constraint(lessThanOrEqualTo: right.anchor, constant: right.constant); c.isActive = true; return c
}
