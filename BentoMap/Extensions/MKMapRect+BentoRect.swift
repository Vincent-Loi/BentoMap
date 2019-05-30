//
//  MKMapRect+BentoRect.swift
// BentoMap
//
//  Created by Matthew Buckley on 8/27/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

import Foundation
import MapKit

extension MKMapRect: BentoRect {

    public var minXFloat: CGFloat {
        return CGFloat(minX)
    }

    public var minYFloat: CGFloat {
        return CGFloat(minY)
    }

    public var maxXFloat: CGFloat {
        return CGFloat(maxX)
    }

    public var maxYFloat: CGFloat {
        return CGFloat(maxY)
    }

    public func containsCoordinate(_ c: BentoCoordinate) -> Bool {
        let originCoordinate = MKMapPoint(x: Double(c.coordX), y: Double(c.coordY))
        return contains(originCoordinate)
    }

    public func divide(_ percent: CGFloat, edge: CGRectEdge) -> (MKMapRect, MKMapRect) {
        let amount: Double
        switch edge {
        case .maxXEdge, .minXEdge:
            amount = size.width / 2.0
        case .maxYEdge, .minYEdge:
            amount = size.height / 2.0
        }

        let slice = UnsafeMutablePointer<MKMapRect>.allocate(capacity: 1)
        defer {
            slice.deallocate()
        }
        let remainder = UnsafeMutablePointer<MKMapRect>.allocate(capacity: 1)
        defer {
            remainder.deallocate()
        }
        MKMapRectDivide(self, slice, remainder, amount, edge)
        return (slice: slice[0], remainder: remainder[0])
    }

    public func unionWith(_ other: MKMapRect) -> MKMapRect {
        return union(other)
    }

    public init(originCoordinate origin: BentoCoordinate, size: CGSize) {
        self.init(origin: MKMapPoint(x: Double(origin.coordX), y: Double(origin.coordY)), size: MKMapSize(width: Double(size.width), height: Double(size.height)))
    }

}
