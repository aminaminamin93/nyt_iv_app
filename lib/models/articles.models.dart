// To parse this JSON data, do
//
//     final articlesResponse = articlesResponseFromJson(jsonString);

import 'dart:convert';

ArticlesResponse articlesResponseFromJson(String str) => ArticlesResponse.fromJson(json.decode(str));

String articlesResponseToJson(ArticlesResponse data) => json.encode(data.toJson());

class ArticlesResponse {
  String? copyright;
  ResponseData? response;

  ArticlesResponse({
    this.copyright,
    this.response,
  });

  factory ArticlesResponse.fromJson(Map<String, dynamic> json) => ArticlesResponse(
    copyright: json["copyright"],
    response: ResponseData.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "copyright": copyright,
    "response": response?.toJson(),
  };
}

class ResponseData {
  List<Doc> docs;
  // Meta meta;

  ResponseData({
    required this.docs,
    // required this.meta,
  });

  factory ResponseData.fromJson(Map<String, dynamic> json) => ResponseData(
    docs: List<Doc>.from(json["docs"].map((x) => Doc.fromJson(x))),
    // meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "docs": List<dynamic>.from(docs.map((x) => x.toJson())),
    // "meta": meta.toJson(),
  };
}

class Doc {
  String abstract;
  String webUrl;
  String snippet;
  String leadParagraph;
  dynamic printSection;
  dynamic printPage;
  String source;
  // List<Multimedia> multimedia;
  Headline headline;
  // List<Keyword> keywords;
  String pubDate;
  String documentType;
  String newsDesk;
  dynamic sectionName;
  dynamic subsectionName;
  // Byline byline;
  dynamic typeOfMaterial;
  String id;
  int wordCount;
  String uri;

  Doc({
    required this.abstract,
    required this.webUrl,
    required this.snippet,
    required this.leadParagraph,
    this.printSection,
    this.printPage,
    required this.source,
    // required this.multimedia,
    required this.headline,
    // required this.keywords,
    required this.pubDate,
    required this.documentType,
    required this.newsDesk,
    required this.sectionName,
    this.subsectionName,
    // required this.byline,
    required this.typeOfMaterial,
    required this.id,
    required this.wordCount,
    required this.uri,
  });

  factory Doc.fromJson(Map<String, dynamic> json) => Doc(
    abstract: json["abstract"],
    webUrl: json["web_url"],
    snippet: json["snippet"],
    leadParagraph: json["lead_paragraph"],
    printSection: json["print_section"],
    printPage: json["print_page"],
    source: json["source"],
    // multimedia: List<Multimedia>.from(json["multimedia"].map((x) => Multimedia.fromJson(x))),
    headline: Headline.fromJson(json["headline"]),
    // keywords: List<Keyword>.from(json["keywords"].map((x) => Keyword.fromJson(x))),
    pubDate: json["pub_date"],
    documentType: json["document_type"],
    newsDesk: json["news_desk"],
    sectionName: json["section_name"],
    subsectionName: json["subsection_name"],
    // byline: Byline.fromJson(json["byline"]),
    typeOfMaterial: json["type_of_material"],
    id: json["_id"],
    wordCount: json["word_count"],
    uri: json["uri"],
  );

  Map<String, dynamic> toJson() => {
    "abstract": abstract,
    "web_url": webUrl,
    "snippet": snippet,
    "lead_paragraph": leadParagraph,
    "print_section": printSection,
    "print_page": printPage,
    "source": source,
    // "multimedia": List<dynamic>.from(multimedia.map((x) => x.toJson())),
    "headline": headline.toJson(),
    // "keywords": List<dynamic>.from(keywords.map((x) => x.toJson())),
    "pub_date": pubDate,
    "document_type": documentType,
    "news_desk": newsDesk,
    "section_name": sectionName,
    "subsection_name": subsectionName,
    // "byline": byline.toJson(),
    "type_of_material": typeOfMaterial,
    "_id": id,
    "word_count": wordCount,
    "uri": uri,
  };
}

class Byline {
  String original;
  List<Person> person;
  String? organization;

  Byline({
    required this.original,
    required this.person,
    this.organization,
  });

  factory Byline.fromJson(Map<String, dynamic> json) => Byline(
    original: json["original"],
    person: List<Person>.from(json["person"].map((x) => Person.fromJson(x))),
    organization: json["organization"],
  );

  Map<String, dynamic> toJson() => {
    "original": original,
    "person": List<dynamic>.from(person.map((x) => x.toJson())),
    "organization": organization,
  };
}

