library shape_to_go;

import 'dart:math';
import 'package:flutter/material.dart';

class Potter extends CustomClipper<Path> {

  /// Temp
  factory Potter.triangle({Radius? radius}) {
    return Potter(points: const [
      TopCenterCorner(),
      BottomRightCorner(),
      BottomLeftCorner(),
    ], radius: radius);
  }

  /// Temp
  factory Potter.messageShapeRight({Radius? radius}) {
    return Potter(points: const [
      PointOnTopSide(divider: 6),
      TopRightCorner(),
      BottomRightCorner(),
      PointOnBottomSide(divider: 6),
      PointOnShap(xDivider: 6, yDivider: 3 / 2),
      CenterLeftCorner(),
      PointOnShap(xDivider: 6, yDivider: 3),
    ], radius: radius);
  }

  /// List of points that [Potter] will follow.
  ///
  /// Must provide at least 3 points, It automatically closes the shape,
  /// Don't have to provide the first point again at the end.
  ///
  /// You can use one of these classes to specify where you want
  /// the point to be:
  ///
  /// * [TopLeftCorner]
  /// * [TopCenterCorner]
  /// * [TopRightCorner]
  /// * [CenterRightCorner]
  /// * [BottomRightCorner]
  /// * [BottomCenterCorner]
  /// * [BottomLeftCorner]
  /// * [CenterLeftCorner]
  /// * [CenterPoint]
  /// * [PointOnTopSide]
  /// * [PointOnRightSide]
  /// * [PointOnBottomSide]
  /// * [PointOnLeftSide]
  /// * [PointOnShap]
  /// * [CornerPoint]
  final List<Corner> points;

  /// If [radius] is provided in a [Corner] (point) this [raduis] wouldn't apply
  /// to that [Corner] (point).
  final Radius? radius;

  /// Creates a [CustomClipper<Path>] with the specified points and radius.
  const Potter({super.reclip, required this.points, this.radius})
      : assert(points.length > 2);

  @override
  Path getClip(Size size) {
    final Path path = Path();

    for (int i = 0; i < points.length; i++) {

      double xr = points[i].radius?.x ?? (radius?.x ?? 0);
      double yr = points[i].radius?.y ?? (radius?.y ?? 0);

      Point<double> previousPoint =
          _getPoint(points[(i - 1) % points.length], size);
      Point<double> currentPoint = _getPoint(points[i], size);
      Point<double> nextPoint =
          _getPoint(points[(i + 1) % points.length], size);
      Point<double> u1 = (previousPoint - currentPoint) *
          (1 /
              sqrt(pow((previousPoint.x - currentPoint.x), 2) +
                  pow((previousPoint.y - currentPoint.y), 2)));
      Point<double> u2 = (nextPoint - currentPoint) *
          (1 /
              sqrt(pow((nextPoint.x - currentPoint.x), 2) +
                  pow((nextPoint.y - currentPoint.y), 2)));
      Point<double> p1 =
          Point<double>(currentPoint.x + xr * u1.x, currentPoint.y + yr * u1.y);
      Point<double> p2 =
          Point<double>(currentPoint.x + xr * u2.x, currentPoint.y + yr * u2.y);

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

Point<double> _getPoint(Corner corner, Size size) {
  final width = size.width;
  final height = size.height;
  if (corner is TopLeftCorner) {
    return const Point<double>(0, 0);
  }
  if (corner is TopCenterCorner) {
    return Point<double>(width / 2, 0);
  }
  if (corner is TopRightCorner) {
    return Point<double>(width, 0);
  }
  if (corner is CenterRightCorner) {
    return Point<double>(width, height / 2);
  }
  if (corner is BottomRightCorner) {
    return Point<double>(width, height);
  }
  if (corner is BottomCenterCorner) {
    return Point<double>(width / 2, height);
  }
  if (corner is BottomLeftCorner) {
    return Point<double>(0, height);
  }
  if (corner is CenterLeftCorner) {
    return Point<double>(0, height / 2);
  }
  if (corner is CenterPoint) {
    return Point<double>(width / 2, height / 2);
  }
  if (corner is PointOnTopSide) {
    return Point<double>(width / corner.divider, 0);
  }
  if (corner is PointOnRightSide) {
    return Point<double>(width, height / corner.divider);
  }
  if (corner is PointOnBottomSide) {
    return Point<double>(width / corner.divider, height);
  }
  if (corner is PointOnLeftSide) {
    return Point<double>(0, height / corner.divider);
  }
  if (corner is PointOnShap) {
    return Point<double>(width / corner.xDivider, height / corner.yDivider);
  }
  if (corner is CornerPoint) {
    return Point<double>(corner.x, corner.y);
  } else {
    return const Point<double>(0, 0);
  }
}

class Corner {
  final Radius? radius;

  const Corner({this.radius});
}

class CornerPoint extends Point<double> implements Corner {
  @override
  final Radius? radius;

  /// Creates a point on (x,y).
  const CornerPoint({required double x, required double y, this.radius})
      : super(x, y);
}

class TopLeftCorner extends Corner {
  /// Creates a point on the Top Left Corner.
  const TopLeftCorner({super.radius});
}

class TopCenterCorner extends Corner {
  /// Creates a point on the Top Center Point.
  const TopCenterCorner({super.radius});
}

class TopRightCorner extends Corner {
  /// Creates a point on the Top Right Corner.
  const TopRightCorner({super.radius});
}

class CenterRightCorner extends Corner {
  /// Creates a point on the Center Right Point.
  const CenterRightCorner({super.radius});
}

class BottomRightCorner extends Corner {
  /// Creates a point on the Bottom Right Corner.
  const BottomRightCorner({super.radius});
}

class BottomCenterCorner extends Corner {
  /// Creates a point on the Bottom Center Point.
  const BottomCenterCorner({super.radius});
}

class BottomLeftCorner extends Corner {
  /// Creates a point on the Bottom Left Corner.
  const BottomLeftCorner({super.radius});
}

class CenterLeftCorner extends Corner {
  /// Creates a point on the Center Left Point.
  const CenterLeftCorner({super.radius});
}

class CenterPoint extends Corner {
  /// Creates a point on the Center Point.
  const CenterPoint({super.radius});
}

class PointOnTopSide extends Corner {
  final double divider;

  /// Creates a point on the Top side,
  /// where:
  ///
  /// * x = width / [divider]
  /// * y = 0
  const PointOnTopSide({required this.divider, super.radius});
}

class PointOnRightSide extends Corner {
  final double divider;

  /// Creates a point on the Right side,
  /// where:
  ///
  /// * x = width
  /// * y = height / [divider]
  const PointOnRightSide({required this.divider, super.radius});
}

class PointOnBottomSide extends Corner {
  final double divider;

  /// Creates a point on the Bottom side,
  /// where:
  ///
  /// * x = width / [divider]
  /// * y = height
  const PointOnBottomSide({required this.divider, super.radius});
}

class PointOnLeftSide extends Corner {
  final double divider;

  /// Creates a point on the Left side,
  /// where:
  ///
  /// * x = 0
  /// * y = height / [divider]
  const PointOnLeftSide({required this.divider, super.radius});
}

class PointOnShap extends Corner {
  final double xDivider;
  final double yDivider;

  /// Creates a point,
  /// where:
  ///
  /// * x = width / [xDivider]
  /// * y = height / [yDivider]
  const PointOnShap(
      {required this.xDivider, required this.yDivider, super.radius});
}
