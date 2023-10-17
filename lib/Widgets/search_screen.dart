import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lhere/Utils/styles.dart';

import '../Constants/constants.dart';
import '../Model/postModel.dart';
import '../View/Homescreen/Pages/jobdetails.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.postlist}) : super(key: key);
  final List<postModel> postlist;
  static open(BuildContext context, List<postModel> postlist) {
    Navigator.of(context).push(CupertinoPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        return SearchScreen(postlist: postlist);
      },
    ));
  }

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<postModel> result = [];
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      result.addAll(widget.postlist);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final styles = TextStyles();
    return Scaffold(
      body: Stack(
        children: [
          ListView.separated(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 70),
            itemBuilder: (context, index) {
              final post = result[index];
              return ListTile(
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.focusedChild?.unfocus();
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => jobdetail(post)),
                  );
                },
                leading: SizedBox(
                  width: 70,
                  child: FadeInImage.assetNetwork(
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Container(
                      width: 70,
                      color: Colors.grey[200],
                    ),
                    placeholder: "assets/place.png",
                    image: post.image ?? '',
                    fit: BoxFit.cover,
                  ),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(post.title ?? '', style: styles.body),
                    if (post.skill!.isNotEmpty)
                      Text(post.city ?? '', style: styles.subtitle1),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: [
                      Text("${post.city}, Austria"),
                      const SizedBox(width: 4),
                      const Icon(Icons.pin_drop, size: 15),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: result.length,
          ),
          Container(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            decoration: BoxDecoration(
              color: primarycolor,
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Flexible(
                  child: CupertinoSearchTextField(
                    autofocus: true,
                    backgroundColor: Colors.white,
                    onChanged: (value) {
                      result = widget.postlist.where(
                        (element) {
                          if (element.city == null) return true;
                          return element.city!.toLowerCase().contains(
                                value.toLowerCase(),
                              );
                        },
                      ).toList();
                      setState(() {});
                    },
                  ),
                ),
                CupertinoButton(
                  onPressed: () {
                    FocusScopeNode currentFocus = FocusScope.of(context);
                    if (!currentFocus.hasPrimaryFocus) {
                      currentFocus.focusedChild?.unfocus();
                    }
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
