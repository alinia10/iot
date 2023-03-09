import 'package:bulb_control/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Smart Home")),
          leading: GestureDetector(
            onTap: () {
              /* Write listener code here */
            },

            child: Icon(
              Icons.menu,
            ),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.search,
                    size: 26.0,
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                      Icons.more_vert
                  ),
                )
            ),
          ],


        ),
        body: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child:Column(

                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Wifi Status:", style: Styles.headLineStyle3,),
                          MyString().connected,
                        ]
                    ),
                    const Gap(50),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Bulbs status"),
                          Text("Veiw all"),
                        ]
                    ),
                    const Gap(50),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children :[
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20, right: 20),
                                    width: AppLayout
                                        .getSize(context)
                                        .width * 0.5,
                                    height: AppLayout
                                        .getSize(context)
                                        .height * 0.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.lime,
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "lib/assets/images/light_bulb.png"
                                            )
                                        )
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("title", style: Styles.headLineStyle3,),
                                  Text("Bulb one"),
                                ],
                              )

                            ],
                          ),
                          Column(
                            children :[
                              Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20, right: 20),
                                    width: AppLayout
                                        .getSize(context)
                                        .width * 0.5,
                                    height: AppLayout
                                        .getSize(context)
                                        .height * 0.5,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.lime,
                                        image: const DecorationImage(
                                            image: AssetImage(
                                                "lib/assets/images/light_bulb.png"
                                            )
                                        )
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("title", style: Styles.headLineStyle3,),
                                  Text("Bulb one"),
                                ],
                              )

                            ],
                          ),

                        ],
                      ),
                    )

                  ],
                )
                ]))));
  }
}
