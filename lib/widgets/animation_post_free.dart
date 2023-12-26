library animation_post_free;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:loventine_flutter/values/app_color.dart';

const double _kBorderWidth = 2;
const double _kTextSpeed = 3;
const double _kBorderSpeed = 5;
const Offset _kCompactSizeFactor = Offset(0.5, 0.28);
const double _kIconSize = 24;
const double _kIconSizeFactor = 0.45;
const double _kImageHeightFactor = 0.7;
const double _kAnimationMaxScrollExtentFactor = 0.2;

class AnimationPostFree extends StatefulWidget {
  final Widget? image;
  final Widget? text;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double height;
  final double addItemWidth;
  final double itemMargin;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconBackgroundColor;
  final Color addItemBackgroundColor;
  final double borderRadius;
  final double iconSize;
  final Function? onPressedIcon;

  const AnimationPostFree({
    Key? key,
    this.image,
    this.text,
    required this.itemBuilder,
    required this.itemCount,
    this.height = 240,
    this.addItemWidth = 120,
    this.itemMargin = 8,
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.white,
    this.iconBackgroundColor = Colors.blue,
    this.addItemBackgroundColor = const Color(0xfff9f9fb),
    this.borderRadius = 16,
    this.iconSize = 24,
    this.onPressedIcon,
  }) : super(key: key);

  @override
  _AnimationPostFreeState createState() => _AnimationPostFreeState();
}

class _AnimationPostFreeState extends State<AnimationPostFree> {
  ScrollController? _scrollController;
  double _animationValue = 0.0;
  late AlignmentTween _addIconAlignmentTween, _addImageAlignmentTween;
  late SizeTween _addImageSizeTween,
      _addItemSizeTween,
      _addIconSizeTween,
      _addIconChildSizeTween;
  late BorderRadiusTween _addImageBorderRadiusTween,
      _addIconBorderRadiusTween,
      _addItemBorderRadiusTween;
  late EdgeInsetsTween _addIconMarginTween, _addItemPaddingTween;
  late ColorTween _addItemColorTween, _addItemBorderColorTween;

