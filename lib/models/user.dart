class UserModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? bio;
  final DateTime registeredAt;
  final List<String> roadmapIds;          // Roadmaps created by user
  final List<String> followingRoadmapIds; // Roadmaps the user follows

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.bio,
    required this.registeredAt,
    this.roadmapIds = const [],
    this.followingRoadmapIds = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      registeredAt: DateTime.parse(json['registeredAt'] as String),
      roadmapIds: (json['roadmapIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
      followingRoadmapIds: (json['followingRoadmapIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'avatarUrl': avatarUrl,
    'bio': bio,
    'registeredAt': registeredAt.toIso8601String(),
    'roadmapIds': roadmapIds,
    'followingRoadmapIds': followingRoadmapIds,
  };

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    String? bio,
    DateTime? registeredAt,
    List<String>? roadmapIds,
    List<String>? followingRoadmapIds,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      registeredAt: registeredAt ?? this.registeredAt,
      roadmapIds: roadmapIds ?? this.roadmapIds,
      followingRoadmapIds: followingRoadmapIds ?? this.followingRoadmapIds,
    );
  }
}