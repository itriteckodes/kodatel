class ChatModel {
  int? id;
  String? name;
  String? icon;
  bool? isGroup;
  String? time;
  String? currentMsg;
  String? status;
  bool? select = false;
  ChatModel(
      {this.id,
      this.name,
      this.currentMsg,
      this.icon,
      this.select,
      this.status,
      this.isGroup,
      this.time});
}
