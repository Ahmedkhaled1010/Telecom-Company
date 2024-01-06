import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled4/shared/components/components.dart';
import 'package:untitled4/shared/network/local/cache_helper.dart';

import '../../../shared/styles/color.dart';
import '../login/shop_login_screen.dart';
class BoardingModel
{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  // const OnBoardingScreen({super.key});
  List<BoardingModel> boarding =
  [
    BoardingModel(
        image: "assets/Images/shop.png",
        title: "On Board 1 Title",
        body: "On Board 1 Body"),
    BoardingModel(
        image: "assets/Images/shop.png",
        title: "On Board 2 Title",
        body: "On Board 2 Body"),
    BoardingModel(
        image: "assets/Images/shop.png",
        title: "On Board 3 Title",
        body: "On Board 3 Body"),

  ];
  bool isLast =false;
  void submit()
  {
    CacheHelper.saveData(key: "onBoarding", value: true).then(
            (value)
        {
          navigateAndFinish(context, ShopLoginScreen());

        } );
  }

  var boardController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: ()
              {
                submit();
              },
              child: Text(
                "SKIP"
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child:
                PageView.builder(
                  controller: boardController,
                    onPageChanged: (int index)
                  {
                    if(index ==boarding.length-1)
                      {
                        setState(() {
                          isLast =true;
                        });
                        print("last");
                      }
                    else
                      {
                        setState(() {
                          isLast =false;
                        });
                      }
                  },
                    itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
                  itemCount: boarding.length,

                ),


            ),
              SizedBox(
                height: 40.0,
              ),
              Row(
                  children: [
                    SmoothPageIndicator(
                      controller: boardController,
                      count: boarding.length,
                      effect: ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        dotHeight: 10,
                        dotWidth: 10,
                        expansionFactor: 4,
                        spacing: 5.0,
                        activeDotColor: defaultColor,
                      ),
                    ),
                    Spacer(),
                    FloatingActionButton(
                      onPressed: ()
                      {
                        if(isLast == true)
                          {
                            submit();
                          }
                        else {
                          boardController.nextPage(
                              duration: Duration(
                                milliseconds: 750,
                              ),
                              curve: Curves.fastLinearToSlowEaseIn);
                        }

                      },
                    child: Icon(
                      Icons.arrow_forward_ios,
                    ),)
                  ],
                )
              ],
            ),
      ),


    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

      Expanded(
        child: Image(
            image: AssetImage("${model.image}")),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        "${model.title}",
        style: TextStyle(
          fontSize: 24.0,

        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        "${model.body}",
        style: TextStyle(
          fontSize: 14.0,

        ),
      ),
      SizedBox(
        height: 30.0,
      ),





    ],
  );
}