class Person {
  String firstname;
  String? middlename;
  String lastname;
  String? qualifier;
  dynamic title;
  String role;
  String organization;
  int rank;

  Person({
    required this.firstname,
    this.middlename,
    required this.lastname,
    this.qualifier,
    this.title,
    required this.role,
    required this.organization,
    required this.rank,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
    firstname: json["firstname"],
    middlename: json["middlename"],
    lastname: json["lastname"],
    qualifier: json["qualifier"],
    title: json["title"],
    role: json["role"],
    organization: json["organization"],
    rank: json["rank"],
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "middlename": middlename,
    "lastname": lastname,
    "qualifier": qualifier,
    "title": title,
    "role": role,
    "organization": organization,
    "rank": rank,
  };
}

class Headline {
  String main;
  dynamic kicker;
  dynamic contentKicker;
  String? printHeadline;
  dynamic name;
  dynamic seo;
  dynamic sub;

  Headline({
    required this.main,
    this.kicker,
    this.contentKicker,
    required this.printHeadline,
    this.name,
    this.seo,
    this.sub,
  });

  factory Headline.fromJson(Map<String, dynamic> json) => Headline(
    main: json["main"],
    kicker: json["kicker"],
    contentKicker: json["content_kicker"],
    printHeadline: json["print_headline"],
    name: json["name"],
    seo: json["seo"],
    sub: json["sub"],
  );

  Map<String, dynamic> toJson() => {
    "main": main,
    "kicker": kicker,
    "content_kicker": contentKicker,
    "print_headline": printHeadline,
    "name": name,
    "seo": seo,
    "sub": sub,
  };
}

class Keyword {
  String name;
  String value;
  int rank;
  String major;

  Keyword({
    required this.name,
    required this.value,
    required this.rank,
    required this.major,
  });

  factory Keyword.fromJson(Map<String, dynamic> json) => Keyword(
    name: json["name"],
    value: json["value"],
    rank: json["rank"],
    major: json["major"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "value": value,
    "rank": rank,
    "major": major,
  };
}

class Multimedia {
  int rank;
  String subtype;
  dynamic caption;
  dynamic credit;
  String type;
  String url;
  int height;
  int width;
  String subType;
  String cropName;
  Legacy legacy;

  Multimedia({
    required this.rank,
    required this.subtype,
    this.caption,
    this.credit,
    required this.type,
    required this.url,
    required this.height,
    required this.width,
    required this.subType,
    required this.cropName,
    required this.legacy,
  });

  factory Multimedia.fromJson(Map<String, dynamic> json) => Multimedia(
    rank: json["rank"],
    subtype: json["subtype"],
    caption: json["caption"],
    credit: json["credit"],
    type: json["type"],
    url: json["url"],
    height: json["height"],
    width: json["width"],
    subType: json["subType"],
    cropName: json["crop_name"],
    legacy: Legacy.fromJson(json["legacy"]),
  );

  Map<String, dynamic> toJson() => {
    "rank": rank,
    "subtype": subtype,
    "caption": caption,
    "credit": credit,
    "type": type,
    "url": url,
    "height": height,
    "width": width,
    "subType": subType,
    "crop_name": cropName,
    "legacy": legacy.toJson(),
  };
}

class Legacy {
  String? xlarge;
  int? xlargewidth;
  int? xlargeheight;
  String? thumbnail;
  int? thumbnailwidth;
  int? thumbnailheight;

  Legacy({
    this.xlarge,
    this.xlargewidth,
    this.xlargeheight,
    this.thumbnail,
    this.thumbnailwidth,
    this.thumbnailheight,
  });

  factory Legacy.fromJson(Map<String, dynamic> json) => Legacy(
    xlarge: json["xlarge"],
    xlargewidth: json["xlargewidth"],
    xlargeheight: json["xlargeheight"],
    thumbnail: json["thumbnail"],
    thumbnailwidth: json["thumbnailwidth"],
    thumbnailheight: json["thumbnailheight"],
  );

  Map<String, dynamic> toJson() => {
    "xlarge": xlarge,
    "xlargewidth": xlargewidth,
    "xlargeheight": xlargeheight,
    "thumbnail": thumbnail,
    "thumbnailwidth": thumbnailwidth,
    "thumbnailheight": thumbnailheight,
  };
}

class Meta {
  int hits;

  Meta({
    required this.hits,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    hits: json["hits"],
  );

  Map<String, dynamic> toJson() => {
    "hits": hits,
  };
}
