import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';

class GalleryPermissionNotifier extends StateNotifier<PermissionStatus> {
  GalleryPermissionNotifier() : super(PermissionStatus.denied);

  Future<void> checkGalleryPermission() async {
    final status = await Permission.storage.request();
    state = status;
  }
}
final galleryPermissionProvider =
    StateNotifierProvider<GalleryPermissionNotifier, PermissionStatus>((ref) {
  return GalleryPermissionNotifier();
});
