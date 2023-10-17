import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Constants/constants.dart';

class companycontentDetail extends StatefulWidget {
  var data;


  companycontentDetail(this.data, {Key? key}) : super(key: key);

  @override
  _companycontentDetailState createState() => _companycontentDetailState();
}

class _companycontentDetailState extends State<companycontentDetail> {

  bool desc=true;
  bool company=false;
  String baseUrl="https://company.lehreyourfuture.com/images";


  @override
  Widget build(BuildContext context) {
    var wsize=MediaQuery.of(context).size.width;
    var hsize=MediaQuery.of(context).size.height;
    return Scaffold(
      body:SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: wsize,
              height: hsize,
              child:Column(

                children: [
                  Container(
                    width:wsize,

                    color:primarycolor,
                    child:Padding(
                      padding: const EdgeInsets.only(top:35,left:0,right:0,bottom:20),
                      child: Stack(

                        clipBehavior: Clip.none, children: [

                          Column(

                            children: [
                              Row(
                                children: [
                                  IconButton(onPressed:(){
                                    Navigator.pop(context);
                                  }, icon:const Icon(Icons.arrow_back_ios,color:Colors.white,)),

                                  Text("Company Details",style:GoogleFonts.alata(color:Colors.white,fontWeight:FontWeight.bold,fontSize: MediaQuery.of(context).size.height*0.035),),
                                ],
                              ),
                              smallgap,smallgap,
                              smallgap,smallgap,

                            ],
                          ),

                          Positioned(
                            top:hsize*0.1,
                            left:wsize*0.38,
                            right:wsize*0.38,


                            child: Container(
                              width:100,
                              height:100,
                              decoration:BoxDecoration(
                                  shape:BoxShape.circle,
                                  border:Border.all(color:Colors.white,width:5)
                              ),
                              child: widget.data.image != "" ?
                              ClipRRect(
                                  borderRadius:BorderRadius.circular(75),
                                  child:FadeInImage.assetNetwork(
                                    placeholder: "assets/place.png",
                                    image: "$baseUrl/${widget.data.image}",
                                    fit: BoxFit.cover,
                                  )) : ClipRRect(
                                  borderRadius:BorderRadius.circular(75),
                                  child:Image.asset("assets/place.png")),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                  mediumgap,smallgap,
                  mediumgap,
                  Text(
                    "${widget.data.name}",
                    style: TextStyle(
                      fontSize:hsize*0.024,

                      fontWeight: FontWeight.bold,
                    ), ),



                  SizedBox(
                    width: wsize*0.9,
                    child:Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //about
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            const SizedBox(height:28,),
                            Text(
                              "About",
                              style: TextStyle(
                                fontSize: hsize*0.026,

                                fontWeight: FontWeight.bold,
                              ), ),
                            const SizedBox(height:3,),
                            Text(
                              "${widget.data.about}",
                              style: TextStyle(
                                  fontSize: hsize*0.020,

                                  color:Colors.black45
                              ), ),
                          ],
                        ),
                        //salary
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            smallgap,
                            Text(
                              "Company Email",
                              style: TextStyle(
                                fontSize: hsize*0.022,

                                fontWeight: FontWeight.bold,
                              ), ),
                            const SizedBox(height:3,),
                            Text(
                             "${widget.data.email}",
                              style: TextStyle(
                                  fontSize: hsize*0.020,

                                  color:Colors.black45
                              ), ),
                          ],
                        ),
                      ],
                    ),

                  )

                ],
              ),
            ),


            // Positioned
            //   (
            //     bottom:15,
            //     left:15,
            //     right:15,
            //
            //
            //     child:secondrybutton(title:"Apply for job",onpressed:(){
            //
            //       Navigator.push(
            //           context,
            //           new MaterialPageRoute(builder: (context) => emailform(companydata.email,companydata.image),
            //           ));
            //     },))



          ],
        ),
      ),
    );
  }
}
