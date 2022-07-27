abstract class SocialState{}

class SocialInitState extends SocialState{}

class SocialVerificationLoadingState extends SocialState{}
class SocialVerificationErrorState extends SocialState{}
class SocialVerificationSuccessState extends SocialState{}

class SocialUserDataLoadingState extends SocialState{}
class SocialUserDataErrorState extends SocialState{}
class SocialUserDataSuccessState extends SocialState{}

class SocialToggleBottomNavIndex extends SocialState{}