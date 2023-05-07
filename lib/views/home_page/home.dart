import 'package:pharma_glow/consts/consts.dart';
import 'package:pharma_glow/consts/lists.dart';


class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(12),
        color:lightGrey,
        width:context.screenWidth,
        height:context.screenHeight,
        child: SafeArea(child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height:60,
              color: lightGrey,
              child: TextFormField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: "Search",
                ),
              ),
            ),
            VxSwiper.builder(
              aspectRatio: 16/9,
                autoPlay: true,
                height:150,
                enlargeCenterPage: true,
                itemCount: slidersList.length,
                itemBuilder: (context,index){
              return Image.asset(slidersList[index], fit:BoxFit.fill,).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal:8)).make();

            })
          ],
        ),),
    );
  }
}
