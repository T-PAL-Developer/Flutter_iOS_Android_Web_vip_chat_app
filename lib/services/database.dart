import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vip_chat_app/utilities/constants_firebase.dart';

class Database {
  Future<void> uploadMessage(User user, String messageText) async {
    try {
      final userData =
          await FirebaseFirestore.instance.collection(CollectionUsers.id).doc(user.uid).get();
      FirebaseFirestore.instance.collection(CollectionGroupChat.id).add({
        CollectionGroupChat.text: messageText,
        CollectionGroupChat.sender: user.displayName ?? userData[CollectionUsers.username],
        CollectionGroupChat.createdAt: Timestamp.now(),
        CollectionGroupChat.uid: user.uid,
        CollectionGroupChat.imageUrl: userData[CollectionUsers.imageUrl]
      });
    } catch (e) {
      print('Error -> Exception details:\n $e');
      rethrow;
    }
  }

  Future<void> createChatRoom(Map<String, dynamic> chatRoomUsersInfo, String chatRoomId) {
    return FirebaseFirestore.instance
        .collection(CollectionChatsRooms.id)
        .doc(chatRoomId)
        .set(chatRoomUsersInfo)
        .catchError((e) {
      print('Error -> Exception details:\n $e');
    });
  }

  Stream<QuerySnapshot> getChatContent(String chatID) {
    return FirebaseFirestore.instance
        .collection(chatID)
        .orderBy(CollectionGroupChat.createdAt, descending: true)
        .snapshots();
  }

  Future<QuerySnapshot> getUserByUsername(String username) async {
    return await FirebaseFirestore.instance
        .collection(CollectionUsers.id)
        .where(CollectionUsers.username, isEqualTo: username)
        .get()
        .catchError((e) {
      print('Error -> Exception details:\n $e');
    });
  }

  Future<String> uploadUserImage(User authResult, Uint8List userImageFile) async {
    try {
      final ref =
          FirebaseStorage.instance.ref().child(Storage.usersImages).child('${authResult.uid}');
      await ref.putData(userImageFile);
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print('Error -> Exception details:\n $e');
      rethrow;
    }
  }

  Future<void> uploadUserInfo(
      User authResult, String userName, String userEmail, String userImageUrl) async {
    try {
      await FirebaseFirestore.instance.collection(CollectionUsers.id).doc(authResult.uid).set({
        CollectionUsers.username: userName,
        CollectionUsers.email: userEmail,
        CollectionUsers.imageUrl: userImageUrl,
        CollectionUsers.uid: authResult.uid,
      });
    } catch (e) {
      print('Error -> Exception details:\n $e');
      rethrow;
    }
  }
}
