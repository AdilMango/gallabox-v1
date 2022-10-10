import 'package:equatable/equatable.dart';

/// Model representing a Contact object
class Contact extends Equatable {
  /// Create a new instance of [Contact]
  const Contact({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  /// Creates a new instance of [Contact] from parsed data
  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        id: json['id'] as String?,
        name: json['name'] as String?,
        phone: json['phone'] == null
            ? null
            : List<String?>.from(
                (json['phone'] as List<dynamic>).map<String>(
                  (dynamic x) => x as String,
                ),
              ),
        email: json['email'] == null
            ? null
            : List<String?>.from(
                (json['email'] as List<dynamic>).map<String>(
                  (dynamic x) => x as String,
                ),
              ),
      );

  /// Unique ID
  final String? id;

  /// Contact name
  final String? name;

  /// Contact Email
  final List<String?>? email;

  /// Contact Phone
  final List<String?>? phone;

  /// CopyWith Constructor
  Contact copyWith({
    String? id,
    String? name,
    List<String?>? email,
    List<String?>? phone,
  }) =>
      Contact(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
      );

  /// Converts object to raw data
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
      };

  @override
  // TODO: implement props
  List<Object?> get props => [name, id, email, phone];
}
