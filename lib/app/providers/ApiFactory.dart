// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'Const.dart';

// import '../modules/OperationalFPC/DailyFPCModel.dart';

class ApiFactory {
  static String userId = "";
  static String LOCAL_URL = "http://localhost:9999";
  static String Enviroment =
      const String.fromEnvironment('ENV', defaultValue: 'dev');

  // static String SERVER_URL = "https://bmswebfrontend-uat.azurewebsites.net";
  static String WEB_URL = Const.getWebProgrammingUrl();
  static String WEB_URL_COMMON = Const.getWebCommonUrl();
  static String LOGIN_URL = Const.getWebLoginUrl();

  static String BASE_URL = Const.getBaseCreditControlAPIUrl();
  static String BASE_URL_COMMON = Const.getBaseCommonAPIUrl();
  static String BASE_URL_LOGIN = Const.getBaseLoginAPIUrl();

  // api-login-bms-dev.zeeconnect.in
  // api-common-bms-dev.zeeconnect.in
  // api-programming-bms-dev.zeeconnect.in

  static String AZURE_REDIRECT_UI =
      "${kReleaseMode ? WEB_URL : LOCAL_URL}/dashboard";
  static String NOTIFY_URL = (kReleaseMode ? WEB_URL_COMMON : LOCAL_URL);
  static String SPLIT_CLEAR_PAGE = (kReleaseMode ? "in/" : "92/");

  static String MS_TOKEN =
      "https://login.microsoftonline.com/56bd48cd-f312-49e8-b6c7-7b5b926c03d6/oauth2/token";

  static String LOGIN_API = "$BASE_URL_LOGIN/api/Login/GetLogin?";
  static String LOGOUT_API = "$BASE_URL_LOGIN/api/Login/GetLogout?PersonnelNo=";
  static String USER_INFO = "$BASE_URL_LOGIN/api/Login/GetUserinfo";
  static String PERMISSION_API =
      "$BASE_URL_COMMON/api/MDI/GetAllFormDetailsAndPermission?Userid=";
  static String MS_PROFILE = "$BASE_URL_LOGIN/api/Login/PostUserProfile";
  static String MS_TOKEN_BACKEND = "$BASE_URL_LOGIN/api/Login/PostApiToken";
  static String MS_TOKEN1 =
      "https://login.microsoftonline.com/56bd48cd-f312-49e8-b6c7-7b5b926c03d6/oauth2/v2.0/token";
  static String MS_AUTH =
      "https://login.microsoftonline.com/56bd48cd-f312-49e8-b6c7-7b5b926c03d6/oauth2/v2.0/token";

  // static String MS_GRAPH_USER_DETAILS = "https://graph.microsoft.com/v1.0/me?\$select=employeeId,mail,givenName";
  static String MS_GRAPH_USER_DETAILS =
      "https://graph.microsoft.com/v1.0/me?\$select=employeeId,mail,givenName,jobTitle,givenName,id,mobilePhone,displayName";
  static String MS_LOGOUT =
      "https://login.microsoftonline.com/common/oauth2/v2.0/logout?post_logout_redirect_uri=";

  /*static String PERMISSION_API =
      BASE_URL + "/api/MDI/GetAllFormDetailsAndPermission?Userid=";
*/
///////////////////////XML Download API////////////////////////
  static String EXPORT_TO_XML = "$BASE_URL_COMMON/api/Common/ConvertTableToXml";
  static String EXPORT_TO_EXCEL =
      "$BASE_URL_COMMON/api/Common/ConvertJsonToExcel";
  static String CONVERT_TO_PDF =
      "$BASE_URL_COMMON/api/Common/ConvertTableToPDF";

  ////////////////////// DOCS /////////////////////////////

  static String COMMON_DOCS_LOAD(String docKey) =>
      "$BASE_URL_COMMON/api/CommonDoc/loadDocument?DocumentKey=$docKey";

  static String COMMON_DOCS_VIEW(String docId) =>
      "$BASE_URL_COMMON/api/CommonDoc/ViewDocument?DocId=$docId";

  static String get COMMON_DOCS_ADD =>
      "$BASE_URL_COMMON/api/CommonDoc/AddDocument";

  static String COMMON_DOCS_DELETE(String docId) =>
      "$BASE_URL_COMMON/api/CommonDoc/DeleteDocument?DocumentID=$docId";
  static String USER_SETTINGS = "$BASE_URL_COMMON/api/MDI/SaveUserSettingData";
  static String FETCH_USER_SETTING = "$BASE_URL_COMMON/api/MDI/GetUserSetting";

  ////////////////////// SEARCH ////////////////////////////
  ///
  ///
  ///

  static String SEARCH_SEND_NAME(
    String mail,
    String pageName,
  ) {
    var currentDate =
        DateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(DateTime.now());
    return "$BASE_URL_COMMON/api/MDI/SaveApplicationPagesFootprintData?UserName=$mail&PageName=$pageName&AccessDate=$currentDate";
  }

  static String SEARCH_VARIANCE(
      {required String viewName,
      required String screenName,
      required String loginCode}) {
    // return BASE_URL + "/api/$screenName/SearchVariance/$viewName";
    return "$BASE_URL_COMMON/api/CommonSearch/SearchVariance/$viewName";
  }

  static String SEARCH_BINDGRID(
      {required String viewName,
      required String screenName,
      required String code}) {
    // return BASE_URL + "/api/$screenName/BindGrid/$viewName,$code";
    return "$BASE_URL_COMMON/api/CommonSearch/BindGrid/$viewName,$code";
  }

  static String SEARCH_MASTER_SEARCH({
    required String name,
    required String valuecolumnname,
    required String TableName,
    required bool chkLikeNotLike,
    required String searchvalue,
    required String screenName,
  }) {
    // return BASE_URL + "/api/$screenName/TextSearch?name=$name&valuecolumnname=$valuecolumnname&TableName=$TableName&chkLikeNotLike=$chkLikeNotLike&searchvalue=$searchvalue";
    return "$BASE_URL_COMMON/api/CommonSearch/TextSearch?name=$name&valuecolumnname=$valuecolumnname&TableName=$TableName&chkLikeNotLike=$chkLikeNotLike&searchvalue=$searchvalue";
  }

  static String SEARCH_EXECUTE_SEARCH({
    required String strViewName,
    required String loginCode,
    required String screenName,
  }) {
    // return BASE_URL + "/api/$screenName/SearchExecute?strViewName=$strViewName";
    return "$BASE_URL_COMMON/api/CommonSearch/SearchExecute?strViewName=$strViewName";
  }

  // static String SEARCH_PIVOT({required String screenName,}) => BASE_URL + "/api/$screenName/SearchPivot";
  static String SEARCH_PIVOT({
    required String screenName,
  }) =>
      "$BASE_URL_COMMON/api/CommonSearch/SearchPivot";

  // static String SEARCH_EXCUTE_PIVOT({required String screenName, required String strViewname,}) => BASE_URL + "/api/$screenName/SearchExecutePivot?strViewName=$strViewname";
  static String SEARCH_EXCUTE_PIVOT({
    required String screenName,
    required String strViewname,
  }) =>
      "$BASE_URL_COMMON/api/CommonSearch/SearchExecutePivot?strViewName=$strViewname";

  static String ADD_SEARCH_VARIANCE({
    required String strViewName,
    required String loginCode,
    required String screenName,
    required String sVariant,
    // required String pivotTemplate,
  }) {
    // return BASE_URL + "/api/$screenName/InsertSearchVariance?strViewName=$strViewName&sVariant=$sVariant";
    return "$BASE_URL_COMMON/api/CommonSearch/InsertSearchVariance?strViewName=$strViewName&sVariant=$sVariant";
  }

  static String DELETE_SEARCH_VARIANCE({
    required String varianceId,
    required String loginCode,
    required String screenName,
  }) {
    // return BASE_URL + "/api/$screenName/DeleteSearchVariance?VarianceId=$varianceId";
    return "$BASE_URL_COMMON/api/CommonSearch/DeleteSearchVariance?VarianceId=$varianceId";
  }

  /////////////////////////////////////////////////////////
  //////////////////////////// Link Song To Program Template /////////////////////////////////

  static String LINK_PROGRAM_TO_SONG_GET_LOCATION =
      "$BASE_URL/api/LinkProgramToSongTemplate/GetLocationListForUser";

  static String LINK_PROGRAM_TO_SONG_GET_CHANNEL({
    required String locationCode,
  }) {
    return "$BASE_URL/api/LinkProgramToSongTemplate/GetChannelListForUserAndLocation?LocationCode=$locationCode";
  }

