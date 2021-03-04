
import 'package:flutter/material.dart';
import 'package:flutter_pet_show/Homepage.dart';

import 'models/pets_types.dart';
class PetProfile extends StatefulWidget {
  PetProfile({this.petname,this.petimage,this.petage,this.petdistance,this.petdescription});
  final  String petname ;
  final String petimage;
  final Age petage;
  final int petdistance;
  final String petdescription;
  @override
  _PetProfileState createState() => _PetProfileState();
}

class _PetProfileState extends State<PetProfile> {
  bool liked =false;
  _pressed() {
    setState(() {
      liked = !liked;
    });
  }
  List<Pets> listpets=List();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: Color(0xFF939393),
              ),
              onPressed: () {
                Navigator.pop(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Homepage(),
                  ),
                );
              }),
          actions: [
            Padding(
              padding: EdgeInsets.only(top: 10,bottom: 10,right: 20),
              child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFFFBECE9),
                  ),
                  child: IconButton(
                    icon: Icon(
                      liked ? Icons.favorite : Icons.favorite_border,
                      size: 25,
                      color: liked
                          ? Color(0xFFF17E69)
                          : Color(0xFFF17E69),
                    ),
                    onPressed: () => _pressed(),
                  )),
            ),
          ],
        ),
      body:Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 18),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.petname,style: TextStyle(color: Color(0xFF3b3a38),fontWeight: FontWeight.w900,fontSize: 22),),
                          Icon(Icons.motion_photos_pause_outlined,color: Color(0xFFd9d9d9))
                        ],
                      ),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Golden Retriver",style: TextStyle(color: Color(0xFF636363),fontSize: 13,fontWeight: FontWeight.w600),),
                          Text("${widget.petage}",style: TextStyle(color: Color(0xFF636363),fontSize: 13,fontWeight: FontWeight.w600),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Icon(Icons.location_on,color: Colors.orange,size: 19,),
                          Text("${widget.petdistance} kms away",style: TextStyle(color: Colors.grey,fontSize: 12,fontWeight: FontWeight.w400),)
                        ],
                      ),
                      SizedBox(height: 10,),

                      Container(
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            image: DecorationImage(
                                image: NetworkImage(widget.petimage),fit: BoxFit.cover
                            ),
                            color: Colors.red,
                          )),
                      SizedBox(height: 5,),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text("About",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 22),)),
                      SizedBox(height: 12,),
                      Text(widget.petdescription,style: TextStyle(color: Colors.grey[400]),),
                      SizedBox(height: 30,),

                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              alignment: Alignment.center,
              height: 65,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: Color(0xFFf87967),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.pets,color: Colors.white,size: 15,),
                  SizedBox(width: 2,),
                  Text("Adopt",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),)
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
