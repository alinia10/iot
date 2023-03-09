String getTopic(String deviceName) {
  return "mqtt/$deviceName";
}

// String getTopic(String deviceName, TopicType type) {
//   switch (type) {
//     case TopicType.publish:
//       return _getPublishTopic(deviceName);
//     case TopicType.subscribe:
//       return _getSubscribeTopic(deviceName);
//   }
// }
//
//
// String getDeviceNameByTopic(String topic) {
//   return topic.split("/").last;
// }
// //
// // TopicType getTopicType(String topic) {
// //   if (topic.contains("mqtt/receive")) {
// //     return TopicType.publish;
// //   } else if (topic.contains("mqtt/send")) {
// //     return TopicType.subscribe;
// //   } else {
// //     throw Exception("Topic type not found");
// //   }
// // }
// //
// // String _getPublishTopic(String deviceName) {
// //   return "mqtt/receive/$deviceName";
// // }
// //
// // String _getSubscribeTopic(
// //     String deviceName,
// //     ) {
// //   return "mqtt/send/$deviceName";
// // }
// //
// // enum TopicType {
// //   publish,
// //   subscribe,
// // }