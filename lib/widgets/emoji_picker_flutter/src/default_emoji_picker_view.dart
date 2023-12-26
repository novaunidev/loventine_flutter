import 'package:loventine_flutter/widgets/emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:loventine_flutter/widgets/emoji_picker_flutter/src/skin_tone_overlay.dart';
import 'package:flutter/material.dart';

/// Default EmojiPicker Implementation
class DefaultEmojiPickerView extends EmojiPickerBuilder {
  /// Constructor
  final ScrollController scrollController;
  final VoidCallback success;
  DefaultEmojiPickerView(
      Config config, EmojiViewState state, this.scrollController, this.success)
      : super(config, state);

  @override
  _DefaultEmojiPickerViewState createState() => _DefaultEmojiPickerViewState();
}

class _DefaultEmojiPickerViewState extends State<DefaultEmojiPickerView>
    with SingleTickerProviderStateMixin, SkinToneOverlayStateMixin {
  final double _tabBarHeight = 43;

  late PageController _pageController;
  late TabController _tabController;
  // late final _scrollController = ScrollController();

  late final _utils = EmojiPickerUtils();

  @override
  void initState() {
    var initCategory = widget.state.categoryEmoji.indexWhere(
        (element) => element.category == widget.config.initCategory);
    if (initCategory == -1) {
      initCategory = 0;
    }
    _tabController = TabController(
        initialIndex: initCategory,
        length: widget.state.categoryEmoji.length,
        vsync: this);
    _pageController = PageController(initialPage: initCategory)
      ..addListener(closeSkinToneOverlay);
    widget.scrollController.addListener(closeSkinToneOverlay);
    super.initState();
  }

  @override
  void dispose() {
    closeSkinToneOverlay();
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final emojiSize = widget.config.getEmojiSize(constraints.maxWidth);
        return EmojiContainer(
          color: widget.config.bgColor,
          buttonMode: widget.config.buttonMode,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Màu của bóng
                  spreadRadius:
                      -3, // Độ xổ của bóng (lớn hơn giá trị, bóng càng lớn)
                  blurRadius:
                      7, // Độ mờ của bóng (lớn hơn giá trị, bóng càng mờ)
                  offset: Offset(0,
                      -3), // Vị trí của bóng (thay đổi giá trị X và Y để di chuyển bóng)
                ),
              ],
            ),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton(
                        onPressed: () {
                          widget.success();
                        },
                        child: Text("Xong"))),
                Row(
                  children: [
                    Expanded(
                      child: _buildTabBar(context),
                    ),
                    _buildBackspaceButton(),
                  ],
                ),
                Flexible(
                  child: PageView.builder(
                    itemCount: widget.state.categoryEmoji.length,
                    controller: _pageController,
                    onPageChanged: (index) {
                      _tabController.animateTo(
                        index,
                        duration: widget.config.tabIndicatorAnimDuration,
                      );
                    },
                    itemBuilder: (context, index) => Container(
                        child: _buildPage(
                            emojiSize, widget.state.categoryEmoji[index])),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabBar(BuildContext context) => SizedBox(
        height: _tabBarHeight,
        child: TabBar(
          labelColor: widget.config.iconColorSelected,
          indicatorColor: widget.config.indicatorColor,
          unselectedLabelColor: widget.config.iconColor,
          controller: _tabController,
          labelPadding: EdgeInsets.zero,
          onTap: (index) {
            closeSkinToneOverlay();
            _pageController.jumpToPage(index);
          },
          tabs: widget.state.categoryEmoji
              .asMap()
              .entries
              .map<Widget>(
                  (item) => _buildCategory(item.key, item.value.category))
              .toList(),
        ),
      );

  Widget _buildBackspaceButton() {
    if (widget.state.onBackspacePressed != null) {
      return SizedBox(
        height: _tabBarHeight,
        child: IconButton(
            padding: const EdgeInsets.only(bottom: 2),
            icon: Icon(
              Icons.backspace,
              color: widget.config.backspaceColor,
            ),
            onPressed: () {
              widget.state.onBackspacePressed!();
            }),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildCategory(int index, Category category) {
    return Tab(
      icon: Icon(
        widget.config.getIconForCategory(category),
      ),
    );
  }

  Widget _buildPage(double emojiSize, CategoryEmoji categoryEmoji) {
    // Display notice if recent has no entries yet
    if (categoryEmoji.category == Category.RECENT &&
        categoryEmoji.emoji.isEmpty) {
      return _buildNoRecent();
    }
    // Build page normally
    return GestureDetector(
      onTap: closeSkinToneOverlay,
      child: GridView.count(
          scrollDirection: Axis.vertical,
          controller: widget.scrollController,
          primary: false,
          padding: widget.config.gridPadding,
          crossAxisCount: widget.config.columns,
          mainAxisSpacing: widget.config.verticalSpacing,
          crossAxisSpacing: widget.config.horizontalSpacing,
          children: [
            for (int i = 0; i < categoryEmoji.emoji.length; i++)
              EmojiCell.fromConfig(
                emoji: categoryEmoji.emoji[i],
                emojiSize: emojiSize,
                categoryEmoji: categoryEmoji,
                index: i,
                onEmojiSelected: (category, emoji) {
                  closeSkinToneOverlay();
                  widget.state.onEmojiSelected(category, emoji);
                },
                onSkinToneDialogRequested: _openSkinToneDialog,
                config: widget.config,
              )
          ]),
    );
  }

  /// Build Widget for when no recent emoji are available
  Widget _buildNoRecent() {
    return Center(
      child: widget.config.noRecents,
    );
  }

  void _openSkinToneDialog(
    Emoji emoji,
    double emojiSize,
    CategoryEmoji? categoryEmoji,
    int index,
  ) {
    closeSkinToneOverlay();
    if (!emoji.hasSkinTone || !widget.config.enableSkinTones) {
      return;
    }
    showSkinToneOverlay(
        emoji,
        emojiSize,
        categoryEmoji,
        index,
        kSkinToneCount,
        widget.config,
        widget.scrollController.offset,
        _tabBarHeight,
        _utils,
        _onSkinTonedEmojiSelected);
  }

  void _onSkinTonedEmojiSelected(Category? category, Emoji emoji) {
    widget.state.onEmojiSelected(category, emoji);
    closeSkinToneOverlay();
  }
}
