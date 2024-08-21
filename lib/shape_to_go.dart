library shape_to_go;

import 'dart:math';
import 'package:flutter/material.dart';

class Potter extends CustomClipper<Path> {
  /// List of points that [Potter] will follow.
  /// 
  /// Must provide at least 3 points, It automatically closes the shape,
  /// Don't have to provide the first point again at the end.
  /// 
  /// You can use one of these classes to specify where you want 
  /// the point to be:
  /// 
  /// * [TopLeftEdge]
  /// * [TopCenterEdge]
  /// * [TopRightEdge]
  /// * [CenterRightEdge]
  /// * [BottomRightEdge]
  /// * [BottomCenterEdge]
  /// * [BottomLeftEdge]
  /// * [CenterLeftEdge]
  /// * [CenterPoint]
  /// * [PointOnTopSide]
  /// * [PointOnRightSide]
  /// * [PointOnBottomSide]
  /// * [PointOnLeftSide]
  /// * [PointOnShap]
  /// * [EdgePoint]
  final List<Edge> points;

  /// The radius of a circular border that will apply to all
  /// edges.
  ///
  final double radius;

  /// Creates a [CustomClipper<Path>].
  const Potter({super.reclip, required this.points, this.radius = 20}): assert(points.length>2);

  @override
  Path getClip(Size size) {
    final Path path = Path();
    for (int i = 0; i < points.length; i++) {
      Point<double> previousPoint = _getPoint(points[(i - 1) % points.length], size);
      Point<double> currentPoint = _getPoint(points[i], size);
      Point<double> nextPoint = _getPoint(points[(i + 1) % points.length], size);
      Point<double> u1 = (previousPoint - currentPoint) *(1/
          sqrt(pow((previousPoint.x - currentPoint.x), 2) +
              pow((previousPoint.y - currentPoint.y), 2)));
      Point<double> u2 = (nextPoint - currentPoint) * ( 1 /
          sqrt(pow((nextPoint.x - currentPoint.x), 2) +
              pow((nextPoint.y - currentPoint.y), 2)));
      Point<double> p1 =
          Point<double>(currentPoint.x + radius * u1.x, currentPoint.y + radius * u1.y);
      Point<double> p2 =
          Point<double>(currentPoint.x + radius * u2.x, currentPoint.y + radius * u2.y);

      i == 0 ? path.moveTo(p1.x, p1.y) : path.lineTo(p1.x, p1.y);

      path.quadraticBezierTo(currentPoint.x, currentPoint.y, p2.x, p2.y);
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

Point<double> _getPoint(Edge edge, Size size) {
  final width = size.width;
  final height = size.height;
  if (edge is TopLeftEdge) {
    return const Point<double>(0, 0);
  }
  if (edge is TopCenterEdge) {
    return Point<double>(width / 2, 0);
  }
  if (edge is TopRightEdge) {
    return Point<double>(width, 0);
  }
  if (edge is CenterRightEdge) {
    return Point<double>(width, height / 2);
  }
  if (edge is BottomRightEdge) {
    return Point<double>(width, height);
  }
  if (edge is BottomCenterEdge) {
    return Point<double>(width / 2, height);
  }
  if (edge is BottomLeftEdge) {
    return Point<double>(0, height);
  }
  if (edge is CenterLeftEdge) {
    return Point<double>(0, height / 2);
  }
  if (edge is CenterPoint) {
    return Point<double>(width / 2, height / 2);
  }
  if (edge is PointOnTopSide) {
    return Point<double>(width / edge.divider, 0);
  }
  if (edge is PointOnRightSide) {
    return Point<double>(width, height / edge.divider);
  }
  if (edge is PointOnBottomSide) {
    return Point<double>(width / edge.divider, height);
  }
  if (edge is PointOnLeftSide) {
    return Point<double>(0, height / edge.divider);
  }
  if (edge is PointOnShap) {
    return Point<double>(width / edge.xDivider, height / edge.yDivider);
  }
  if (edge is EdgePoint) {
    return Point<double>(edge.x, edge.y);
  } else {
    return const Point<double>(0, 0);
  }
}

abstract class Edge {
  const Edge();
}

class EdgePoint extends Point<double> implements Edge {
  /// Creates a point on (x,y).
  const EdgePoint(super.x, super.y);
}

class TopLeftEdge extends Edge {
  /// Creates a point on the Top Left Corner.
  const TopLeftEdge();
}

class TopCenterEdge extends Edge {
  /// Creates a point on the Top Center Point.
  const TopCenterEdge();
}

class TopRightEdge extends Edge {
  /// Creates a point on the Top Right Corner.
  const TopRightEdge();
}

class CenterRightEdge extends Edge {
  /// Creates a point on the Center Right Point.
  const CenterRightEdge();
}

class BottomRightEdge extends Edge {
  /// Creates a point on the Bottom Right Corner.
  const BottomRightEdge();
}

class BottomCenterEdge extends Edge {
  /// Creates a point on the Bottom Center Point.
  const BottomCenterEdge();
}

class BottomLeftEdge extends Edge {
  /// Creates a point on the Bottom Left Corner.
  const BottomLeftEdge();
}

class CenterLeftEdge extends Edge {
  /// Creates a point on the Center Left Point.
  const CenterLeftEdge();
}

class CenterPoint extends Edge {
  /// Creates a point on the Center Point.
  const CenterPoint();
}

class PointOnTopSide extends Edge {
  final double divider;

  /// Creates a point on the Top side,
  /// where:
  /// 
  /// * x = width / [divider]
  /// * y = 0
  const PointOnTopSide({required this.divider});
}

class PointOnRightSide extends Edge {
  final double divider;

  /// Creates a point on the Right side,
  /// where:
  /// 
  /// * x = width
  /// * y = height / [divider]
  const PointOnRightSide({required this.divider});
}

class PointOnBottomSide extends Edge {
  final double divider;

  /// Creates a point on the Bottom side,
  /// where:
  /// 
  /// * x = width / [divider]
  /// * y = height
  const PointOnBottomSide({required this.divider});
}

class PointOnLeftSide extends Edge {
  final double divider;

  /// Creates a point on the Left side,
  /// where:
  /// 
  /// * x = 0
  /// * y = height / [divider]
  const PointOnLeftSide({required this.divider});
}

class PointOnShap extends Edge {
  final double xDivider;
  final double yDivider;

  /// Creates a point,
  /// where:
  /// 
  /// * x = width / [xDivider]
  /// * y = height / [yDivider]
  const PointOnShap({
    required this.xDivider,
    required this.yDivider,
  });
}
