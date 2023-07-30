import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:lhere/Model/companyModel.dart';
import 'package:lhere/Model/postModel.dart';
import 'package:lhere/Model/questionsdata.dart';
import 'package:lhere/Model/quizDetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Constants/constants.dart';

class questionafetchlist
{

  String questionasUrl="${Constants.baseUrl}App/getquestions.php";
  String quizdetailUrl="${Constants.baseUrl}App/getquiz.php";
  Future<List<questiondata>>getquestionalist(String comp)
  async {

    List<String> c = comp.split(""); // ['a', 'a', 'a', 'b', 'c', 'd']
    c.removeLast(); // ['a', 'a', 'a', 'b', 'c']
   String  company=c.join();
    List<questiondata>posts = [];

  if(company=="All") {

      var bodydata = {
        "company": "All",
      };

      var url = Uri.parse(questionasUrl);


      var response = await http.post(url, body: bodydata);
      var userdata = await json.decode(response.body);
      log(response.body);
      if (response.body == "[]") {
        return posts;
      }
      else {
        var listofcompanies = userdata['data'];


        for (var data in listofcompanies) {
          posts.add(questiondata.fromJson(data));
        }
        log(posts.length.toString());

        return posts;
      }
    }
    else{
    final split = company.split(',');
    List companies=[];
    for (int i = 0; i < split.length; i++)
      {

        var bodydata =
        {
          "company": split[i],
        };

        var url = Uri.parse(questionasUrl);

        var response = await http.post(url, body: bodydata);

        if (response.body == "[]")
        {

        }
        else
          {

          var userdata = await json.decode(response.body);
          var listofcompanies = userdata['data'];

          for (var data in listofcompanies)
          {
            posts.add(questiondata.fromJson(data));

          }

        }


      }



      return posts;
    }


  }
  getuquizdata(BuildContext context) async {

    var url=Uri.parse(quizdetailUrl);

    var response= await http.get(url);


    log(response.body);

    var userdata = await json.decode(response.body);

    log(response.body);

    quizdetailModel userm = quizdetailModel.fromJson(userdata["data"][0]);
    return userm;

  }


}


