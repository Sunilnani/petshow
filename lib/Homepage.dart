import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pet_show/pet_profile.dart';

import 'models/pets_types.dart';
class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}
class _HomepageState extends State<Homepage> {
  List<IconData> icons=[Icons.pets,Icons.pets,Icons.pets,Icons.pets];
  List<String> names=["dog","cat","Monkey","Buffalo"];
  String petcategory="";
  String indx;
  bool liked =false;
  List<Pets> listpets=List();
  void getHttp() async {
    setState(() {

    });
    try {
      Response response =
      await Dio().get("https://api.npoint.io/a145beb7c3963677dd5d");
      setState(() {
        listpets = petsFromJson(jsonEncode(response.data));
        print(response);
      });
    } catch (e) {
      setState(() {
      });
      print(e);
    }
  }

  @override
  void initState() {
    getHttp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu,color: Color(0xFF9A9A9A),),
                      Column(
                        children: [
                          Text("Location",style: TextStyle(color: Color(0xFFd2d2d2),fontWeight: FontWeight.w400,fontSize: 12),),
                          SizedBox(height: 5,),
                          Text("Cameron St.,Boston",style: TextStyle(color: Color(0xFF777779),fontWeight: FontWeight.w600,fontSize: 15),)
                        ],
                      ),
                      CircleAvatar(
                        backgroundImage:AssetImage("img/pet.jfif"),
                        radius: 20,
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18,vertical: 10),
                  height: 800,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 15,),
                        Container(
                          height: 45,
                          child: ListView.builder(
                            itemCount:names.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return InkWell(
                                onTap: (){
                                  setState(() {
                                    indx = names[index];

                                  });
                                },
                                child: PetsCategory(
                                  name:names[index],
                                  icon: icons[index],
                                  petcategory: indx,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20,),
                        Container(
                          height:800,
                          child: ListView.builder(
                            itemCount:listpets.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Pets todos = listpets[index];
                              return PetDetails(
                                liked:false,
                                name: todos.name,
                                image: todos.image,
                                age: todos.age,
                                sex: todos.sex,
                                distance: todos.distance,
                                petdescription: todos.description,



                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PetDetails extends StatefulWidget {

  const PetDetails({
    this.name,
    this.image,
    this.age,
    this.sex,
    this.distance,
    this.petimage,
    this.petname,
    this.petage,
    this.petdistance,
    this.petdescription,
    this.liked,
    Key key,
  }) : super(key: key);
  final String name;
  final String image;
  final Age age;
  final Sex sex;
  final int distance;
  final String petimage;
  final String petname;
  final Age petage;
  final int petdistance;
  final String petdescription;
  final bool liked;

  @override
  _PetDetailsState createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {

  bool liked;
  @override
  void initState() {
    liked=widget.liked;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        Container(
          height: 120,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: Colors.white
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal:12.0,vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PetProfile(petimage: widget.image,petname: widget.name,petage: widget.age,petdistance: widget.distance,petdescription: widget.petdescription,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                            image: NetworkImage(widget.image,),
                          fit: BoxFit.cover
                        )
                    ),
                    height: 100,
                    width: 100,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(child: Text(widget.name,style: TextStyle(color: Color(0xFF4d4d4b),fontSize: 16,fontWeight: FontWeight.w800),)),
                    SizedBox(height: 5,),
                    Text("Golden Retriver",style: TextStyle(color:Color(0xFF949494),fontWeight: FontWeight.w500,fontSize: 13),),
                    SizedBox(height: 5,),
                    Text("${widget.sex}, ${widget.age}",style: TextStyle(color:Colors.grey,fontWeight: FontWeight.w400,fontSize: 12),),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,size: 10,color: Color(0xFFf87967),),
                        Text("${widget.distance} kms away",style: TextStyle(color:Color(0xFF949494)),)
                      ],
                    )
                  ],
                ),
                SizedBox(width: 10,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      liked=!liked;
                    });
                  },
                  child: Container(
                      alignment: Alignment.topRight,
                      child: Icon(Icons.favorite,color:liked?Colors.red:Colors.grey,)),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20,)
      ],
    );
  }
}
class PetsCategory extends StatefulWidget {
  const PetsCategory({
    this.icon,
    this.name,
    this.petcategory,


  });
  final IconData icon;
  final String name;
  final String petcategory;
  @override
  _PetsCategoryState createState() => _PetsCategoryState();
}

class _PetsCategoryState extends State<PetsCategory> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right:8.0,left: 2),
          child: Container(
            decoration: widget.petcategory != widget.name ? BoxDecoration(borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF3D015B4D),
                    offset: Offset(0,1),
                    blurRadius: 3,

                  )
                ]):BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.orangeAccent,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF3D015B4D),
                    offset: Offset(0,1),
                    blurRadius: 3,

                  )
                ]
            ),
            height: 45,
            width: 100,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(widget.icon,color: Colors.white,size: 15,),
                  SizedBox(width: 5,),
                  Text(widget.name, style: TextStyle(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
