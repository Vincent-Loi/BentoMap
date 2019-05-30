//
//  QuadTree+sampleMapData.swift
// BentoMap
//
//  Created by Michael Skiba on 7/6/16.
//  Copyright © 2016 Raizlabs. All rights reserved.
//

import Foundation
import MapKit
import BentoMap

extension QuadTree {

    static var sampleData: QuadTree<Int, MKMapRect, MKMapPoint> {
        var samples = QuadTree<Int, MKMapRect, MKMapPoint>(bentoBox: BentoBox(minPoint: MKMapPoint(CLLocationCoordinate2D.minCoord), maxPoint: MKMapPoint(CLLocationCoordinate2D.maxCoord)), bucketCapacity: 5)
        let randomData = (1...5000).map { count in
            return QuadTreeNode(originCoordinate: MKMapPoint(CLLocationCoordinate2D.randomCoordinate()), content: count)
        }
        for node in randomData {
            samples.insertNode(node)
        }
        return samples
    }

    static func sampleGridData(forContainerRect containerRect: CGRect) -> QuadTree<Int, CGRect, CGPoint> {
        let minPoint = CGPoint(x: containerRect.minX, y: containerRect.minY)
        let maxPoint = CGPoint(x: containerRect.maxX, y: containerRect.maxY)
        var samples = QuadTree<Int, CGRect, CGPoint>(bentoBox: BentoBox(minPoint: minPoint, maxPoint: maxPoint), bucketCapacity: 5)
        let root = QuadTreeNode(originCoordinate: CGPoint.zero, content: 1000)
        samples.insertNode(root)
        for count in 1...500 {
            let node = QuadTreeNode(originCoordinate: CGPoint.randomPoint(withinRect: containerRect), content: count)
            samples.insertNode(node)
        }
        return samples
    }

}

private extension CGPoint {

    static func randomPoint(withinRect rect: CGRect) -> CGPoint {
        let x = Double.cappedRandom(min: Double(rect.minX), max: Double(rect.maxX))
        let y = Double.cappedRandom(min: Double(rect.minY), max: Double(rect.maxY))
        return CGPoint(x: x, y: y)
    }

}

private extension CLLocationCoordinate2D {
    enum Coordinates {
        static let bostonLatitude: Double = 42.3584300
        static let bostonLongitude: Double = -71.0597700
        static let adjustment: Double = 0.5
        static let minLatitude: Double =  Coordinates.bostonLatitude - Coordinates.adjustment
        static let minLongitude: Double = Coordinates.bostonLongitude - Coordinates.adjustment
        static let maxLatitude: Double = Coordinates.bostonLatitude + Coordinates.adjustment
        static let maxLongitude: Double = Coordinates.bostonLongitude + Coordinates.adjustment
    }

    static let minCoord = CLLocationCoordinate2D(latitude: Coordinates.minLatitude,
                                                 longitude: Coordinates.minLongitude)
    static let maxCoord = CLLocationCoordinate2D(latitude: Coordinates.maxLatitude,
                                                 longitude: Coordinates.maxLongitude)

    static func randomCoordinate() -> CLLocationCoordinate2D {
        let lat = Double.cappedRandom(min: Coordinates.minLatitude,
                                      max: Coordinates.maxLatitude)
        let long = Double.cappedRandom(min: Coordinates.minLongitude,
                                       max: Coordinates.maxLongitude)
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
}

private extension Double {
    static func cappedRandom(min minValue: Double, max maxValue: Double) -> Double {
        let exponent: Double = 10000.0
        let diff = UInt32(abs(minValue - maxValue) * exponent)
        let randomNumber = Double(arc4random_uniform(diff)) / exponent
        return min(minValue, maxValue) + randomNumber
    }
}
