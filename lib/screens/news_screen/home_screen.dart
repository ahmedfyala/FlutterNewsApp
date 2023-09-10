import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news/componants/sources_title.dart';
import 'package:news/models/category_model.dart';
import 'package:news/network/remote/api_manager.dart';
import 'package:news/screens/news_screen/catigories_screen.dart';
import 'package:news/screens/news_screen/news_screen.dart';
import '../../componants/drawer_item.dart';
import '../../componants/source_item.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'news';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSource = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerItem(onDrawerClicked),
      appBar: AppBar(
        title: Text(
          "News App",
          style: GoogleFonts.elMessiri(fontWeight: FontWeight.w100),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
        ],
        backgroundColor: Color(0xFF39A552),
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      body: model == null
          ? CategoriesScreen(onCategoryClicked)
          : NewsScreen(model!),
    );
  }

  CategoryModel? model = null;

  onCategoryClicked(categorymodel) {
    model = categorymodel;
    setState(() {});
  }

  onDrawerClicked(number) {
    if (number == DrawerItem.category) {
      model = null;
      Navigator.pop(context);
      setState(() {});
    } else if (number == DrawerItem.setting) {}
  }
}
// Container(
//   height: 40,
//   child: ListView.separated(
//     separatorBuilder: (context, index) => SizedBox(
//       width: 12,
//     ),
//     scrollDirection: Axis.horizontal,
//     itemCount: sources.length,
//     itemBuilder: (context, index) {
//       return InkWell(
//           onTap: () {
//             currentSource = index;
//             setState(() {});
//           },
//           child: SourceItem(
//               sources[index].name ?? "",
//               sources.elementAt(currentSource) ==
//                   sources[index]));
//     },
//   ),
// ),
