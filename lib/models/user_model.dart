class UserModel {
  final String? uid;
  final String? displayName;
  final String? email;
  final String? photoUrl;
  final bool? isAnonymous;
  final bool? isPremium;

  UserModel({
    this.uid,
    this.displayName,
    this.email,
    this.photoUrl,
    this.isAnonymous,
    this.isPremium,
  });

  factory UserModel.fromMap(Map<String, dynamic> obj) {
    return UserModel(
      uid: obj['uid'] ?? '',
      displayName: obj['displayName'] ?? '',
      email: obj['email'] ?? '',
      photoUrl: obj['photoUrl'] ?? '',
      isAnonymous: obj['isAnonymous'] ?? false,
      isPremium: obj['isPremium'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'displayName': displayName,
      'email': email,
      'photoUrl': photoUrl,
      'isAnonymous': isAnonymous,
      'isPremium': isPremium,
    };
  }
}
