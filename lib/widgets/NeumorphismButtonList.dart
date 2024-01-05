import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:get/get.dart';

import '../app/providers/SizeDefine.dart';

class NeumorphismButtonList extends StatelessWidget {
  List<String> btnName = [];
  double? height ;
  Function fun;
   NeumorphismButtonList({super.key,required this.btnName,this.height,required this.fun});

  @override
  Widget build(BuildContext context) {
    // Rx<bool>additionClick = Rx<bool>(false);
    RxList<bool> btnClickList = RxList<bool> ( List.generate(btnName.length, (index){
      if(index ==0){
        return true;
      }else{
        return false;
      }
    }));

    return SizedBox(
      height: height??30,
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.separated(
            itemBuilder: (BuildContext context,int index){
              return  Obx(() {
                return InkWell(
                  onTap: () {

                    for(int i=0;i<btnClickList.length;i++){
                      if(i == index){
                        btnClickList[i] = true;
                      }else{
                        btnClickList[i] = false;
                      }

                    }
                    btnClickList.refresh();
                    fun(index,btnName[index]);
                  },

                  child: Container(
                    // margin: EdgeInsets.zero,
                    // padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      color: btnClickList[index]
                          ? Colors.grey[300]
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(2),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[
                            (btnClickList[index])
                                ? 500
                                : 300]!,
                            offset: Offset(2.0, 2.0),
                            blurRadius: 1.0,
                            spreadRadius: 1.0,
                            inset: btnClickList[index]),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          btnName[index]??'Press me',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[700],
                              fontSize: SizeDefine.fontSizeButton
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              });
            },
            separatorBuilder: (BuildContext context,int index){
              return const SizedBox(
                  height: 15,
                  child: VerticalDivider(thickness: 2,));
            },
            padding: EdgeInsets.zero,
            itemCount: btnName.length,scrollDirection: Axis.horizontal,),
      ),
    );
  }
}
