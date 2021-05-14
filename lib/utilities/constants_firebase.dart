class CollectionGroupChat {
  static const String id = 'group_chat';
  static const String text = 'text';
  static const String sender = 'sender';
  static const String createdAt = 'time';
  static const String uid = 'uid';
  static const String imageUrl = 'image_url';
}

class CollectionUsers {
  static const String id = 'users';
  static const String username = 'username';
  static const String email = 'email';
  static const String imageUrl = 'image_url';
  static const String uid = 'uid';
}

class CollectionChatsRooms {
  static const String id = 'chat_rooms';
  static const String chatRoomId = 'chat_room_id';
  static const String users = 'users';
  static const String imagesUrl = 'images_url';
  static const String usersUid = 'uid';
}

class Storage {
  static const String usersImages = 'user_image';
}
