import 'package:JMrealty/utils/sizeConfig.dart';
import 'package:flutter/material.dart';

class HomeGoodDeed extends StatefulWidget {
  @override
  _HomeGoodDeedState createState() => _HomeGoodDeedState();
}

class _HomeGoodDeedState extends State<HomeGoodDeed> {
  double thisHeight = 45.0;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Align(
      child: Container(
        width: SizeConfig.screenWidth - 40,
        height: thisHeight,
        margin: EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Positioned(
              height: thisHeight,
              left: 10,
              top: 0,
              child: Image.asset(
                "assets/images/tabbar/food-cake.png",
                height: 30,
                width: 30,
              ),
            ),
            Positioned(
              height: thisHeight,
              right: 40,
              left: 40,
              child: TextButton(
                  onPressed: null,
                  child: Text(
                    '阿萨德很快就阿萨德很快就阿萨德很快就阿萨德很快就阿萨德很快就',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  )),
            ),
            Positioned(
              height: thisHeight,
              right: -5,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  '更多',
                  style: TextStyle(color: Color(0XFF9fa1a8), fontSize: 13),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
