import 'package:flutter/widgets.dart';
import 'package:responsive_grid/responsive_grid.dart';

export 'package:responsive_grid/responsive_grid.dart' show ResponsiveGridRow;

const double kDashboardGridSpacing = 24.0;

/// Wraps [ResponsiveGridCol] to provide a consistent gap between dashboard tiles.
class DashboardGridCol extends ResponsiveGridCol {
  DashboardGridCol({
    super.key,
    super.xs = 12,
    super.sm,
    super.md,
    super.lg,
    super.xl,
    required Widget child,
    double? spacing,
    EdgeInsets? padding,
  }) : super(
          child: Padding(
            padding: padding ??
                EdgeInsets.all((spacing ?? kDashboardGridSpacing) / 2),
            child: child,
          ),
        );
}
