abstract class ProfileEvent {}

class FetchUserProfile extends ProfileEvent {
  final String uid;

  FetchUserProfile(this.uid);
}


