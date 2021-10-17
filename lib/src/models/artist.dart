/*
Sap
Copyright (C) 2021  Carlton Aikins

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'dart:convert';

class Artist {
  int? id;
  String? name;
  String? link;
  String? pictureUrl;
  int? numFans;

  Artist({
    this.id,
    this.name,
    this.link,
    this.pictureUrl,
    this.numFans,
  });

  Artist copyWith({
    int? id,
    String? name,
    String? link,
    String? pictureUrl,
    int? numFans,
  }) {
    return Artist(
      id: id ?? this.id,
      name: name ?? this.name,
      link: link ?? this.link,
      pictureUrl: pictureUrl ?? this.pictureUrl,
      numFans: numFans ?? this.numFans,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'link': link,
      'picture_xl': pictureUrl,
      'nb_fan': numFans,
    };
  }

  factory Artist.fromMap(Map<String, dynamic> map) {
    return Artist(
      id: map['id'] as int?,
      name: map['name'] as String?,
      link: map['link'] as String?,
      pictureUrl: map['picture_xl'] as String?,
      numFans: map['nb_fan'] as int?,
    );
  }

  factory Artist.fromMapFromAlbum(Map<String, dynamic> map) {
    return Artist(
      id: map['id'] as int?,
      name: map['name'] as String?,
      pictureUrl: map['picture_xl'] as String?,
    );
  }

  factory Artist.fromMapFromSong(Map<String, dynamic> map) {
    return Artist(
      id: map['id'] as int?,
      name: map['name'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory Artist.fromJson(String source) => Artist.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Artist(id: $id, name: $name, link: $link, pictureUrl: $pictureUrl, numFans: $numFans)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Artist &&
        other.id == id &&
        other.name == name &&
        other.link == link &&
        other.pictureUrl == pictureUrl &&
        other.numFans == numFans;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        link.hashCode ^
        pictureUrl.hashCode ^
        numFans.hashCode;
  }
}
