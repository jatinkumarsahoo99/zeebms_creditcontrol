part of 'client_deals_controller.dart';

extension CompareBtnController on ClientDealsController {


  Future<bool> getCompareListFromApi(){
    Completer<bool> completer = Completer<bool>();

    LoadingDialog.call();
    try{
      Map<String,dynamic> postData = {
        "locationcode": selectedLocation?.value?.key??"",
        "channelcode":selectedChannel?.value?.key?? "",
        "dealnumber": dealNoController.text??""
      };
      Get.find<ConnectorControl>().POSTMETHOD(
          api: ApiFactory.Client_Deal_LINK_DEAL_COMPARE ,
          json: postData,
          // "https://jsonkeeper.com/b/D537"
          fun: (map) {
            closeDialogIfOpen();
            if(map is Map && map['model'] != null){
              compareModelList = CompareModelList.fromJson(map as Map<String,dynamic>);
            }else{
              compareModelList = null;
            }
            completer.complete(true);
          },
          failed: (map) {
            closeDialogIfOpen();
            completer.complete(true);
          });
    }catch(e){
      closeDialogIfOpen();
      completer.complete(true);
    }
    return completer.future;
  }



}