  static String LINK_PROGRAM_TO_SONG_GetProgramSongTemplate({
    required String locationCode,
    required String channelCode,
    required String fromDate,
    required String toDate,
  }) {
    return "$BASE_URL/api/LinkProgramToSongTemplate/GetProgramSongTemplate?LocationCode=$locationCode&ChannelCode=$channelCode&FromDate=$fromDate&ToDate=$toDate";
  }

  static String LINK_PROGRAM_TO_SONG_SAVE =
      "$BASE_URL/api/LinkProgramToSongTemplate/Save";

///////////////////////////////////////////////////////////////////////////////////////////
////////////////////////// Create Break Pattern ///////////////////////////////////////////
  static String CREATE_BREAK_PATTERN_INIT =
      "$BASE_URL/api/CreateBreakPattern/Initialize";

  static String CREATE_BREAK_PATTERN_GET_CHANNEL({
    required String locationCode,
  }) {
    return "$BASE_URL/api/CreateBreakPattern/GetChannelListForUserAndLocation?locationCode=$locationCode";
  }

  static String CREATE_BREAK_PATTERN_GET_DATA({
    required String locationCode,
    required String channelCode,
    required String fromDate,
    required String toDate,
  }) {
    return "$BASE_URL/api/CreateBreakPattern/OnToDateSelected?LocationCode=$locationCode&ChannelCode=$channelCode&FromDate=$fromDate&ToDate=$toDate";
  }

  static String CREATE_BREAK_PATTERN_UPDATE_TRANSTIME({
    required String dayStart,
    required int? commercialTime,
    required bool updateStatus,
  }) {
    return "$BASE_URL/api/CreateBreakPattern/UpdateTransmissionTime?DayStart=$dayStart&CommercialTime=${commercialTime ?? ""}&UpdateStatus=$updateStatus";
  }

  static String CREATE_BREAK_PATTERN_MultiAggregate =
      "$BASE_URL/api/CreateBreakPattern/MultiAggregate";
  static String CREATE_BREAK_PATTERN_SAVE_SEGMENTS =
      "$BASE_URL/api/CreateBreakPattern/SaveSegment";
  static String CREATE_BREAK_PATTERN_SAVE_BREAK_PATTERN =
      "$BASE_URL/api/CreateBreakPattern/Save";

  static String CREATE_BREAK_PATTERN_BREAK_FILE({
    required String locationCode,
    required String channelCode,
    required String fromDate,
    required String toDate,
  }) {
    return "$BASE_URL/api/CreateBreakPattern/Break?LocationCode=$locationCode&ChannelCode=$channelCode&FromDate=$fromDate&ToDate=$toDate";
  }

//////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////Pending TC & Technical Check: UI: Sanjaya Jena API: Patta Nigam////////////////////////////////////////////////////////////////////////

  static String PENDING_TC_MASTER =
      "$BASE_URL/api/TechnicalCheck/PendingTCInfo?PersonnelNo=";

  static String PENDING_TC_LIST(
      {required String frmDt,
      required String toDt,
      required String contentType,
      String? branchCode}) {
    return "$BASE_URL/api/TechnicalCheck/PendingTCList/$frmDt,$toDt,$contentType,$branchCode";
  }

  static String TECHNICAL_CHECK_MASTER =
      "$BASE_URL/api/TechnicalCheck/GetInfoLoad/0";

// START --> Contnet Inward

  static String CI_DASHBOARD_INTIAL_DATA =
      "$BASE_URL/api/cidashboard/GetInit?PersonnelNo=";

  static String CI_DASHBOARD_PROGRAM_SEARCH =
      "$BASE_URL/api/cidashboard/GetProgram?search=";

  static String CI_DASHBOARD_PROGRAM_SEARCH1 =
      "$BASE_URL/api/cidashboard/GetProgram1?search=";

  static String CI_DASHBOARD_REPORT = "$BASE_URL/api/cidashboard/GetReport";

  static String CI_INWARD_INTIAL_DATA = "$BASE_URL/api/ciInward/Initialise";

  static String CI_INWARD_DATA =
      "$BASE_URL/api/ciInward/GetInwardDetails?InwardCode=";
  static String TECHNICAL_CHECK_SAVE = "$BASE_URL/api/TechnicalCheck/TCSave";

  static String TECHNICAL_CHECK_GET_TC_DATA =
      "$BASE_URL/api/TechnicalCheck/TCNoSelect";

  static String TECHNICAL_CHECK_GET_FAULTDESC =
      "$BASE_URL/api/TechnicalCheck/FaultCategorySelect";

  static String TECHNICAL_CHECK_MASTER1(
      {required String programName,
      required String contentType,
      required String epNo,
      required String inWardCode}) {
    return "$BASE_URL/api/TechnicalCheck/InfoPopulate?ProgramName=$programName&ContentType=$contentType&EpisodeNumber=$epNo&InwardCode=$inWardCode";
  }

////////////////////////////////////////////////////End Pending TC & Technical Check//////////////////////////////////////////////////////////

  static String CI_BMS_PH_DATA =
      "$BASE_URL/api/ciInward/GetPHAndBMSProgram?ProgramCode=";

  static String CI_DASHBOARD_SENDMAIL({
    required int tcNo,
    required String tcStatus,
    required bool resendmail,
  }) {
    return "${BASE_URL}api/cidashboard/SendEmail?TCNo=$tcNo&TCStatus=$tcStatus&ResendMail=$resendmail";
  }

  static String CI_SAVE_FORM = "$BASE_URL/api/ciInward/Save";

// END --> Contnet Inward

  /////////////////////////////////////////////////////////////////////////////////////////

  ////////////////Operatonal FPC Page: UI-> Shreesh Tiwari API-> Ram P Kubde//////////////

  static String OPERATIONAL_FPC_INITIAL_DATA({required String loginId}) {
    return "$BASE_URL/api/DailyFPCReport/DailyFPCInitialise?Userid=$loginId";
  }

  static String OPERATIONAL_FPC_GET_CHANNELS_ON_LOCATION_SELECT(
      {required String loginCode, required String location}) {
    return "$BASE_URL/api/DailyFPCReport/GetChannelAfterLoctionLoad?Userid=$loginCode&LocationCode=$location";
  }

  static String OPERATIONAL_FPC_PROGRAM_SEARCH =
      "$BASE_URL/api/DailyFPCReport/ProgramSearch?SearchText=";

  static String OPERATIONAL_FPC_DAILY_FPC_LIST(
      {required String locationCode,
      required String channelCode,
      required String date}) {
    return '$BASE_URL/api/dailyfpcreport/DailyFpcByDateString?LocationCode=$locationCode&ChannelCode=$channelCode&TelecastDate=$date';
  }

  static String OPERATIONAL_FPC_SEGMENT_LIST(
      {required String locationCode,
      required String channelCode,
      required String fpcDuration}) {
    return '$BASE_URL/api/dailyfpcreport/GetBarbDefaultSegment?LocationCode=$locationCode&ChannelCode=$channelCode&FPCDuration=$fpcDuration';
  }

  // static String OPERATIONAL_FPC_SEGMENT_LIST1(
  //     {required String locationCode, required String channelCode, required String date, required DailyFPCModel model}) {
  //   return '$BASE_URL/api/dailyfpcreport/GetSegmentDetails?ProgramCode=${model.programCode}&ExporttapeCode=${model.tapeid}&EpisodeNumber=${model.epsNo.toString()}&OriginalRepeatCode=${model.oriRepCode}&LocationCode=$locationCode&ChannelCode=$channelCode&StartTime=${model.fpcTime}&TelecastDate=$date';
  // }

  // epg API
  static String OPERATIONAL_FPC_GET_EPG(
      {required String locationCode,
      required String channelCode,
      required String programCode}) {
    return '$BASE_URL/api/dailyfpcreport/GetEpgProgramList?LocationCode=$locationCode&ChannelCode=$channelCode&ProgramCode=$programCode';
  }

  static String OPERATIONAL_FPC_GET_DEFAULT_SEGMENT_LIST_LC(
      {required String locationCode}) {
    return '$BASE_URL/api/dailyfpcreport/GetEuropeDetails?Location=$locationCode';
  }

  static String OPERATIONAL_FPC_GET_DEFAULT_SEGMENT_LIST_EUROPE_DETAILS(
      {required String locationCode,
      required String channelCode,
      required String fpcDuration}) {
    return '$BASE_URL/api/dailyfpcreport/GetEuropeDetailsInfo?LocationCode=$locationCode&ChannelCode=$channelCode&FPCDuration=$fpcDuration';
  }

