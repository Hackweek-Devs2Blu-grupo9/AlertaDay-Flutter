class NotificationModel {
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isActive;
  final String? createdBy;

  final String title;
  final String message;
  final String severity;
  final String? eventType;
  final String? region;
  final String? channels;
  final String? newsId;

  final DateTime? publishedAt;
  final DateTime? expiresAt;
  final bool? isPublished;

  NotificationModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.createdBy,
    required this.title,
    required this.message,
    required this.severity,
    this.eventType,
    this.region,
    this.channels,
    this.newsId,
    this.publishedAt,
    this.expiresAt,
    this.isPublished,
  });

  // Construtor a partir de JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      isActive: json['isActive'],
      createdBy: json['createdBy'],
      title: json['title'],
      message: json['message'],
      severity: json['severity'], // enum como string
      eventType: json['eventType'],
      region: json['region'],
      channels: json['channels'],
      newsId: json['newsId'],
      publishedAt: json['publishedAt'] != null ? DateTime.parse(json['publishedAt']) : null,
      expiresAt: json['expiresAt'] != null ? DateTime.parse(json['expiresAt']) : null,
      isPublished: json['isPublished']
    );
  }

  // Converter para JSON (útil em POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
      "isActive": isActive,
      "createdBy": createdBy,
      "title": title,
      "message": message,
      "severity": severity,
      "eventType": eventType,
      "region": region,
      "channels": channels,
      "newsId": newsId,
      "publishedAt": publishedAt?.toIso8601String(),
      "expiresAt": expiresAt?.toIso8601String(),
      "isPublished": isPublished,
    };
  }
}