// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart'; 
 

/// by Azkadev
class AzkadevDialogFlutter {
  /// by Azkadev
  static Widget titleWidget({
    required Widget leading,
    required Widget title,
    required Widget trailing,
  }) {
    return Padding(
      padding: EdgeInsetsGeometry.all(1.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading,
          title,
          trailing,
        ],
      ),
    );
  }

  /// by Azkadev
  static Widget titleSimpleWidget({
    required BuildContext context,
    required String title,
  }) {
    final themeData = Theme.of(context);
    return titleWidget(
      leading: IgnorePointer(
        child: Opacity(
          opacity: 0,
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.close,
            ),
          ),
        ),
      ),
      title: Text(
        title.trim(),
        style: themeData.textTheme.titleMedium,
      ),
      trailing: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.close,
        ),
      ),
    );
  }

  ///
  static void showDialogWidget({
    required BuildContext context,
    required WidgetBuilder builder,
  }) {
    showGeneralDialog(
      context: context,
      // barrierDismissible: true,
      pageBuilder: (context, animation, secondaryAnimation) {
        final ThemeData themeData = Theme.of(context);
        final MediaQueryData mediaQueryData = MediaQuery.of(context);
        final margin = EdgeInsets.all(20);
        return SimpleContainerWidget(
          color: themeData.scaffoldBackgroundColor,
          margin: margin.copyWith(
            top: margin.top + mediaQueryData.padding.top, 
            bottom: margin.bottom + mediaQueryData.padding.bottom, 
          ),
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: builder(
              context,
            ),
          ),
        );
      },
    );
  }
}

/// By Azkadev

class SimpleContainerWidget extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? width;
  final double? height;

  /// By Azkadev
  final Widget child;

  /// By Azkadev

  const SimpleContainerWidget({
    super.key,
    this.color,
    this.margin,
    this.height,
    this.width,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? themeData.splashColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: themeData.dividerColor,
          width: 1.0,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}

/// By Azkadev

class SimpleButtonWidget extends StatelessWidget {
  /// By Azkadev

  final String title;

  /// By Azkadev

  final void Function()? onPressed;

  /// By Azkadev

  const SimpleButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return SimpleContainerWidget(
      margin: EdgeInsets.all(
        5,
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.standard,
        onPressed: onPressed,
        minWidth: mediaQueryData.size.width,
        clipBehavior: Clip.antiAlias,
        child: Text(title),
      ),
    );
  }
}
