class Wand {
  String? wood;
  String? core;
  double? length;

  Wand({this.wood, this.core, this.length});

  Wand.fromJson(Map<String, dynamic> json) {
    wood = json['wood'];
    core = json['core'];
    length = json['length'] != null ? (json['length'] as num).toDouble() : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wood'] = wood;
    data['core'] = core;
    data['length'] = length;
    return data;
  }
}
