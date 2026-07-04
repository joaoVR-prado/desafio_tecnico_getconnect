abstract class ChatRemoteDatasourceInterface {
  Stream<List<Map<String, dynamic>>> getMessages();
  Future<void> sendMessage(Map<String, dynamic> messageMap);

}