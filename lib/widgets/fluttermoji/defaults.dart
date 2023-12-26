/// Default list of icons that are rendered in the bottom row, indicating
/// the attributes available to modify.
///
/// These icons come bundled with the library and the paths below
/// are indicative of that.
const List<String> defaultAttributeIcons = [
  "assets/svgs/hair.svg",
  "assets/svgs/haircolor.svg",
  "assets/svgs/beard.svg",
  "assets/svgs/beardcolor.svg",
  "assets/svgs/outfit.svg",
  "assets/svgs/outfitcolor.svg",
  "assets/svgs/eyes.svg",
  "assets/svgs/eyebrow.svg",
  "assets/svgs/mouth.svg",
  "assets/svgs/skin.svg",
  "assets/svgs/accessories.svg",
];

/// Default list of titles that are rendered at the top of the widget, indicating
/// which attribute the user is customizing.

/// List of keys used internally by this library to dereference
/// attributes and their values in the business logic.
///
/// This aspect is not modifiable by you at any stage of the app.
const List<String> attributeKeys = [
  "topType",
  "hairColor",
  "facialHairType",
  "facialHairColor",
  "clotheType",
  "clotheColor",
  "eyeType",
  "eyebrowType",
  "mouthType",
  "skinColor",
  "accessoriesType",
];
