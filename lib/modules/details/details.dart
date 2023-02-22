import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Details extends StatelessWidget {
  var name;
  var desc;
  var photo;
  var bidPrice;
  Details({Key? key, required this.name, required this.desc, required this.bidPrice, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back_outlined,
                            ),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,

                          ),
                          SizedBox(height: 8,),
                          Image.network(photo),
                          SizedBox(height: 8,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("\$$bidPrice", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),),

                              ElevatedButton(onPressed: (){}, child: Text("Your Bid Price")),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Text(desc, style: TextStyle(fontSize: 15),),




                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
