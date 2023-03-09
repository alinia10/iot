import 'package:flutter/material.dart';
import 'package:snowa/model/device.dart';

class DeviceView extends StatelessWidget {
  const DeviceView({Key? key, required this.tittle, required this.icon, required this.status}) : super(key: key);

  final String tittle;
  final IconData icon;
  final DeviceStatus status;




  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.grey.shade500,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 5 , color: Colors.white),
            ),
            child: Column(children: [
              Icon(IconData),
            ],),
          )

          SizedBox(50),
          Text(${tittle})

          Row(
            children: [
              Expanded(child: Stack(
                children:[ SizedBox(
                  height: 24,
                  child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return Flex(
                            direction: Axis.horizontal,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: List.generate((constraints.constrainWidth()/6).floor(), (index) => const SizedBox(
                              width: 3,
                              height: 1,
                              child: DecoratedBox(decoration: BoxDecoration(
                                color: Colors.white,

                              ),),
                            ))
                        );
                      }
                  ),
                ),
                  Center(child: Transform.rotate(angle: 1.5, child: (Icon(Icons.local_airport, color: Colors.white)))),
                ]
                ,)),
              Text("${DeviceStatus}"),
              Switch(value: value, onChanged: onChanged)
            ],
          )



        ],
      ),
    )
  }
}
