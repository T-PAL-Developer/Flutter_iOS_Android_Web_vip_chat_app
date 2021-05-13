import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vip_chat_app/utilities/constantsFirebaseDB.dart';

class Database {
  getUserByUsername() {}

  Future<String> uploadUserImage(
      User authResult, Uint8List userImageFile) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child('${authResult.uid}');

    await ref.putData(userImageFile);

    final url = await ref.getDownloadURL();
    return url;
  }

  Future<void> uploadUserInfo(User authResult, String userName,
      String userEmail, String userImageUrl) async {
    await FirebaseFirestore.instance
        .collection(CollectionUsers.id)
        .doc(authResult.uid)
        .set({
      CollectionUsers.username: userName,
      CollectionUsers.email: userEmail,
      CollectionUsers.imageUrl: userImageUrl,
    });
  }
}
