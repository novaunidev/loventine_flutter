import 'package:loventine_flutter/widgets/emoji_picker_flutter/src/emoji.dart';
import 'package:loventine_flutter/widgets/emoji_picker_flutter/src/emoji_picker.dart';

/// Container for Category and their emoji
class CategoryEmoji {
  /// Constructor
  const CategoryEmoji(this.category, this.emoji);

  /// Category instance
  final Category category;

  /// List of emoji of this category
  final List<Emoji> emoji;

  /// Copy method
  CategoryEmoji copyWith({Category? category, List<Emoji>? emoji}) {
    return CategoryEmoji(
      category ?? this.category,
      emoji ?? this.emoji,
    );
  }
}