  static String OPERATIONAL_FPC_SAVE_FPC(
      {required String locationCode,
      required String channelCode,
      // required String fpcDuration,
      required String date,
      required bool isStandby,
      required String programCode,
      required String episodeNumber,
      required String tapeId,
      required String fpcTime,
      required String endTime,
      required String oriRepCode,
      required String isModified}) {
    // return BASE_URL + '/api/dailyfpcreport/SaveDailyFPC?LocationCode=$locationCode&ChannelCode=$channelCode&TelecastDate=$date&ModifiedBy=$userId&StandBy=$isStandby&ProgramCode=$programCode&EpisodeNumber=$episodeNumber&TapeID=$tapeId&FPCTime=$fpcTime:00&EndTime=$endTime:00&OriginalRepeatCode=$oriRepCode&Modifed=$isModified';
    return '$BASE_URL/api/dailyfpcreport/saveDailyFPC_Data?LocationCode=$locationCode&ChannelCode=$channelCode&TelecastDate=$date&ModifiedBy=$userId&StandBy=${isStandby ? "Y" : "N"}&ProgramCode=$programCode&EpisodeNumber=$episodeNumber&TapeID=$tapeId&FPCTime=$fpcTime:00&EndTime=$endTime:00&OriginalRepeatCode=$oriRepCode&Modifed=$isModified';
  }

  static String OPERATIONAL_FPC_SAVE_SEGMENT(
      {required String programCode,
      required String originalRepCode,
      required String tapeId,
      required String segNo,
      required String segCaption,
      required String segDuration,
      required String som}) {
    return '$BASE_URL/api/dailyfpcreport/DefaultSegmentSave?ProgramCode=$programCode&OriginalRepeatCode=$originalRepCode&ExporttapeCode=$tapeId&ModifiedBy=$userId&SegmentNumber=$segNo&ExportTapeCaption=$segCaption&SOM=$som:00&SegmentDuration=$segDuration';
  }

  static String OPERATIONAL_FPC_GetDataAfterProgLoad(
      {required String locationCode,
      required String channelCode,
      required String programCode}) {
    return '$BASE_URL/api/dailyfpcreport/GetDataAfterProgLoad?LocationCode=$locationCode&ChannelCode=$channelCode&ProgramCode=$programCode';
  }

  static String OPERATIONAL_FPC_NEXT_EP(
      {required String locationCode,
      required String channelCode,
      required String teleDate,
      required String orgRepCode,
      required String programCode}) {
    return '$BASE_URL/api/dailyfpcreport/GetNextEpisodeNumber?LocationCode=$locationCode&ChannelCode=$channelCode&TelecastDate=$teleDate&ProgramCode=$programCode&OrgRepCode=$orgRepCode';
  }

  static String OPERATIONAL_FPC_GET_TAPE_ID(
      {required int ep,
      required String orgRepCode,
      required String programCode}) {
    return '$BASE_URL/api/dailyfpcreport/GetTapeId?ProgramCode=$programCode&EpisodeNo=$ep&OrgRepCode=$orgRepCode';
  }

  static String OPERATIONAL_FPC_SEGMENT_DETAILS(
      {required String locationCode,
      required String channelCode,
      required String date,
      required String epsNo,
      required String programCode,
      required String originalRepCode,
      required String tapeId,
      required String som}) {
    return '$BASE_URL/api/dailyfpcreport/GetSegmentDetails?ProgramCode=$programCode&ExporttapeCode=$tapeId&EpisodeNumber=$epsNo&OriginalRepeatCode=$originalRepCode&LocationCode=$locationCode&ChannelCode=$channelCode&StartTime=$som&TelecastDate=$date';
  }

  static String OPERATIONAL_FPC_DELETE_SEGMENTS({
    required String programCode,
  }) {
    return '$BASE_URL/api/dailyfpcreport/DeleteDefaultSegmentDetails?ProgramCode=$programCode';
  }

  static String OPERATIONAL_FPC_VALIDATE_ON_SAVE({
    required String locationCode,
    required String channelCode,
    required String date,
  }) {
    return '$BASE_URL/api/dailyfpcreport/GetValidateSaveData?LocationCode=$locationCode&ChannelCode=$channelCode&TelecastDate=$date';
  }

  static String OPERATIONAL_FPC_VALIDATE_ON_SAVE1({
    required String locationCode,
    required String channelCode,
    required String date,
  }) {
    return '$BASE_URL/api/DailyFPCReport/GetValidateFPCData';
  }

  static String OPERATIONAL_FPC_VALIDATE_ON_SAVE2({
    required String locationCode,
    required String channelCode,
    required String date,
    required String rowNo,
    required String progCode,
    required String langCode,
    required String orgRepCode,
    required String progTypCode,
    required String epsDur,
    required String fpcTime,
    required String endTime,
    required String progName,
    required String epsNo,
    required String tapeId,
    required String status,
    required String orgRep,
    required String wbs,
    required String caption,
    required String modified,
  }) {
    return '$BASE_URL/api/DailyFPCReport/GetValidateFPCData?locationCode=$locationCode&channelCode=$channelCode&telecastDate=$date&RowNo=$rowNo&ProgramCode=$progCode&LanguageCode=$langCode&OriginalRepeatCode=$orgRepCode&ProgramTypeCode=$progTypCode&EpisodeDuration=$epsDur&FpcTime=$fpcTime&endtime=$endTime&ProgramName=$progName&EpsNo=$epsNo&Tapeid=$tapeId&Status=$status&OriRep=$orgRep&WBS=$wbs&Caption=$caption&Modifed=$modified&OriRepCode=$orgRepCode';
  }

  ////////////////////////////////////////////////////End Operational FPC Page//////////////////////////////////////////////////////////
  ////////////////////////////// START OF ZONE MASTER API///////////////////////////////////
  static String get ZONE_MASTER_INITALIZE =>
      "$BASE_URL/api/ZoneMaster/ZoneMasterInitialise";

  static String ZONE_MASTER_SAVE(
    String zoneCode,
    String zoneName,
    String shortName,
    String startSeries,
    String bShortName,
    String sapSales,
  ) =>
      "$BASE_URL/api/ZoneMaster/SaveZoneMaster?ZoneCode=$zoneCode&ZoneName=$zoneName&ShortName=$shortName&StartSeries=$startSeries&BShortName=$bShortName&SAPSales=$sapSales";

  ////////////////////////////// END OF ZONE MASTER API///////////////////////////////////

  ////////////////////////////// START ZONE WISE COMMERCIAL TIME ALLOCATION/////////////
  static String get ZONE_WISE_COMMERCIAL_TIME_ALLOC_LOCATION_LOAD =>
      "$BASE_URL/api/ZonewiseCommercialTimeAllocation/Location_Load";

  static String get ZONE_WISE_COMMERCIAL_TIME_ALLOC_GET_ALL_CHANNELS =>
      "$BASE_URL/api/ZonewiseCommercialTimeAllocation/Channel_Load";

  static String ZONE_WISE_COMMERCIAL_TIME_ALLOC_GET_CHANNELS_ON_LEAVE(
          String locationCode, String loggedUser) =>
      "$BASE_URL/api/ZonewiseCommercialTimeAllocation/Locations_Leave?LocationCode=$locationCode&LoggedUser=$loggedUser";

  static String ZONE_WISE_COMMERCIAL_TIME_ALLOC_GET_ALL_DISPLAY_RECORD(
          String locationCode, String channelCode) =>
      "$BASE_URL/api/ZonewiseCommercialTimeAllocation/DisplayRecord?LocationCode=$locationCode&ChannelCode=$channelCode";

  static String ZONE_WISE_COMMERCIAL_TIME_ALLOC_SAVE_DATA(
          String locationCode, String channelCode) =>
      "$BASE_URL/api/ZonewiseCommercialTimeAllocation/SaveRecord?LocationCode=$locationCode&ChannelCode=$channelCode";

  ////////////////////////////// END ZONE WISE COMMERCIAL TIME ALLOCATION//////////////
  ///
  ///
  ///////////////////////////// START LOCATION MASTER API///////////////////
  static String LOCATION_MASTER_INITALIZE_CURRENCY =
      "$BASE_URL/api/LocationMaster/FillCurrencyTypeMaster";
  static String LOCATION_MASTER_INITALIZE_TERRITORY =
      "$BASE_URL/api/LocationMaster/FillTerritoryMaster";

  static String LOCATION_MASTER_FETCH_LOCATION(String keyword) =>
      "$BASE_URL/api/LocationMaster/LocationName_leave?LocationName=$keyword";

  // static String LOCATION_MASTER_FETCH_SHORT_NAME({String? locationCode, required String keyword}) =>
  //     "$BASE_URL/api/LocationMaster/ShortName_Leave?ShortName=$keyword${locationCode != null ? "&TextBoxShortName=$locationCode" : ""}";

  static String LOCATION_MASTER_FETCH_SHORT_NAME(String shortName) =>
      "$BASE_URL/api/LocationMaster/ShortName_Leave?ShortName=$shortName";

