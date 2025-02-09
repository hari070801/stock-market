import 'dart:convert';

StockDetailsModel stockDetailsModelFromJson(String str) => StockDetailsModel.fromJson(json.decode(str));

String stockDetailsModelToJson(StockDetailsModel data) => json.encode(data.toJson());

class StockDetailsModel {
  num id;
  String name;
  String symbol;
  String createdAt;
  String updatedAt;
  String alpacaId;
  String exchange;
  dynamic description;
  String assetType;
  dynamic isin;
  dynamic industry;
  dynamic sector;
  dynamic employees;
  dynamic website;
  dynamic address;
  dynamic netZeroProgress;
  dynamic carbonIntensityScope3;
  dynamic carbonIntensityScope1And2;
  dynamic carbonIntensityScope1And2And3;
  dynamic tempAlignmentScopes1And2;
  dynamic dnshAssessmentPass;
  dynamic goodGovernanceAssessment;
  dynamic contributeToEnvironmentOrSocialObjective;
  dynamic sustainableInvestment;
  dynamic scope1Emissions;
  dynamic scope2Emissions;
  dynamic scope3Emissions;
  dynamic totalEmissions;
  DateTime listingDate;
  dynamic marketCap;
  num price;
  num changePercent;
  List<dynamic> holdings;
  List<dynamic> sectorAllocation;
  int sustainableInvestmentHoldingPercentage;
  bool inPortfolio;

  StockDetailsModel({
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
    required this.employees,
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
    required this.listingDate,
    required this.marketCap,
    required this.price,
    required this.changePercent,
    required this.holdings,
    required this.sectorAllocation,
    required this.sustainableInvestmentHoldingPercentage,
    required this.inPortfolio,
  });

  factory StockDetailsModel.fromJson(Map<String, dynamic> json) => StockDetailsModel(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        alpacaId: json["alpaca_id"],
        exchange: json["exchange"],
        description: json["description"],
        assetType: json["asset_type"],
        isin: json["isin"],
        industry: json["industry"],
        sector: json["sector"],
        employees: json["employees"],
        website: json["website"],
        address: json["address"],
        netZeroProgress: json["net_zero_progress"],
        carbonIntensityScope3: json["carbon_intensity_scope_3"],
        carbonIntensityScope1And2: json["carbon_intensity_scope_1_and_2"],
        carbonIntensityScope1And2And3: json["carbon_intensity_scope_1_and_2_and_3"],
        tempAlignmentScopes1And2: json["temp_alignment_scopes_1_and_2"],
        dnshAssessmentPass: json["dnsh_assessment_pass"],
        goodGovernanceAssessment: json["good_governance_assessment"],
        contributeToEnvironmentOrSocialObjective: json["contribute_to_environment_or_social_objective"],
        sustainableInvestment: json["sustainable_investment"],
        scope1Emissions: json["scope_1_emissions"],
        scope2Emissions: json["scope_2_emissions"],
        scope3Emissions: json["scope_3_emissions"],
        totalEmissions: json["total_emissions"],
        listingDate: DateTime.parse(json["listing_date"]),
        marketCap: json["market_cap"],
        price: json["price"] ?? 0,
        changePercent: json["change_percent"] ?? 0,
        holdings: List<dynamic>.from(json["holdings"].map((x) => x)),
        sectorAllocation: List<dynamic>.from(json["sector_allocation"].map((x) => x)),
        sustainableInvestmentHoldingPercentage: json["sustainable_investment_holding_percentage"],
        inPortfolio: json["in_portfolio"],
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
        "employees": employees,
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
        "listing_date": "${listingDate.year.toString().padLeft(4, '0')}-${listingDate.month.toString().padLeft(2, '0')}-${listingDate.day.toString().padLeft(2, '0')}",
        "market_cap": marketCap,
        "price": price,
        "change_percent": changePercent,
        "holdings": List<dynamic>.from(holdings.map((x) => x)),
        "sector_allocation": List<dynamic>.from(sectorAllocation.map((x) => x)),
        "sustainable_investment_holding_percentage": sustainableInvestmentHoldingPercentage,
        "in_portfolio": inPortfolio,
      };
}
