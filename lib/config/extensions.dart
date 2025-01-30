part of 'helper.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension AlignExtension on Widget {
  Widget align({AlignmentGeometry alignment = Alignment.center}) {
    return Align(
      alignment: alignment,
      child:
          this, // 'this' refers to the widget you're calling the extension on
    );
  }
}

extension MediaQueryValues on BuildContext {
  /// Gets the width of the screen.
  double get width => MediaQuery.of(this).size.width;

  /// Gets the height of the screen.
  double get height => MediaQuery.of(this).size.height;

  EdgeInsets get padding => MediaQuery.of(this).padding;
}
