import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';

class ProfleScreen extends StatefulWidget {
  const ProfleScreen({super.key});

  @override
  State<ProfleScreen> createState() => _ProfleScreenState();
}

class _ProfleScreenState extends State<ProfleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(FontAwesomeIcons.arrowLeft,size: 24,color: Colors.white,)),
        title: const Padding(padding: EdgeInsets.only(left: 80),
        child: Text('Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600,color: Colors.white), ),),)
     ,
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 350,
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xffB81736),
              Color(0xff281537),
            ]),
           borderRadius:BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50))
            ),
         child:
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height:60),
             SizedBox(
              width:100,
              height:100,
              child:ClipRRect(borderRadius: BorderRadius.circular(100),child:const Image(image:AssetImage('assets/images/img_licensed_image_4.png'),)),
             ),
             const SizedBox(height: 10,),
             const  Text('Zarqa Shehwar',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white),),
             const  Text('zarqashehwar02@gmail.com',style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal,color: Colors.white),),
           const   SizedBox(height:20),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Card(
                  elevation: 8,
                  shadowColor:Colors.black,
                  child:Container(
                    width: 80,
                    height: 60,
                   
                    decoration: BoxDecoration(
                       color: Colors.white,
                      borderRadius: 
                    BorderRadius.circular(30)),

                  )
                ),
              const   SizedBox(width:10),
                  Card(
                  elevation: 8,
                  shadowColor:Colors.black,
                  child:Container(
                    width: 80,
                    height: 60,
                   
                    decoration: BoxDecoration(
                       color: Colors.white,
                      borderRadius: 
                    BorderRadius.circular(30)),

                  )
                ),
               const  SizedBox(width:10),
                  Card(
                  elevation: 8,
                  shadowColor:Colors.black,
                  child:Container(
                    width: 80,
                    height: 60,
                   
                    decoration: BoxDecoration(
                       color: Colors.white,
                      borderRadius: 
                    BorderRadius.circular(30)),

                  )
                )
              ],
             )

            ],
          ),
          
          ),
          

        ],
      )),
    );
  }
}