  // static String LOCATION_MASTER_FETCH_SAP_OFFICE({String? locationCode, required String keyword}) =>
  //     "$BASE_URL/api/LocationMaster/SAPSalesOffice_Leave?SAPSalesOffice=$keyword${locationCode != null ? "&LocationCode=$locationCode" : ""}";

  static String LOCATION_MASTER_FETCH_SAP_OFFICE(String sapSales) =>
      "$BASE_URL/api/LocationMaster/SAPSalesOffice_Leave?SAPSalesOffice=$sapSales";

  static String LOCATION_MASTER_SAVE({
    String? locationCode,
    required String locationName,
    required String locationShortName,
    required String currencyCode,
    required int territorycode,
    required String sapSalesOffice,
    required String loginCode,
  }) =>
      "$BASE_URL/api/LocationMaster/LocationSaveRecords?LocationCode=${locationCode ?? ""}&LocationName=$locationName&LocationShortName=$locationShortName&CurrencyCode=$currencyCode&Territorycode=$territorycode&SAPSalesOffice=$sapSalesOffice&ModifiedBy=$loginCode";

  ///////////////////////////// END LOCATION MASTER API///////////////////
  ///
  ///
  //////////////////////////// START ZONE GROUPING API///////////////////
  static String get ZONE_GROUPING_LOCATION =>
      "$BASE_URL/api/ZoneGrouping/Location_Load";

  static String ZONE_GROUPING_CHANNELS(String locationCode) =>
      "$BASE_URL/api/ZoneGrouping/Channel_Load?LocationCode=$locationCode";

  static String ZONE_GROUPING_GET_ALL_GROUPS(
          String locationCode, String channelCode) =>
      "$BASE_URL/api/ZoneGrouping/PopulateGroup?LocationCode=$locationCode&ChannelCode=$channelCode";

  static String ZONE_GROUPING_GET_LEFT_DATATABLE(
          String lc, String cc, String gc) =>
      "$BASE_URL/api/ZoneGrouping/PopulateGroupedZone?LocationCode=$lc&ChannelCode=$cc&GroupCode=$gc";

  static String ZONE_GROUPING_GET_RIHGT_DATATABLE(
          String lc, String cc, String gc) =>
      "$BASE_URL/api/ZoneGrouping/PopulateGroupedZoneLeft?LocationCode=$lc&ChannelCode=$cc&GroupCode=$gc";

  static String ZONE_GROUPING_SAVE_DATA(String lc, String cc, String gc) =>
      "$BASE_URL/api/ZoneGrouping/SaveZoneGrouping?LocationCode=$lc&ChannelCode=$cc&GroupCode=$gc";

  //////////////////////////// END ZONE GROUPING API///////////////////
  ///
  ///
  ///
  ////////////////////////// START CHANNEL MASTER API//////////////////
  static String get CHANNEL_MASTER_GET_LOCATION =>
      "$BASE_URL/api/ChannelMaster/Location_Load";

  static String get CHANNEL_MASTER_GET_CHANNELS =>
      "$BASE_URL/api/ChannelMaster/Channel_Load";

