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
}
