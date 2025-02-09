import 'dart:convert';

List<SearchStockModel> searchStockModelFromJson(String str) => List<SearchStockModel>.from(json.decode(str).map((x) => SearchStockModel.fromJson(x)));

String searchStockModelToJson(List<SearchStockModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchStockModel {
  num id;
  String name;
  String symbol;
  String createdAt;
  String updatedAt;
  String alpacaId;
  String exchange;
  String description;
  String assetType;
  String isin;
  String industry;
  String sector;
  String website;
  String address;
  dynamic netZeroProgress;
  num carbonIntensityScope3;
  num carbonIntensityScope1And2;
  num carbonIntensityScope1And2And3;
  String tempAlignmentScopes1And2;
  bool dnshAssessmentPass;
  bool goodGovernanceAssessment;
  bool contributeToEnvironmentOrSocialObjective;
  bool sustainableInvestment;
  num scope1Emissions;
  num scope2Emissions;
  num scope3Emissions;
  num totalEmissions;

  String marketCap;
  Image image;

  SearchStockModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.createdAt,
    required this.updatedAt,
    required this.alpacaId,
    required this.exchange,
    required this.description,
    required this.assetType,
    required this.isin,
    required this.industry,
    required this.sector,
    required this.website,
    required this.address,
    required this.netZeroProgress,
    required this.carbonIntensityScope3,
    required this.carbonIntensityScope1And2,
    required this.carbonIntensityScope1And2And3,
    required this.tempAlignmentScopes1And2,
    required this.dnshAssessmentPass,
    required this.goodGovernanceAssessment,
    required this.contributeToEnvironmentOrSocialObjective,
    required this.sustainableInvestment,
    required this.scope1Emissions,
    required this.scope2Emissions,
    required this.scope3Emissions,
    required this.totalEmissions,
    required this.marketCap,
    required this.image,
  });

  factory SearchStockModel.fromJson(Map<String, dynamic> json) => SearchStockModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        symbol: json["symbol"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
        alpacaId: json["alpaca_id"] ?? '',
        exchange: json["exchange"] ?? '',
        description: json["description"] ?? '',
        assetType: json["asset_type"] ?? '',
        isin: json["isin"] ?? '',
        industry: json["industry"] ?? '',
        sector: json["sector"] ?? '',
        website: json["website"] ?? '',
        address: json["address"] ?? '',
        netZeroProgress: json["net_zero_progress"],
        carbonIntensityScope3: json["carbon_intensity_scope_3"] ?? 0,
        carbonIntensityScope1And2: json["carbon_intensity_scope_1_and_2"] ?? 0,
        carbonIntensityScope1And2And3: json["carbon_intensity_scope_1_and_2_and_3"] ?? 0,
        tempAlignmentScopes1And2: json["temp_alignment_scopes_1_and_2"] ?? '',
        dnshAssessmentPass: json["dnsh_assessment_pass"] ?? false,
        goodGovernanceAssessment: json["good_governance_assessment"] ?? false,
        contributeToEnvironmentOrSocialObjective: json["contribute_to_environment_or_social_objective"] ?? false,
        sustainableInvestment: json["sustainable_investment"] ?? false,
        scope1Emissions: json["scope_1_emissions"] ?? 0,
        scope2Emissions: json["scope_2_emissions"] ?? 0,
        scope3Emissions: json["scope_3_emissions"] ?? 0,
        totalEmissions: json["total_emissions"] ?? 0,
        marketCap: json["market_cap"] ?? '',
        image: Image.fromJson(json["image"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "symbol": symbol,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "alpaca_id": alpacaId,
        "exchange": exchange,
        "description": description,
        "asset_type": assetType,
        "isin": isin,
        "industry": industry,
        "sector": sector,
        "website": website,
        "address": address,
        "net_zero_progress": netZeroProgress,
        "carbon_intensity_scope_3": carbonIntensityScope3,
        "carbon_intensity_scope_1_and_2": carbonIntensityScope1And2,
        "carbon_intensity_scope_1_and_2_and_3": carbonIntensityScope1And2And3,
        "temp_alignment_scopes_1_and_2": tempAlignmentScopes1And2,
        "dnsh_assessment_pass": dnshAssessmentPass,
        "good_governance_assessment": goodGovernanceAssessment,
        "contribute_to_environment_or_social_objective": contributeToEnvironmentOrSocialObjective,
        "sustainable_investment": sustainableInvestment,
        "scope_1_emissions": scope1Emissions,
        "scope_2_emissions": scope2Emissions,
        "scope_3_emissions": scope3Emissions,
        "total_emissions": totalEmissions,
        "market_cap": marketCap,
        "image": image.toJson(),
      };
}

class Image {
  num id;
  String name;
  dynamic alternativeText;
  dynamic caption;
  num width;
  num height;
  Formats formats;
  String hash;
  String ext;
  String mime;
  num size;
  String url;
  dynamic previewUrl;
  String provider;
  dynamic providerMetadata;
  String folderPath;
  String createdAt;
  String updatedAt;

  Image({
    required this.id,
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.providerMetadata,
    required this.folderPath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"] ?? 0,
        name: json["name"] ?? '',
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"] ?? 0,
        height: json["height"] ?? 0,
        formats: Formats.fromJson(json["formats"] ?? {}),
        hash: json["hash"] ?? '',
        ext: json["ext"] ?? '',
        mime: json["mime"] ?? '',
        size: json["size"] ?? 0,
        url: json["url"] ?? '',
        previewUrl: json["previewUrl"],
        provider: json["provider"] ?? '',
        providerMetadata: json["provider_metadata"],
        folderPath: json["folderPath"] ?? '',
        createdAt: json["createdAt"] ?? '',
        updatedAt: json["updatedAt"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats.toJson(),
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "folderPath": folderPath,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };
}

class Formats {
  Thumbnail thumbnail;

  Formats({
    required this.thumbnail,
  });

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Thumbnail.fromJson(json["thumbnail"] ?? {}),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
      };
}

class Thumbnail {
  String ext;
  String url;
  String hash;
  String mime;
  String name;
  dynamic path;
  num size;
  num width;
  num height;
  num sizeInBytes;

  Thumbnail({
    required this.ext,
    required this.url,
    required this.hash,
    required this.mime,
    required this.name,
    required this.path,
    required this.size,
    required this.width,
    required this.height,
    required this.sizeInBytes,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        ext: json["ext"] ?? '',
        url: json["url"] ?? '',
        hash: json["hash"] ?? '',
        mime: json["mime"] ?? '',
        name: json["name"] ?? '',
        path: json["path"],
        size: json["size"] ?? 0,
        width: json["width"] ?? 0,
        height: json["height"] ?? 0,
        sizeInBytes: json["sizeInBytes"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "ext": ext,
        "url": url,
        "hash": hash,
        "mime": mime,
        "name": name,
        "path": path,
        "size": size,
        "width": width,
        "height": height,
        "sizeInBytes": sizeInBytes,
      };
}