  @override
  void initState() {
    var compactSize = Size(widget.addItemWidth * _kCompactSizeFactor.dx,
        widget.height * _kCompactSizeFactor.dy);
    var iconSize = widget.addItemWidth * _kIconSizeFactor;
    var iconCompactSize = compactSize.width * _kIconSizeFactor;

    _addImageBorderRadiusTween = BorderRadiusTween(
      begin: BorderRadius.only(
        topLeft: Radius.circular(widget.borderRadius),
        topRight: Radius.circular(widget.borderRadius),
        bottomLeft: Radius.zero,
        bottomRight: Radius.zero,
      ),
      end: BorderRadius.circular(compactSize.height),
    );
    _addImageAlignmentTween = AlignmentTween(
      begin: Alignment.topCenter,
      end: Alignment.center,
    );
    _addIconAlignmentTween = AlignmentTween(
      begin: Alignment.bottomCenter,
      end: Alignment.bottomRight,
    );
    _addItemSizeTween = SizeTween(
      begin: Size(widget.addItemWidth, widget.height),
      end: Size(compactSize.height, compactSize.height),
    );
    _addImageSizeTween = SizeTween(
      begin: Size(widget.addItemWidth, widget.height * _kImageHeightFactor),
      end: Size(compactSize.height, compactSize.height),
    );
    _addIconSizeTween = SizeTween(
      begin: Size(iconSize, iconSize),
      end: Size(iconCompactSize, iconCompactSize),
    );
    _addIconChildSizeTween = SizeTween(
      begin: Size(_kIconSize, _kIconSize),
      end: Size(_kIconSize * _kIconSizeFactor, _kIconSize * _kIconSizeFactor),
    );
    _addIconBorderRadiusTween = BorderRadiusTween(
      begin: BorderRadius.circular(iconSize),
      end: BorderRadius.circular(iconCompactSize),
    );
    _addIconMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(
          bottom: math.max(
              0,
              widget.height -
                  _addImageSizeTween.begin!.height -
                  iconSize / 2 -
                  widget.itemMargin * 2 -
                  _kBorderWidth * 2)),
      end: EdgeInsets.zero,
    );
    _addItemBorderRadiusTween = BorderRadiusTween(
      begin: BorderRadius.circular(widget.borderRadius + _kBorderWidth),
      end: BorderRadius.only(
        topLeft: Radius.zero,
        bottomLeft: Radius.zero,
        topRight: Radius.circular(compactSize.height),
        bottomRight: Radius.circular(compactSize.height),
      ),
    );
    _addItemColorTween = ColorTween(
      begin: widget.addItemBackgroundColor,
      end: widget.backgroundColor,
    );
    _addItemBorderColorTween = ColorTween(
      begin: widget.borderColor,
      end: widget.backgroundColor,
    );
    _addItemPaddingTween = EdgeInsetsTween(
      begin: EdgeInsets.only(
          left: widget.itemMargin,
          top: widget.itemMargin,
          bottom: widget.itemMargin),
      end: EdgeInsets.zero,
    );

    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      var offset = _scrollController!.offset;
      var _addItemAnimationMaxOffset =
          _scrollController!.position.maxScrollExtent *
              _kAnimationMaxScrollExtentFactor;
      _animationValue =
          math.min(1, math.max(0, offset / _addItemAnimationMaxOffset));
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var addItem = _buildAddItem(context);
    final middle = MediaQuery.of(context).size.width / 2;
    return Container(
      color: widget.backgroundColor,
      height: widget.height,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ListView.builder(
            padding: EdgeInsets.only(
                top: widget.itemMargin,
                bottom: widget.itemMargin,
                right: widget.itemMargin),
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.itemCount + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Container(
                  foregroundDecoration:
                      BoxDecoration(color: widget.backgroundColor),
                  child: addItem,
                );
              } else {
                return Builder(
                  builder: (context) {
                    final renderObject = context.findRenderObject();
                    final itemPositionOffset = (renderObject as RenderBox?)
                            ?.getTransformTo(null)
                            .getTranslation()
                            .x ??
                        0;
                    final distanceFromCenter = (middle -
                            itemPositionOffset -
                            (widget.addItemWidth / 1.5))
                        .abs();
                    const minScale = 0.85;
                    final scaleFactor = 1 -
                        ((1 - minScale) * (distanceFromCenter / middle))
                            .clamp(0.0, 1.0);

                    return Transform.scale(
                      scale: scaleFactor,
                      child: Container(
                        margin: EdgeInsets.only(left: widget.itemMargin),
                        decoration: BoxDecoration(
                          color: widget.borderColor,
                          borderRadius: _addItemBorderRadiusTween.begin,
                          border: Border.all(
                            color: _addItemBorderColorTween.begin!,
                            width: _kBorderWidth,
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(widget.borderRadius),
                          child: widget.itemBuilder(context, index - 1),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
          addItem,
        ],
      ),
    );
  }

  Widget _buildAddItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _addItemColorTween.transform(_animationValue),
        borderRadius: _addItemBorderRadiusTween.transform(_animationValue),
        border: Border.all(
          color: _addItemBorderColorTween
              .transform(math.min(1, _animationValue * _kBorderSpeed))!,
          width: _kBorderWidth + _kBorderSpeed * _animationValue,
        ),
      ),
      width: _addItemSizeTween.transform(_animationValue)!.width,
      height: _addItemSizeTween.transform(_animationValue)!.height,
      margin: _addItemPaddingTween.transform(_animationValue),
      child: Stack(
        children: [
          Align(
            alignment: _addImageAlignmentTween.transform(_animationValue),
            child: SizedBox(
              width: _addImageSizeTween.transform(_animationValue)!.width,
              height: _addImageSizeTween.transform(_animationValue)!.height,
              child: ClipRRect(
                borderRadius: (_addImageBorderRadiusTween
                    .transform(_animationValue)) as BorderRadius,
                child: widget.image,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(_kBorderWidth),
              child: Opacity(
                child: widget.text,
                opacity: math.max(0, 1 - _animationValue * _kTextSpeed),
              ),
            ),
          ),
          Align(
            alignment: _addIconAlignmentTween.transform(_animationValue),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    _addIconBorderRadiusTween.transform(_animationValue),
                color: widget.iconBackgroundColor,
                border: Border.all(
                  width: _kBorderWidth,
                  color: widget.backgroundColor,
                ),
              ),
              constraints: BoxConstraints.tight(
                  _addIconSizeTween.transform(_animationValue)!),
              margin: _addIconMarginTween.transform(_animationValue),
              child: AnimationPostFreeAddIcon(
                onPressed: widget.onPressedIcon,
                size: _addIconChildSizeTween.transform(_animationValue)!.width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimationPostFreeAddIcon extends StatelessWidget {
  final Function? onPressed;
  final double size;
  final Color iconColor;

  const AnimationPostFreeAddIcon({
    Key? key,
    this.onPressed,
    this.size = _kIconSize,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed as void Function()?,
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            backgroundColor:
                MaterialStateProperty.all<Color>(AppColor.mainColor),
            elevation: MaterialStateProperty.all<double>(0),
            shape: MaterialStateProperty.all<OutlinedBorder>(CircleBorder())),
        child: Icon(
          Icons.add,
          color: iconColor,
          size: size,
        ));
  }
}
