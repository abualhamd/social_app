import 'package:social_app/modules/layout_module/cubit/social_states.dart';

abstract class PostState extends SocialState{}

class PostInitState extends PostState{}

class PostImageGetState extends PostState{}
class PostImageSuccessState extends PostState{}
class PostImageErrorState extends PostState{}

class PostImageCancelState extends PostState{}

class PostImageUploadingState extends PostState{}
class PostImageUploadingSuccessState extends PostState{}
class PostImageUploadingErrorState extends PostState{}


class PostCreateLoadingState extends PostState{}
class PostCreateSuccessState extends PostState{}
class PostCreateErrorState extends PostState{}


