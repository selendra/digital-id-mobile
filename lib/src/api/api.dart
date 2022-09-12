class Api {

  static final String _githubApi = "https://api.github.com/repos/DaveatCor/bitriel_data/contents/";

  // Get all data on the contract of Organization
  static final String _allOrg = "https://id.kumandra.org/api/dids";

  // Get data of an account
  static final String _accData = "https://id.kumandra.org/api/assetsOf?address=";

  static final String _ipfsAPi = "https://gateway.kumandra.org";

  /*---------------------Getter---------------------*/

  /// Get Github Api
  static get githubApi => _githubApi;
  ///
  /// Get All Organization Api
  static get allOrgApi => _allOrg;
  ///
  /// Get All Organization Api
  static get assetOf => _accData;
  ///
  /// Get All Organization Api
  static get getAdd => _accData;
  ///
  /// Get All Organization Api
  static get ipfsApi => _ipfsAPi;
  
}