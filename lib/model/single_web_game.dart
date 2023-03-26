import 'dart:convert';

class SingleWebModule {
    SingleWebModule({
        required this.id,
        required this.title,
        required this.thumbnail,
        required this.status,
        required this.shortDescription,
        required this.description,
        required this.gameUrl,
        required this.genre,
        required this.platform,
        required this.publisher,
        required this.developer,
        required this.releaseDate,
        required this.freetogameProfileUrl,
        required this.screenshots,
    });

    int id;
    String title;
    String thumbnail;
    String status;
    String shortDescription;
    String description;
    String gameUrl;
    String genre;
    String platform;
    String publisher;
    String developer;
    DateTime releaseDate;
    String freetogameProfileUrl;
    List<Screenshot> screenshots;

    factory SingleWebModule.fromRawJson(String str) => SingleWebModule.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory SingleWebModule.fromJson(Map<String, dynamic> json) => SingleWebModule(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        status: json["status"],
        shortDescription: json["short_description"],
        description: json["description"],
        gameUrl: json["game_url"],
        genre: json["genre"],
        platform: json["platform"],
        publisher: json["publisher"],
        developer: json["developer"],
        releaseDate: DateTime.parse(json["release_date"]),
        freetogameProfileUrl: json["freetogame_profile_url"],
        screenshots: List<Screenshot>.from(json["screenshots"].map((x) => Screenshot.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "thumbnail": thumbnail,
        "status": status,
        "short_description": shortDescription,
        "description": description,
        "game_url": gameUrl,
        "genre": genre,
        "platform": platform,
        "publisher": publisher,
        "developer": developer,
        "release_date": "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
        "freetogame_profile_url": freetogameProfileUrl,
        "screenshots": List<dynamic>.from(screenshots.map((x) => x.toJson())),
    };
}

class Screenshot {
    Screenshot({
        required this.id,
        required this.image,
    });

    int id;
    String image;

    factory Screenshot.fromRawJson(String str) => Screenshot.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Screenshot.fromJson(Map<String, dynamic> json) => Screenshot(
        id: json["id"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
    };
}