  static String CHANNEL_MASTER_CHANNEL_EVENT_SPECI_LEFT_DATA(
          String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/Get_ChannelSpecs?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_CHANNEL_EVENT_SPECI_RIGHT_DATA(
          String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/EventSpecification?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_CREATE_NEW_CHANNEL_EXIT(
      String channelName, String shortName) {
    return "$BASE_URL/api/ChannelMaster/ShortNameLeave?strShortName=$shortName&ChannelMaster=$channelName";
  }

  static String get CHANNEL_MASTER_SAVE_CREATE_NEW_CHANNEL =>
      "$BASE_URL/api/ChannelMaster/CreateNewChannel";

  static String CHANNEL_MASTER_CREATE_NEW_CHANNEL_GET_ALL_DATA(
          String channelNanme) =>
      "$BASE_URL/api/ChannelMaster/ChannelNameLeave?ChannelName=$channelNanme";

  static String CHANNEL_MASTER_LOG_LEFTDATATABLE_DATA(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/LogSpecificationGrid?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_LOG_1ST_QUERY(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/Get_Excel?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_LOG_2ND_QUERY(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/Get_ExcelOld?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_LOG_3RD_QUERY(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/Get_ExcelNews?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_CHANNEL_BAND_DATA(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/GetBandMaster?LocationCode=$lc&ChannelCode=$cc";

  static String get CHANNEL_MASTER_SAVE_DATA =>
      "$BASE_URL/api/ChannelMaster/ChannelMasterSave";

  static String get CHANNel_MASTER_TIME_BAND_VALIDATION =>
      "$BASE_URL/api/ChannelMaster/Validate";

  static String CHANNEL_MASTER_SAVE_CHANNELEVENTSPECF_RIGHT_TABLE(
          String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/SaveEventSpecs?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_SAVE_CHANNELEVENTSPECF_LEFT_TABLE(
          String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/SaveChannelSpecs?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_SAVE_LOGSPECF_LEFT_TABLE(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/SaveLogSpecs?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_SAVE_LOGSPECF_3QUERY(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/SaveExcelQuery?LocationCode=$lc&ChannelCode=$cc";

  static String CHANNEL_MASTER_SAVE_CHANNEL_BAND(String lc, String cc) =>
      "$BASE_URL/api/ChannelMaster/SaveTimeBand?LocationCode=$lc&ChannelCode=$cc";

  ////////////////////////// END CHANNEL MASTER API//////////////////
  ///
  ///
  ///
  ///
  ////////////////////////// START LOGIN MASTER API ////////////////
  static String get LOGIN_MASTER_GET_LOCATION =>
      "$BASE_URL/api/LoginMaster/GetLocation";

  static String LOGIN_MASTER_GET_LOGGEDUSERCHANNELS(String lc) {
    return "$BASE_URL/api/LoginMaster/GetLoggedUserChannels?LoginCode=$lc";
  }

  static String get LOGIN_MASTER_GET_MODULE =>
      "$BASE_URL/api/LoginMaster/GetModule";

  static String get LOGIN_MASTER_GET_ZONE =>
      "$BASE_URL/api/LoginMaster/GetZone";

  static String get LOGIN_MASTER_GET_BRANCH =>
      "$BASE_URL/api/LoginMaster/GetBranch";

  static String get LOGIN_MASTER_GET_USER_DETAILS =>
      "$BASE_URL/api/LoginMaster/GetUserDetails";

  static String get LOGIN_MASTER_GET_ZONE_1 =>
      "$BASE_URL/api/LoginMaster/GetZoneName1";

  static String get LOGIN_MASTER_GET_USER_LIST =>
      "$BASE_URL/api/LoginMaster/GetUserDetails?SearchValue=";

  static String LOGIN_MASTER_GET_USER_ALL_INFO(String ln,
          {String? lc,
          bool fromCopyRIghts = false,
          bool chkCopyTransactionRights = false,
          bool chkCopyLocationChannelZoneRights = false}) =>
      "$BASE_URL/api/LoginMaster/GetLoginInfo?LoginName=$lc&LoginCode=&iscopy=$fromCopyRIghts&chkCopyTransactionRights=$chkCopyTransactionRights&chkCopyLocationChannelZoneRights=$chkCopyLocationChannelZoneRights";

  static String LOGIN_MASTER_GET_EMPLOYEE_DETAILS(String sapID) =>
      "$BASE_URL/api/LoginMaster/GetEmployeeDetails?SAPID=$sapID";

  static String get LOGIN_MASTER_GET_MODULE_FORM_DETAILS =>
      "$BASE_URL/api/LoginMaster/GetModuleFormDetails";

  static String LOGIN_MASTER_LOCATION_CHANNEL_ZONE_RIGHT_ACTIVE_ZONE(
          String lc, String cd) =>
      "$BASE_URL/api/LoginMaster/GetActiveZoneDetails?LocationCode=$lc&ChannelCode=$cd";

  static String get LOGIN_MASTER_SAVE_ALL_CHANNELS_LOCATIONS_ZONE_RIGHTS =>
      "$BASE_URL/api/LoginMaster/SaveAddChannelAndLocationRight";

  static String get LOGIN_MASTER_SAVE_BUDGET_EMPLOYEE_LOGIN =>
      "$BASE_URL/api/LoginMaster/SaveBudgetEmployeeLogin";

  static String get LOGIN_MASTER_SAVE_TC_INWARD_USER_DETAILS =>
      "$BASE_URL/api/LoginMaster/SaveInwardUserDtls";

  static String get LOGIN_MASTER_SAVE_LOGIN_MASTER =>
      "$BASE_URL/api/LoginMaster/SaveLoginMaster";

  ////////////////////////// END LOGIN MASTER API ////////////////
  ///
  ///
  ///
  ///////////////////////// START MODULE FORM TRANSACTION API//////
  static String get MODULE_FORM_TRANSACTION_GET_MODULE_FORMS_LIST =>
      "$BASE_URL/api/ModuleFormTransaction/Initialisation";

  static String get MODULE_FORM_TRANSACTION_ADD_MODULE_SAVE =>
      "$BASE_URL/api/ModuleFormTransaction/SaveModuleData";

  static String get MODULE_FORM_TRANSACTION_ADD_FORM_SAVE =>
      "$BASE_URL/api/ModuleFormTransaction/SaveFormData";

  static String get MODULE_FORM_TRANSACTION_FORM_DELETE_SAVE =>
      "$BASE_URL/api/ModuleFormTransaction/SaveFormModuleMappingData";

  static String MODULE_FORM_TRANSACTION_GET_MODULE_LIST(String moduleCode) =>
      "$BASE_URL/api/ModuleFormTransaction/GetModuleFormDetails?ModuleCode=$moduleCode";

  ///////////////////////// END MODULE FORM TRANSACTION API//////

//////////////////////////// SECONDARY ASRUN MODIFICATION ////////////////////////////////

  static String get SECONDARY_ASRUN_MODIFICATION_LOCATION =>
      "$BASE_URL/api/SecondaryAsrunModi/GetLocations";

  static String get SECONDARY_ASRUN_MODIFICATION_CHANNEL =>
      "$BASE_URL/api/SecondaryAsrunModi/GetChannels?LocationCode=";

  static String get SECONDARY_ASRUN_MODIFICATION_BIND_GRID =>
      "$BASE_URL/api/SecondaryAsrunModi/GetBindGrid";

  static String get SECONDARY_ASRUN_MODIFICATION_GET_OK =>
      "$BASE_URL/api/SecondaryAsrunModi/GetOkClick?SpotPositionShortName=";

  static String get SECONDARY_ASRUN_MODIFICATION_GET_CLEAR_MISMATCH =>
      "$BASE_URL/api/SecondaryAsrunModi/GetClearmismatch";

  static String get SECONDARY_ASRUN_MODIFICATION_SAVE =>
      "$BASE_URL/api/SecondaryAsrunModi/PostSave";

  ///
  ///
  ///
  /// ////////////////////////// Movie Update ////////////////////////////////
  // static String get MOVIE_UPDATE_GET_LOAD =>
  //     "$BASE_URL/api/MovieUpdate/GetLoad";
  // static String get MOVIE_UPDATE_GET_CHANNEL =>
  //     "$BASE_URL/api/MovieUpdate/GetChannel?LocationCode=";
  // static String get MOVIE_UPDATE_POST_SHOW =>
  //     "$BASE_URL/api/MovieUpdate/GetShow";
  // static String get MOVIE_UPDATE_POST_UNDO_SPOT =>
  //     "$BASE_URL/api/MovieUpdate/PostUndoSpot";

  /// ////////////////////////// Undo Cancelation ////////////////////////////////
  static String get UNDO_CANCELATION_GET_LOAD =>
      "$BASE_URL/api/MovieUpdate/GetLoad";

  static String get UNDO_CANCELATION_GET_CHANNEL =>
      "$BASE_URL/api/MovieUpdate/GetChannel?LocationCode=";

  static String get UNDO_CANCELATION_POST_SHOW =>
      "$BASE_URL/api/MovieUpdate/GetShow";

  static String get UNDO_CANCELATION_POST_UNDO_SPOT =>
      "$BASE_URL/api/MovieUpdate/PostUndoSpot";

  /// ////////////////////////////////Start Client Deals ////////////////////////////////////

  static String get Client_Deal_GET_LOAD => "$BASE_URL/api/ClientDeals/onload";

  // static String get Client_Deal_GET_CHANNEL =>
  //     "$BASE_URL/api/ClientDeals/GetChannel?locationCode=";
  // static String get Client_Deal_GET_CLIENTS =>
  //     "$BASE_URL/api/ClientDeals/GetClients";
  // static String get Client_Deal_GET_CLIENTS_LEAVE =>
  //     "$BASE_URL/api/ClientDeals/ClientLeave";
  // static String get Client_Deal_GET_CHANNEL_LEAVE =>
  //     "$BASE_URL/api/ClientDeals/ChannelLeave";
  // static String get Client_Deal_GET_SUBTYPE =>
  //     "$BASE_URL/api/ClientDeals/GetSubType?accountCode=";
  // static String get Client_Deal_RETRIVE_RECORD =>
  //     "$BASE_URL/api/ClientDeals/RetrieveRecord";
  static String get Client_Deal_GET_CHANNEL =>
      "$BASE_URL/api/ClientDeals/GetChannel?locationCode=";

  static String get Client_Deal_GET_CLIENTS =>
      "$BASE_URL/api/ClientDeals/GetClients";

  static String get Client_Deal_GET_CLIENTS_LEAVE =>
      "$BASE_URL/api/ClientDeals/ClientLeave";

  static String get Client_Deal_GET_CHANNEL_LEAVE =>
      "$BASE_URL/api/ClientDeals/ChannelLeave";

  static String get Client_Deal_GET_DEAL_DATE_LEAVE =>
      "$BASE_URL/api/ClientDeals/dealDateLeave";

  static String get Client_Deal_GET_SUBTYPE =>
      "$BASE_URL/api/ClientDeals/GetSubType?accountCode=";

  static String get Client_Deal_RETRIVE_RECORD =>
      "$BASE_URL/api/ClientDeals/RetrieveRecord";

  static String get Client_Deal_GET_SEARCH_CLIENT =>
      "$BASE_URL/api/ClientDeals/GetSearchClient";

  static String get Client_Deal_GET_SEARCH_DEAL_NUMBERS =>
      "$BASE_URL/api/ClientDeals/GetSearchDealNumbers";

  static String get Client_Deal_GET_AGENCY_LEAVE =>
      "$BASE_URL/api/ClientDeals/AgencyLeave";

  static String get Client_Deal_GET_EACH_VALUE_IMPORT =>
      "$BASE_URL/api/ClientDeals/GetEachValueImport";

  static String get Client_Deal_GET_CLIENT_ADDRESS =>
      "$BASE_URL/api/ClientDeals/GetClientAddress";

  static String get Client_Deal_GET_AGENCY_ADDRESS =>
      "$BASE_URL/api/ClientDeals/GetAgencyAddress";

  static String get Client_Deal_GET_PROGRAM =>
      "$BASE_URL/api/ClientDeals/GetAgencyAddress";

  /// ////////////////////////////////End Client Deals ////////////////////////////////////
  ///
  ///
  ///
  /// ////////////////////////// Start Export Billing FPC Model////////////////////////////////
  static String get START_EXPORT_BILLING_FORM_LOAD =>
      "$BASE_URL/api/ExportbillingfPC/GetFormLoad";

  static String get START_EXPORT_BILLING_DATE_LEAVE =>
      "$BASE_URL/api/ExportbillingfPC/GettodateLeave";

  static String get START_EXPORT_BILLING_GET_GENERATE =>
      "$BASE_URL/api/ExportbillingfPC/GetGenerate";

  /// ////////////////////////// End Export Billing FPC Model////////////////////////////////
  ///
  ///
  ///
  /// ////////////////////////// Start Payment Route Master Model////////////////////////////////
  static String get PAYMENT_ROUTE_MASTER_FORM_LOAD =>
      "$BASE_URL/api/PaymentRouteMaster/GetPaymentRouteMasterLoad";

  static String get PAYMENT_ROUTE_MASTER_COMBO_BOXES =>
      "$BASE_URL/api/PaymentRouteMaster/GetFillComboBoxes";

  static String PAYMENT_ROUTE_MASTER_LOCATION_LEAVE(String locationCode) =>
      "$BASE_URL/api/PaymentRouteMaster/GetLocationLeave?LocationCode=$locationCode";

  static String PAYMENT_ROUTE_MASTER_CHANNEL_LEAVE(
          String locationCode, String channelCode) =>
      "$BASE_URL/api/PaymentRouteMaster/GetChannelNameLeave?LocationCode=$locationCode&ChannelCode=$channelCode";

  static String get PAYMENT_ROUTE_MASTER_POST_SAVE_RECORD =>
      "$BASE_URL/api/PaymentRouteMaster/PostSaveRecord";

  static String get PAYMENT_ROUTE_MASTER_GET_SERVICE_LOCATION =>
      "$BASE_URL/api/PaymentRouteMaster/GetServiceLocationList";

  static String PAYMENT_ROUTE_MASTER_SERVICE_CHANNEL(String locationCode) =>
      "$BASE_URL/api/PaymentRouteMaster/GetServicechannelList?LocationCode=$locationCode";

  static String PAYMENT_ROUTE_MASTER_GET_SERVICE_RETRIEVE(
          String locationName, String channelName) =>
      "$BASE_URL/api/PaymentRouteMaster/GetSeriveRetrieve?LocationName=${Uri.encodeQueryComponent(locationName)}&ChannelName=${Uri.encodeQueryComponent(channelName)}";

  static String PAYMENT_ROUTE_MASTER_GET_RETRIEVE_RECORD(
          String payRouteCode, String payRouteName) =>
      "$BASE_URL/api/PaymentRouteMaster/GetRetrieveRecord?PayRouteCode=$payRouteCode&PayRouteName=${Uri.encodeQueryComponent(payRouteName)}";

  /// ////////////////////////// End Payment Route Master Model////////////////////////////////

  /// //////////////////////////START GST PLANT INFO //////////////////////////
  static String get GST_PLANT_INFO_LOAD =>
      "$BASE_URL/api/GstPlantInfo/GetGstPlantInfoLoad";

  static String get GST_PLANT_INFO_SAVE =>
      "$BASE_URL/api/GstPlantInfo/PostSave";

  /// //////////////////// Place Type Master //////////////////////////
  static String get PLACE_TYPE_MASTER_GET_RETRIEVE_RECORD =>
      "$BASE_URL/api/PlaceTypeMaster/GetRetrieveRecord";

  static String get PLACE_TYPE_MASTER_POST_SAVE =>
      "$BASE_URL/api/PlaceTypeMaster/PostSave";

  /// //////////////// Deal Report //////////////////////
  static String get DEAL_REPORT_LOAD =>
      "$BASE_URL/api/DealReport/GetDealReportOnLoad";

  static String get DEAL_REPORT_CHANNEL_LEAVE =>
      "$BASE_URL/api/DealReport/GetChannelLeave";

  static String get DEAL_REPORT_CLIENT_LEAVE =>
      "$BASE_URL/api/DealReport/GetClientLeave";

  static String get DEAL_REPORT_CLIENT_GENERATE =>
      "$BASE_URL/api/DealReport/GetGenrate";

  /// //////////////////////////END GST PLANT INFO //////////////////////////
  ///
  ///
  ///

  /// //////////////////////////////// Payroute category Master ////////////////////////////////////
  static String PAYROUTE_CATEGORY_MASTER_GET_RECORD(String categoryName) =>
      "$BASE_URL/api/PayRouteCategoryMaster/GetRetrieveRecord?PayrouteCategoryCode=&PayrouteCategoryName=$categoryName";

  static String get PAYROUTE_CATEGORY_MASTER_SAVE_RECORD =>
      "$BASE_URL/api/PayRouteCategoryMaster/PostSaveRecord";

  /// //////////////////////////////// END EXECUTIVE MASTER ////////////////////////////////////
  ///
  ///
  ///
  /// ////////////////////////// Start Place Master Model////////////////////////////////
  static String get PLACE_MASTER_ON_LOAD =>
      "$BASE_URL/api/PlaceMaster/GetPlaceMasterOnLoad";

  static String PLACE_MASTER_PLACE_NAME(String placeName) =>
      "$BASE_URL/api/PlaceMaster/GetPlaceName?PlaceName=$placeName";

  static String PLACE_MASTER_RETRIEVE_RECORD(
          String placeCode, String placeName) =>
      "$BASE_URL/api/PlaceMaster/GetRetrieveRecord?PlaceCode=$placeCode&PlaceName=${Uri.encodeQueryComponent(placeName)}";

  static String get PLACE_MASTER_POST_SAVE =>
      "$BASE_URL/api/PlaceMaster/PostSave";

  /// ////////////////////////// End Place Master Model////////////////////////////////
  ///
  ///
  ///
  /// ////////////////////////// Start Station Master Model////////////////////////////////
  static String get STATION_MASTER_ON_LOAD =>
      "$BASE_URL/api/StationMaster/GetStationMasterOnLoad";

  static String STATION_MASTER_RETRIEVE_RECORD(
          String placeCode, String placeName) =>
      "$BASE_URL/api/StationMaster/GetRetrieveRecord?PlaceCode=$placeCode&PlaceName=${Uri.encodeQueryComponent(placeName)}";

  static String get STATION_MASTER_POST_SAVE =>
      "$BASE_URL/api/StationMaster/PostSave";

  /// ////////////////////////// End Station Master Model////////////////////////////////
  ///
  ///
  ///
  /// ////////////////////////// Start Currency Type Master Model////////////////////////////////
  static String get CURRENCY_TYPE_MASTER_INITIAL_LOAD =>
      "$BASE_URL/api/CurrencyTypeMaster/Initialload";

  static String CURRENCY_TYPE_MASTER_LEAVE_CURRENCY_NAME(String currencyName) =>
      "$BASE_URL/api/CurrencyTypeMaster/CurrencyTypeLeave?CurrencyName=$currencyName";

  static String CURRENCY_TYPE_MASTER_FEATCH_CURRENCY(String currencyName) =>
      "$BASE_URL/api/CurrencyTypeMaster/FetchCurrency?CurrencyName=$currencyName";

  static String get CURRENCY_TYPE_MASTER_SAVE_DATA =>
      "$BASE_URL/api/CurrencyTypeMaster/SaveData";

  /// ////////////////////////// End Currency Type Master Model////////////////////////////////
  ///
  ///
  ///
  /// ////////////////////////// Start Combo Deal Entry Model////////////////////////////////
  static String get COMBO_DEAL_ENTRY_SEARCH_CLIENT =>
      "$BASE_URL/api/ComboDealEntry/GetClient?SearchText=";

  static String COMBO_DEAL_ENTRY_SEARCH_CLIENT1(String searchText) =>
      "$BASE_URL/api/ComboDealEntry/GetClient?SearchText=${Uri.encodeQueryComponent(searchText)}";

  static String COMBO_DEAL_ENTRY_GET_AGENCY(String clientCode) =>
      "$BASE_URL/api/ComboDealEntry/GetClientLeave?ClientCode=$clientCode";

  static String COMBO_DEAL_ENTRY_GET_AGENCY_LEAVE(
          String clientCode, String agencyCode, String groupdate) =>
      "$BASE_URL/api/ComboDealEntry/GetAgencyLeave?ClientCode=$clientCode&AgencyCode=$agencyCode&Groupdate=$groupdate";

  static String COMBO_DEAL_ENTRY_GET_DEALS_CONTENT_CLICK(String dealcode,
          String locationcode, String channelcode, String dealnumber) =>
      "$BASE_URL/api/ComboDealEntry/GetDealsContentClick?dealcode=$dealcode&locationcode=$locationcode&channelcode=$channelcode&dealnumber=$dealnumber";

  static String COMBO_DEAL_ENTRY_GROUP_NUMBER_LEAVE(String groupNumber) =>
      "$BASE_URL/api/ComboDealEntry/GetGroupNumberLeave?GroupNumber=$groupNumber";

  static String get COMBO_DEAL_ENTRY_SAVE_RECORD =>
      "$BASE_URL/api/ComboDealEntry/PostSaveRecord";

  /// ////////////////////////// End Combo Deal Entry Model////////////////////////////////

  /// ////////////////////////// View deal change History////////////////////////////////
  static String get VIEW_DEAL_CHANGE_HISTORY_ON_LOAD =>
      "$BASE_URL/api/ViewDealChangeHistory/GetDealChangeHistoryOnLoad";

  static String VIEW_DEAL_CHANGE_HISTORY_ON_CHANNEL_LEAVE(
          {required String locationCode, required String channelCode}) =>
      "$BASE_URL/api/ViewDealChangeHistory/GetChannelLeave?locationcode=$locationCode&channelcode=$channelCode";

  static String VIEW_DEAL_CHANGE_HISTORY_ON_CLIENT_LEAVE(
          {required String locationCode,
          required String channelCode,
          required String clientCode}) =>
      "$BASE_URL/api/ViewDealChangeHistory/GetclientLeave?locationcode=$locationCode&channelcode=$channelCode&clientcode=$clientCode";

  static String get VIEW_DEAL_CHANGE_HISTORY_GET_HISTORY =>
      "$BASE_URL/api/ViewDealChangeHistory/GetShowDealHistory";

  /// ////////////////////////// Credit rate Master ////////////////////////////////
  static String CREDIT_RATE_MASTER_RETRIEVE_RECORD(String Cr_name) =>
      "$BASE_URL/api/CreditRateMaster/GetRetrieveRecord?CRCode=&CRName=$Cr_name";

  static String get CREDIT_RATE_MASTER_SAVE_RECORD =>
      "$BASE_URL/api/CreditRateMaster/PostSaveRecord";

  /// ////////////////////////// spots not telecasted report ////////////////////////////////
  ///
  static String get SPOT_NOT_TELECASTED_REPORT_ONLOAD =>
      "$BASE_URL/api/SNTReport/GetSpotsNotTelecastedLoad";

  static String SPOT_NOT_TELECASTED_REPORT_GET_REPORT({
    required String locationCode,
    required String channelCode,
    required String fromDate,
    required String toDate,
  }) =>
      "$BASE_URL/api/SNTReport/GetGenrate?locationcode=$locationCode&channelcode=$channelCode&fromdate=$fromDate&todate=$toDate";

  /// ////////////////////////// client group master ////////////////////////////////

  static String get CLIENT_GROUP_MASTER_GET_CLIENT_NAME =>
      "$BASE_URL/api/ClientGroupMaster/GetClientpageload?BmsClientName=";

  static String CLIENT_GROUP_MASTER_GET_RECORD({required String groupName}) =>
      "$BASE_URL/api/ClientGroupMaster/GetRetrieveRecord?GroupCode=&GroupName=$groupName";

  static String get CLIENT_GROUP_MASTER_SAVE_RECORD =>
      "$BASE_URL/api/ClientGroupMaster/PostSaveRecord";

  /// //////////////////////////////// SALES EXECUTIVE MASTER ////////////////////////////////////

  static String get SALES_EXECUTIVE_GET_SAPNAME =>
      "$BASE_URL/api/SalesExecutiveMaster/GetSapName?SapName=";

  static String get SALES_EXECUTIVE_MASTER_DATA =>
      "$BASE_URL/api/SalesExecutiveMaster/GetSalesExecutiveMasterLoad";

  static String SALES_EXECUTIVE_DETAILS(String personalNo, String sapCode) =>
      "$BASE_URL/api/SalesExecutiveMaster/GetRetrieveRecord?personnelcode=$personalNo&sapcode=$sapCode";

  static String get SALES_EXECUTIVE_SAVE =>
      "$BASE_URL/api/SalesExecutiveMaster/PostSaveRecord";

  /// //////////////////////////////// CLIENT MASTER ////////////////////////////////////

  static String get CLIENT_MASTER_MAIN_DATA =>
      "$BASE_URL/api/ClientMaster/GetClientMasterLoad";

  static String get CLIENT_MASTER_SEARCH_CLIENT =>
      "$BASE_URL/api/ClientMaster/GetClientMaster?SearchText=";

  static String get CLIENT_MASTER_SEARCH_EXECUTIVE =>
      "$BASE_URL/api/ClientMaster/GetExecutiveCode?SearchText=";

  static String get CLIENT_MASTER_SEARCH_AGENCY =>
      "$BASE_URL/api/ClientMaster/GetAgency?SearchText=";

  static String get CLIENT_MASTER_CHANNEL_LEAVE =>
      "$BASE_URL/api/ClientMaster/GetLocationLeave?locationcode=";

  static String CLIENT_MASTER_RETRIVE_DATA(
    String clientId,
    String clientName,
  ) =>
      "$BASE_URL/api/ClientMaster/GetRetrieveRecord?ClientCode=$clientId&ClientName=$clientName&FormName=frmClientMaster";

  static String CLIENT_MASTER_SEARCH_PAYROUTE(
    String locId,
    String chlId,
  ) =>
      "$BASE_URL/api/ClientMaster/GetPayRoute?Locationcode=$locId&channelcode=$chlId&SearchText=";

  static String CLIENT_MASTER_GET_PAYROUTE_CODE(
    String locId,
    String chlId,
    String routeId,
  ) =>
      "$BASE_URL/api/ClientMaster/GetPayRouteCodeSelect?locationcode=$locId&ChannelCode=$chlId&PayRouteCode=$routeId";

  static String get CLIENT_MASTER_UNBLOCK_CLIENT =>
      "$BASE_URL/api/ClientMaster/PostUnblockclient";

  static String get CLIENT_MASTER_BLOCK_CLIENT =>
      "$BASE_URL/api/ClientMaster/Postblockclient";

  static String get CLIENT_MASTER_POST_SAVE =>
      "$BASE_URL/api/ClientMaster/PostSaveRecord";

  /// ////////////////////////// End CLIENT MASTER Model////////////////////////////////
  ///
  ///
  ///
  /// ////////////////////////// Start READY TO BILLS Model////////////////////////////////
  static String get READY_TO_BILLS_ON_LOAD =>
      "$BASE_URL/api/ReadyToBills/onload";

  static String READY_TO_BILLS_GET_CHANNEL(String location) =>
      "$BASE_URL/api/ReadyToBills/GetChannel?location=$location";

  static String get READY_TO_BILLS_GET_AGENCIES =>
      "$BASE_URL/api/ReadyToBills/GetAgencies?agencyname=";

  static String get READY_TO_BILLS_GET_BILLING_STATUS =>
      "$BASE_URL/api/ReadyToBills/GetBillingStatus";

  static String get READY_TO_BILLS_MARK => "$BASE_URL/api/ReadyToBills/Mark";

  static String get READY_TO_BILLS_CHECK_DUPLICATE =>
      "$BASE_URL/api/ReadyToBills/CheckDuplicate";

  static String get READY_TO_BILLS_VERIFY =>
      "$BASE_URL/api/ReadyToBills/verify";

  static String get READY_TO_BILLS_BILLING_VALUE =>
      "$BASE_URL/api/ReadyToBills/BillingValue";

  static String get READY_TO_BILLS_RESEND_TO_SAP =>
      "$BASE_URL/api/ReadyToBills/ResendToSAP";

  static String get READY_TO_BILLS_SEND_TO_SAP =>
      "$BASE_URL/api/ReadyToBills/sendToSAP";

  static String get READY_TO_BILLS_EXPORT =>
      "$BASE_URL/api/ReadyToBills/Export";

  static String get READY_TO_BILLS_SAVE => "$BASE_URL/api/ReadyToBills/save";

  /// ////////////////////////// End READY TO BILLS Model////////////////////////////////
  ///
  ///
  ///
  /// ////////////////////////// Start ASRUN SECONDARY EVENT Model////////////////////////////////
  static String get ASRUN_SECONDARY_EVENT_GET_LOCATION =>
      "$BASE_URL/api/AsrunSecondaryEvent/GetLocation";

  static String ASRUN_SECONDARY_EVENT_GET_CHANNEL(String location) =>
      "$BASE_URL/api/AsrunSecondaryEvent/GetChannel?Location=$location";

  static String get ASRUN_SECONDARY_EVENT_IMPORT =>
      "$BASE_URL/api/AsrunSecondaryEvent/Import";

  /// ////////////////////////// End ASRUN SECONDARY EVENT Model////////////////////////////////
  ///
  ///
  ///
  //////////////////////////////////Client Channel Link/////////////////////////////////////////////////////

  static String get CHANNEL_LINK_INIT =>
      "$BASE_URL/api/CompanyChannelLink/InitialLoad";

  static String get CHANNEL_LINK_LOCATION =>
      "$BASE_URL/api/CompanyChannelLink/LocationLeave?LocationCode=";

  static String get CHANNEL_LINK_SAP_PROFIT_CENTER =>
      "$BASE_URL/api/CompanyChannelLink/GetSapProfitCenter?Parents=";

  static String get CHANNEL_LINK_SAVE =>
      "$BASE_URL/api/CompanyChannelLink/SaveRecords";

  ///////////////////////////////End: Client Channel Link///////////////////////////////////////////////////
  ///
  ///
  ///
  /// ////////////////////////// Start ASRUN MODIFICATION  Model////////////////////////////////
  static String get ASRUN_MODIFICATION_GET_LOCATION =>
      "$BASE_URL/api/AsRunModification/GetLocation";
  static String ASRUN_MODIFICATION_GET_CHANNEL(String location) =>
      "$BASE_URL/api/AsRunModification/GetChannel?location=$location";
  static String ASRUN_MODIFICATION_RETRIEVE(
          String locationCode, String channelCode, String logDate) =>
      "$BASE_URL/api/AsRunModification/Retrieve?LocationCode=$locationCode&ChannelCode=$channelCode&logDate=$logDate";
  static String get ASRUN_MODIFICATION_SAVE =>
      "$BASE_URL/api/AsRunModification/save";
  static String get ASRUN_MODIFICATION_GET_PROGRAM =>
      "$BASE_URL/api/AsRunModification/GetProgram?programName=";

  /// ////////////////////////// End ASRUN MODIFICATION Model////////////////////////////////
  ///
  ///
  ///
  /// ////////////////////////// Start AGENCY EMBARGO Model////////////////////////////////
  static String get AGENCY_EMBARGO_ON_LOAD =>
      "$BASE_URL/api/AgencyEmbargo/onLoad";
  static String get AGENCY_EMBARGO_AGENCY_NAME =>
      "$BASE_URL/api/AgencyEmbargo/GetAgency?agencyName=";
  static String AGENCY_EMBARGO_GET_AGENCY_HISTORY(String agencyCode) =>
      "$BASE_URL/api/AgencyEmbargo/GetAgencyHistory?agencyCode=$agencyCode";
  static String get AGENCY_EMBARGO_SAVE => "$BASE_URL/api/AgencyEmbargo/Save";

  /// ////////////////////////// End AGENCY_EMBARGO Model////////////////////////////////

  ///  ///////////////////////////// CLIENT EMBARGO ////////////////////////////////
  static String get CLIENT_EMBARGO_ON_LOAD =>
      "$BASE_URL/api/ClientEmbargo/GetLoad";
  static String get CLIENT_EMBARGO_GET_CLIENT =>
      "$BASE_URL/api/ClientEmbargo/GetClient?SearchText=";
  static String get CLIENT_EMBARGO_GET_CLIENT_NAME_CLICK =>
      "$BASE_URL/api/ClientEmbargo/GetClientNameClick?ClientCode=";
  static String get CLIENT_EMBARGO_POST =>
      "$BASE_URL/api/ClientEmbargo/PostSave";

  /// ////////////////////////// AGENCY GROUP ///////////////////////////////////

  static String get AGENCY_MASTER_ON_LOAD =>
      "$BASE_URL/api/AgencyMasters/GetAgencyMasterLoad";
  static String get AGENCY_MASTER_GET_AGENCY_NAME =>
      "$BASE_URL/api/AgencyMasters/GetAngecyName?BMSAngecyName=";
  static String get AGENCY_MASTER_GET_RETRIEVE_RECORD =>
      "$BASE_URL/api/AgencyMasters/GetRetrieveRecord";
  static String get AGENCY_MASTER_POST_BLOCK_AGENCY =>
      "$BASE_URL/api/AgencyMasters/Postblockagency";
  static String get AGENCY_MASTER_POST_UN_BLOCK_AGENCY =>
      "$BASE_URL/api/AgencyMasters/Postunblockagency";
  static String get AGENCY_MASTER_POST =>
      "$BASE_URL/api/AgencyMasters/PostValidateAndSaveRecord";

  /// //////////////////  Agency Group Master ////////////////////////
  static String get AGENCY_GROUP_MASTER_GET_RETRIEVE_RECORD =>
      "$BASE_URL/api/AgencyGroupMaster/GetRetrieveRecord";
  static String get AGENCY_GROUP_MASTER_GET_AGENCY =>
      "$BASE_URL/api/AgencyGroupMaster/GetAgency?AgencyName=";
  static String get AGENCY_GROUP_MASTER_POST =>
      "$BASE_URL/api/AgencyGroupMaster/PostSave";

  //////////////////////////////////Bill EXPORT /////////////////////////////////////////////////////

  static String get BILL_EXPORT_INIT =>
      "$BASE_URL/api/ExportBillingData/onLoad";

  static String get BILL_EXPORT_GET_DETAILS =>
      "$BASE_URL/api/ExportBillingData/GetDetails";

  static String get BILL_EXPORT_FILES =>
      "$BASE_URL/api/ExportBillingData/GetExportFiles";

  static String get BILL_VIEWS_DATA =>
      "$BASE_URL/api/ExportBillingData/ViewData";

  ////////////////////////////End: Bill EXPORT ///////////////////////////////////////////////////

  /////////////////////////////////// Traffic Order Correction /////////////////////////////////

  static String get TO_INIT => "$BASE_URL/api/TOCorrection/Onload";

  static String get TO_LOC_LEAVE =>
      "$BASE_URL/api/TOCorrection/OnLocationLeave?LocationCode=";

  static String get TO_TAPE_LAYOUT =>
      "$BASE_URL/api/TOCorrection/OnTapeLayout?TapeId=";

  static String get TO_ONSAVE => "$BASE_URL/api/TOCorrection/OnSave";

  static String TO_GRID_TO_CORRECTION_CELL_CLICK(
          locId, chnlId, bokNo, duration) =>
      "$BASE_URL/api/TOCorrection/GridToCorrectionCellClick?LocationCode=$locId&ChannelCode=$chnlId&BookingNumber=$bokNo&Duration=$duration";

  static String TO_TAPE_ID_LEAVE(tapeId, duration, rate) =>
      "$BASE_URL/api/TOCorrection/TapeIdLeave?TapeId=$tapeId&Duration=$duration&Rate=$rate";

  static String TO_PAYROUTE_GOT_FOCUS(
          payrouteId, location, channel, clientCode, agencyCode) =>
      "$BASE_URL/api/TOCorrection/PayRouteGotFocus?PayRoute=$payrouteId&LocationCode=$location&ChannelCode=$channel&ClientCode=$clientCode&AgencyCode=$agencyCode";

  static String TO_PAYROUTE_LEAVE(locationId, channelId, payrouteId) =>
      "$BASE_URL/api/TOCorrection/PayRouteLeave?LocationCode=$locationId&ChannelCode=$channelId&PayRouteCode=$payrouteId";

  ///////////////////////////////End: Traffic Order Correction ////////////////////////////////

  /////////////////////////////// SAP BILL CHECK REPORT ////////////////////////////////
  static String SAP_BILL_CHECK_GENERATE(frmDt, toDt, r4) =>
      "$BASE_URL/api/SAPBillCheckReport/GetGenrate?fromdate=$frmDt&todate=$toDt&R4_yn=$r4";

///////////////////////////////End: SAP BILL CHECK REPORT ////////////////////////////////

  /////////////////////////////// GENERATE BOOKING ACTIVITY AHDM ////////////////////////////////
  static String get GENERATE_BOOKING_REPORT_INIT =>
      "$BASE_URL/api/GenerateBookingReport/GetFromLoad";

  static String get GENERATE_BOOKING_CHANNEL_LEAVE =>
      "$BASE_URL/api/GenerateBookingReport/GetChannel?LocationCode=";

  static String get GENERATE_BOOKING_GET_DETAILS =>
      "$BASE_URL/api/GenerateBookingReport/GetRetrieve";

///////////////////////////////End: GENERATE BOOKING ACTIVITY AHDM ////////////////////////////////

  /////////////////////////////// EBILL AGENCY GRP MASTER ////////////////////////////////
  static String get EBILL_AGENCY_INIT =>
      "$BASE_URL/api/EBillAgencyGroupMaster/GetEBillAgencyFormload";

  static String get EBILL_AGENCY_GRP_LEAVE =>
      "$BASE_URL/api/EBillAgencyGroupMaster/GetGroupNameLeave?groupCode=";

  static String EBILL_AGENCY_ADD_GRP(String grpCode,String agency) =>
      "$BASE_URL/api/EBillAgencyGroupMaster/GetAddNewGroup?groupCode=$grpCode&agency=$agency";

  static String get EBILL_AGENCY_REMOVE_GRP =>
      "$BASE_URL/api/EBillAgencyGroupMaster/GetRemovefromGroup";

  static String get EBILL_AGENCY_ADD_GRP_NAME =>
      "$BASE_URL/api/EBillAgencyGroupMaster/GetButtonAdd?GroupName=";

  static String get EBILL_AGENCY_SAVE =>
      "$BASE_URL/api/EBillAgencyGroupMaster/PostSave";

///////////////////////////////End: EBILL AGENCY GRP MASTER ////////////////////////////////
  ///
  ///
  ///
  /// ////////////////////////// Start EBILLS  Model////////////////////////////////
  static String get EBILLS_GET_LOAD => "$BASE_URL/api/Ebills/GetLoad";
  static String get EBILLS_POST_AGENCY => "$BASE_URL/api/Ebills/PostAgency";

  /// ////////////////////////// End EBILLS Model////////////////////////////////

  /////////////////////////////// ASRUN SPECIFICATION AD REVENUE ////////////////////////////////
  static String get ASRUN_AD_INIT =>
      "$BASE_URL/api/AsrunSpecAdRevenue/GetAsrunSpecificationOnLoad";

  static String get ASRUN_AD_CHANNEL_LEAVE =>
      "$BASE_URL/api/AsrunSpecAdRevenue/GetChannel?LocationCode=";

  static String ASRUN_AD_POPULATE(String locId, String chnlId) =>
      "$BASE_URL/api/AsrunSpecAdRevenue/GetPouplateData?ChannelCode=$chnlId&LocationCode=$locId";

  static String get ASRUN_AD_SAVE =>
      "$BASE_URL/api/AsrunSpecAdRevenue/PostSave";

///////////////////////////////End: ASRUN SPECIFICATION AD REVENUE ////////////////////////////////
}
