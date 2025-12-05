class NotificationNewModel {
  // ---------- CAMPOS DE SAÍDA ----------
  final String? id;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? isActive;
  final String? createdBy;

  // ---------- CAMPOS OBRIGATÓRIOS ----------
  final String title;
  final String? summary;
  final String body;
  final String? ttsText;
  final String? audioUrl;
  final String severity; // enum do backend, enviado como string

  final String? eventType;
  final String? region;

  final DateTime? publishedAt;
  final DateTime? expiresAt;
  final bool? isPublished;


  NotificationNewModel({
    this.id,
    this.createdAt,
    this.updatedAt,
    this.isActive,
    this.createdBy,
    required this.title,
    required this.summary,
    required this.body,
    this.ttsText,
    this.audioUrl,
    required this.severity,
    required this.eventType,
    this.region,
    this.publishedAt,
    this.expiresAt,
    this.isPublished,
  });

  // Construtor a partir de JSON
  // Construtor a partir de JSON
factory NotificationNewModel.fromJson(Map<String, dynamic> json) {
  return NotificationNewModel(
    id: json['id'],
    createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    isActive: json['isActive'],
    createdBy: json['createdBy'],
    title: json['title'],
    summary: json['summary'],
    body: json['body'],
    ttsText: json['ttsText'],
    audioUrl: json['audioUrl'],
    severity: json['severity'], // enum como string
    eventType: json['eventType'],
    region: json['region'],
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
    "summary": summary,
    "body": body,
    "ttsText": ttsText,
    "audioUrl": audioUrl,
    "severity": severity,
    "eventType": eventType,
    "region": region,
    "publishedAt": publishedAt?.toIso8601String(),
    "expiresAt": expiresAt?.toIso8601String(),
    "isPublished": isPublished,
  };
}
}