class FcmHandler{
  static Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      print("DATA ----> ${data}");
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      print("NOTIFICATION ----> ${notification}");

    }

    // Or do other work.
  }
}