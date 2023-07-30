import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lhere/Model/companyModel.dart';
import 'package:lhere/Model/postModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/constants.dart';

class getcompaniesController
{

  String companiesUrl="${Constants.baseUrl}App/getCompanies.php";

  Future<List<postModel>>getcompanydata()
  async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String city=await prefs.getString("city").toString();
    String skill=await prefs.getString("skill").toString();

    var bodydata =
    {
      "city": "$city",
      "skill": "$skill",
    };
    List<postModel>posts=[];

    var url=Uri.parse(companiesUrl);

    var response= await http.post(url,body:bodydata);


    if(response.body=="0 results[]")
      {
        return posts;

      }
    else{
      var userdata = await json.decode(response.body);
      var listofcompanies=userdata['data'];
      for(var data in listofcompanies)
      {

        posts.add(postModel.fromJson(data));

      }
      log(posts.length.toString());

      return posts;
    }


  }
  Future<List<comapnyModel>>getcompanylist()
  async {

    List<comapnyModel>companylist=[];

    var url=Uri.parse("${Constants.baseUrl}App/getcat.php");
    var response= await http.get(url);

    log(response.body);


    if(response.body=="0 results[]")
    {
      return companylist;

    }
    else{
      var userdata = await json.decode(response.body);
      var listofcompanies=userdata['data'];
      for(var data in listofcompanies)
      {

        companylist.add(comapnyModel.fromJson(data));

      }
      log(companylist.length.toString());

      return companylist;
    }


  }
  Future<List<postModel>>getfilter(String city,String interest)
  async {

    var bodydata =
    {
      "city": "$city",
      "skill": "$interest",
    };
    List<postModel>posts=[];

    var url=Uri.parse(companiesUrl);
 ;
    var response= await http.post(url,body:bodydata);

    log(response.body);


    if(response.body=="0 results[]")
    {
      return posts;

    }
    else{
      var userdata = await json.decode(response.body);
      var listofcompanies=userdata['data'];
      for(var data in listofcompanies)
      {

        posts.add(postModel.fromJson(data));

      }
      log(posts.length.toString());

      return posts;
    }


  }
  String companyUrl="${Constants.baseUrl}App/getcompanydata.php";
  getucompanydata(String id,BuildContext context) async {

    var bodydata =
    {
      "id": "$id",

    };
    var url=Uri.parse(companyUrl);

    var response= await http.post(url,body:bodydata);


    log(response.body);

      var userdata = await json.decode(response.body);

    log(response.body);

    comapnyModel userm = comapnyModel.fromJson(userdata["data"][0]);
    return userm;

    }
  Future<void>sendemail(String name,String email,String city,String companyemail,String address,BuildContext context)async
  {

    var bodydata=json.encode({
      "service_id":"service_jwapcem","template_id":"template_chtxds9","user_id":"Lt3VZf1nD1KeUnx5K",
      "template_params":{
        "city":city,"name":name,"emailfrom":email,"emailto":companyemail,"address":address
      }});
    var url=Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    var response= await http.post(url,body:bodydata,headers:{"Content-Type": 'application/json',"origin":'http://localhost'});

    log(response.body);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Your details are sent."),
    ));
    Navigator.pop(context);

  }


  }


