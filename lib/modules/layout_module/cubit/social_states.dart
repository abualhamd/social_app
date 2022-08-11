abstract class SocialState{}

class SocialInitState extends SocialState{}

class SocialVerificationLoadingState extends SocialState{}
class SocialVerificationErrorState extends SocialState{}
class SocialVerificationSuccessState extends SocialState{}

class SocialUserDataLoadingState extends SocialState{}
class SocialUserDataErrorState extends SocialState{}
class SocialUserDataSuccessState extends SocialState{}

class SocialToggleBottomNavIndex extends SocialState{}

class SocialAddPostState extends SocialState{}

abstract class SocialUpdatingState extends SocialState{}

class SocialUpdatingProfileImageState extends SocialUpdatingState{}
class SocialProfileImageUpdateSuccess extends SocialState{}
class SocialProfileImageUpdateError extends SocialState{}

class SocialUpdatingCoverImageState extends SocialUpdatingState{}
class SocialCoverImageUpdateSuccess extends SocialState{}
class SocialCoverImageUpdateError extends SocialState{}

class SocialPostLoadingState extends SocialState{}
class SocialPostErrorState extends SocialState{}
class SocialPostSuccessState extends SocialState{}

class SocialPostImageGetState extends SocialUpdatingState{}
class SocialPostImageSuccessState extends SocialState{}
class SocialPostImageErrorState extends SocialState{}