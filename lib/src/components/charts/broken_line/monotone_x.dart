import 'dart:math';
import 'dart:ui';

class MonotoneX {
  static num sign(num x) {
    return x < 0 ? -1 : 1;
  }

  // Calculate a one-sided slope.
  static double slope2(double x0, double y0, double x1, double y1, double t) {
    var h = x1 - x0;
    return h != 0 ? (3 * (y1 - y0) / h - t) / 2 : t;
  }

  static double slope3(
      double x0, double y0, double x1, double y1, double x2, double y2) {
    double h0 = x1 - x0;
    double h1 = x2 - x1;
    double s0 = (y1 - y0) /
        (h0 != 0 ? h0 : (h1 < 0 ? -double.infinity : double.infinity));
    double s1 = (y2 - y1) /
        (h1 != 0 ? h1 : (h0 < 0 ? -double.infinity : double.infinity));
    double p = (s0 * h1 + s1 * h0) / (h0 + h1);
    var source = [s0.abs(), s1.abs(), 0.5 * p.abs()];
    source.sort();
    return (sign(s0) + sign(s1)) * source.first;
  }

  // According to https://en.wikipedia.org/wiki/Cubic_Hermite_spline#Representations
  // "you can express cubic Hermite interpolation in terms of cubic Bézier curves
  // with respect to the four values p0, p0 + m0 / 3, p1 - m1 / 3, p1".
  static Path point(Path path, double x0, double y0, double x1, double y1,
      double t0, double t1) {
    var dx = (x1 - x0) / 3;
    path.cubicTo(x0 + dx, y0 + dx * t0, x1 - dx, y1 - dx * t1, x1, y1);
    return path;
  }

  static Path addCurve(Path path, List<Point> points,
      {bool reversed = false, int endIndex = -1}) {
    var targetPoints = <Point<num>>[];
    targetPoints.addAll(points);
    targetPoints.add(Point(
        points[points.length - 1].x * 2, points[points.length - 1].y * 2));
    double? x0, y0, x1, y1, t0;
    List<List<double?>> arr = [];
    for (int i = 0; i < targetPoints.length; i++) {
      double? t1;
      double x = targetPoints[i].x as double;
      double y = targetPoints[i].y as double;
      if (x == x1 && y == y1) continue;
      switch (i) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          t1 = slope3(x0!, y0!, x1!, y1!, x, y);
          arr.add([x0, y0, x1, y1, slope2(x0, y0, x1, y1, t1), t1]);
          break;
        default:
          t1 = slope3(x0!, y0!, x1!, y1!, x, y);
          arr.add([x0, y0, x1, y1, t0, t1]);
      }
      x0 = x1;
      y0 = y1;
      x1 = x;
      y1 = y;
      t0 = t1;
    }
    int index = 0;
    if (reversed) {
      arr.reversed.forEach((f) {
        if (endIndex < 0 || index++ < endIndex) {
          point(path, f[2]!, f[3]!, f[0]!, f[1]!, f[5]!, f[4]!);
        }
      });
    } else {
      arr.forEach((f) {
        if (endIndex < 0 || index++ < endIndex) {
          point(path, f[0]!, f[1]!, f[2]!, f[3]!, f[4]!, f[5]!);
        }
      });
    }
    return path;
  }
}
