class DemoModel {
  final List<Mods>? mods;

  DemoModel({
    this.mods,
  });

  DemoModel.fromJson(Map<String, dynamic> json)
      : mods = (json['mods'] as List?)
            ?.map((dynamic e) => Mods.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() =>
      {'mods': mods?.map((e) => e.toJson()).toList()};
}

class Mods {
  final String? id;
  final String? title;
  final List<Categories>? categories;
  final List<Versions>? versions;
  final List<Files>? files;
  final List<Screens>? screens;
  final List<dynamic>? recipes;
  final String? author;
  final String? date;
  final String? views;
  final String? likes;
  final String? downloads;
  final String? description;

  Mods({
    this.id,
    this.title,
    this.categories,
    this.versions,
    this.files,
    this.screens,
    this.recipes,
    this.author,
    this.date,
    this.views,
    this.likes,
    this.downloads,
    this.description,
  });

  Mods.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String?,
        title = json['title'] as String?,
        categories = (json['categories'] as List?)
            ?.map((dynamic e) => Categories.fromJson(e as Map<String, dynamic>))
            .toList(),
        versions = (json['versions'] as List?)
            ?.map((dynamic e) => Versions.fromJson(e as Map<String, dynamic>))
            .toList(),
        files = (json['files'] as List?)
            ?.map((dynamic e) => Files.fromJson(e as Map<String, dynamic>))
            .toList(),
        screens = (json['screens'] as List?)
            ?.map((dynamic e) => Screens.fromJson(e as Map<String, dynamic>))
            .toList(),
        recipes = json['recipes'] as List?,
        author = json['author'] as String?,
        date = json['date'] as String?,
        views = json['views'] as String?,
        likes = json['likes'] as String?,
        downloads = json['downloads'] as String?,
        description = json['description'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'categories': categories?.map((e) => e.toJson()).toList(),
        'versions': versions?.map((e) => e.toJson()).toList(),
        'files': files?.map((e) => e.toJson()).toList(),
        'screens': screens?.map((e) => e.toJson()).toList(),
        'recipes': recipes,
        'author': author,
        'date': date,
        'views': views,
        'likes': likes,
        'downloads': downloads,
        'description': description
      };
}

class Categories {
  final String? categoryId;
  final String? name;
  final String? post;

  Categories({
    this.categoryId,
    this.name,
    this.post,
  });

  Categories.fromJson(Map<String, dynamic> json)
      : categoryId = json['category_id'] as String?,
        name = json['name'] as String?,
        post = json['post'] as String?;

  Map<String, dynamic> toJson() =>
      {'category_id': categoryId, 'name': name, 'post': post};
}

class Versions {
  final String? code;

  Versions({
    this.code,
  });

  Versions.fromJson(Map<String, dynamic> json) : code = json['code'] as String?;

  Map<String, dynamic> toJson() => {'code': code};
}

class Files {
  final String? fileId;
  final String? url;
  final String? desc;
  final String? downloads;

  Files({
    this.fileId,
    this.url,
    this.desc,
    this.downloads,
  });

  Files.fromJson(Map<String, dynamic> json)
      : fileId = json['file_id'] as String?,
        url = json['url'] as String?,
        desc = json['desc'] as String?,
        downloads = json['downloads'] as String?;

  Map<String, dynamic> toJson() =>
      {'file_id': fileId, 'url': url, 'desc': desc, 'downloads': downloads};
}

class Screens {
  final String? url;

  Screens({
    this.url,
  });

  Screens.fromJson(Map<String, dynamic> json) : url = json['url'] as String?;

  Map<String, dynamic> toJson() => {'url': url};
}


