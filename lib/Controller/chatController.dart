import 'package:app_fliplaptop/models/chatConversationModel.dart';
import 'package:get/get.dart';

import '../models/dashBoardModel.dart';

class ChatController extends GetxController {


  RxList<Conversation> listOfConversation = <Conversation>[].obs;
  RxBool isLoading = false.obs;
  RxString globalConversationID = "".obs;
  RxString lastMessageOnChatScreen = "".obs;
  // RxList<List<Conversation>> convoList = <List<Conversation>>[].obs;
  // RxList<Conversation> SingleConvo = <Conversation>[].obs;
  // RxList<TextMessage> totalConvo = <TextMessage>[].obs;
  RxList<String> lastMsgOfEachConversation = <String>[].obs;
  RxList<User> listOfUsers = <User>[].obs;
  RxList<int> listOfUserIDs = <int>[].obs;

  // void saveUserIDsList(List<int> list){
  //   listOfUserIDs.value = list;
  //   update();
  // }
  // void saveListOfUsers(List<User> list){
  //   listOfUsers.value = list;
  //   update();
  // }

  @override
  void onInit() {
    lastMsgOfEachConversation.clear();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    lastMsgOfEachConversation.clear();
    // TODO: implement onClose
    super.onClose();
  }

  void updateLastMsgOfEachConversationList(List<String> list){
    // lastMsgOfEachConversation.clear();
    lastMsgOfEachConversation.value = list;
    update();
  }



   // loadConversation(userID) async {
   //   Stream<List<Conversation>> _messsagestream =await  FirebaseServices().fetchConversationsStream(userID);
   //   listOfConversation.value = _messsagestream;
   //
   // }
}
