//
//  QuadTreeNode.swift
// BentoMap
//
//  Created by Michael Skiba on 2/17/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

import Foundation

public protocol BentoCoordinate {

    /// The horizontal location of the coordinate
    var coordX: CGFloat { get set }

    /// The vertical location of the coordinate
    var coordY: CGFloat { get set }

    init(coordX: CGFloat, coordY: CGFloat)
}

public protocol BentoRect {

    /// The horizontal max of the rectangle.
    var maxXFloat: CGFloat { get }

    /// The vertical max of the rectangle.
    var maxYFloat: CGFloat { get }

    /// The horizontal min of the rectangle.
    var minXFloat: CGFloat { get }

    /// The vertical min of the rectangle.
    var minYFloat: CGFloat { get }
    
    /**
     A test to determine if this rectangle contains
     a given coordinate.

     - parameter c: a coordinate.

     - returns: a Bool indicating whether this rectangle contains the coordinate passed in.
     */
    func containsCoordinate(_ c: BentoCoordinate) -> Bool

    /**
     Divides this rectangle at a given percentage
     on the axis of the supplied edge.

     - parameter percent: the percentage at which to divide this rectangle.
     - parameter edge:    the edge from which to divide this rectangle.

     - returns: a tuple containing a rectangle that is the percentage requested,
     and a rectangle that is the remainder.
     */
    func divide(_ percent: CGFloat, edge: CGRectEdge) -> (Self, Self)

    /**
     *  Computes the geometric union of this rectangle with the supplied rectangle.
     *
     * - parameter other: a rectangle.
     */
    func unionWith(_ other: Self) -> Self

    init(originCoordinate: BentoCoordinate, size: CGSize)
}

public struct QuadTreeNode<NodeData, Coordinate: BentoCoordinate> {

    /// The location of this node in the map's coordinate space.
    public var originCoordinate: Coordinate

    /// The data associated with this node.
    public var content: NodeData

    public init(originCoordinate: Coordinate, content: NodeData) {
        self.originCoordinate = originCoordinate
        self.content = content
    }

}

public protocol CoordinateProvider {

    /// The type of coordinate associated with the conforming object.
    associatedtype CoordinateType: BentoCoordinate

    /// The coordinate associated with the conforming object.
    var coordinate: CoordinateType { get }

}

extension QuadTreeNode: CoordinateProvider {

    public typealias CoordinateType = Coordinate

    /// The origin coordinate of the QuadTree.
    public var coordinate: Coordinate {
        return originCoordinate
    }

}
