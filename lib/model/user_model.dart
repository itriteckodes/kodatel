import 'dart:convert';

class Users {
  String? name;
  String? phone;
  String? status;

  String? photoUrl;
  String? lastSeen;
  Users({
    this.name,
    this.phone,
    this.status,
    this.photoUrl,
    this.lastSeen,
  });

  Users copyWith({
    String? name,
    String? phone,
    String? status,
    String? photoUrl,
    String? lastSeen,
  }) {
    return Users(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      photoUrl: photoUrl ?? this.photoUrl,
      lastSeen: lastSeen ?? this.lastSeen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'status': status,
      'photoUrl': photoUrl,
      'lastSeen': lastSeen,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      name: map['name'],
      phone: map['phone'],
      status: map['status'],
      photoUrl: map['photoUrl'],
      lastSeen: map['lastSeen'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) => Users.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Users(name: $name, phone: $phone, status: $status,  photoUrl: $photoUrl, lastSeen: $lastSeen)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Users &&
        other.name == name &&
        other.phone == phone &&
        other.status == status &&
        other.photoUrl == photoUrl &&
        other.lastSeen == lastSeen;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        phone.hashCode ^
        status.hashCode ^
        photoUrl.hashCode ^
        lastSeen.hashCode;
  }

  static String encode(List<Users> users) => json.encode(
        users.map<Map<String, dynamic>>((value) => value.toMap()).toList(),
      );

  static List<Users> decode(String user) => (json.decode(user) as List<dynamic>)
      .map<Users>((item) => Users.fromJson(item))
      .toList();
}
