import 'dart:io';

import 'package:photo_manager/photo_manager.dart';

class MediaServices {
  Future loadAlbums(RequestType requestType) async {
    var permission = await PhotoManager.requestPermissionExtend();
    List<AssetPathEntity> albumList = [];
    if (Platform.isIOS) {
      if (permission.hasAccess) {
        albumList = await PhotoManager.getAssetPathList(
          type: requestType,
        );
      } else {
        PhotoManager.openSetting();
      }
    } else if (Platform.isAndroid) {
      if (permission.isAuth == true) {
        albumList = await PhotoManager.getAssetPathList(
          type: requestType,
        );
      } else {
        PhotoManager.openSetting();
      }
    }

    return albumList;
  }

  Future loadAssets(AssetPathEntity selectedAlbum) async {
    List<AssetEntity> assetList = [];
    if (Platform.isIOS) {
      assetList = await selectedAlbum.getAssetListPaged(page: 0, size: 10000);
    } else if (Platform.isAndroid) {
      assetList = await selectedAlbum.getAssetListRange(
        start: 0,
        // ignore: deprecated_member_use
        end: selectedAlbum.assetCount,
      );
    }

    return assetList;
  }
}
