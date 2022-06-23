import 'dart:convert';

class Hospital {
  Hospital({
    required this.documentID,
    required this.enabled,
    required this.address,
    required this.openTime,
    required this.latitude,
    required this.longitude,
    required this.mainImage,
    required this.reviewPoints,
    required this.phone,
    required this.title,
    required this.website,
    required this.iconColor,
    required this.notes,
  });

  factory Hospital.fromJson(String source) =>
      Hospital.fromMap(json.decode(source));

  factory Hospital.fromMap(Map<String, dynamic> map, {String? documentID}) {
    return Hospital(
      documentID: documentID ?? map['documentID'],
      enabled: map['enabled'] ?? true,
      address: map['address'],
      openTime: map['openTime'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      mainImage: map['mainImage'],
      reviewPoints: map['reviewPoints'],
      phone: map['phone'],
      title: map['title'],
      website: map['website'],
      iconColor: map['iconColor'] ?? 0xff000000,
      notes: map['notes'] ?? '',
    );
  }

  final String address;
  final String documentID;
  final bool enabled;
  final int iconColor;
  final String latitude;
  final String longitude;
  final String mainImage;
  final String notes;
  final String openTime;
  final String phone;
  final String reviewPoints;
  final String title;
  final String website;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Hospital &&
        other.documentID == documentID &&
        other.enabled == enabled &&
        other.address == address &&
        other.openTime == openTime &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.mainImage == mainImage &&
        other.reviewPoints == reviewPoints &&
        other.phone == phone &&
        other.title == title &&
        other.website == website &&
        other.iconColor == iconColor &&
        other.notes == notes;
  }

  @override
  int get hashCode {
    return documentID.hashCode ^
        enabled.hashCode ^
        address.hashCode ^
        openTime.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        mainImage.hashCode ^
        reviewPoints.hashCode ^
        phone.hashCode ^
        title.hashCode ^
        website.hashCode ^
        iconColor.hashCode ^
        notes.hashCode;
  }

  @override
  String toString() {
    return '(documentID: $documentID, enabled: $enabled, title: $title, address: $address, openTime: $openTime, latitude: $latitude, longitude: $longitude, mainImage: $mainImage, reviewPoints: $reviewPoints, phone: $phone, website: $website, iconColor: $iconColor, notes: $notes)';
  }

  Hospital copyWith({
    String? documentID,
    bool? enabled,
    String? address,
    String? openTime,
    String? latitude,
    String? longitude,
    String? mainImage,
    String? reviewPoints,
    String? phone,
    String? title,
    String? website,
    int? iconColor,
    String? notes,
  }) {
    return Hospital(
      documentID: documentID ?? this.documentID,
      enabled: enabled ?? this.enabled,
      address: address ?? this.address,
      openTime: openTime ?? this.openTime,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      mainImage: mainImage ?? this.mainImage,
      reviewPoints: reviewPoints ?? this.reviewPoints,
      phone: phone ?? this.phone,
      title: title ?? this.title,
      website: website ?? this.website,
      iconColor: iconColor ?? this.iconColor,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'documentID': documentID,
      'enabled': enabled,
      'address': address,
      'openTime': openTime,
      'latitude': latitude,
      'longitude': longitude,
      'mainImage': mainImage,
      'reviewPoints': reviewPoints,
      'phone': phone,
      'title': title,
      'website': website,
      'iconColor': iconColor,
      'notes': notes,
    };
  }

  String toJson() => json.encode(toMap());
}
