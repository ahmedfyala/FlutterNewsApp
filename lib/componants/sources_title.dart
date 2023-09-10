import 'package:flutter/material.dart';
import 'package:news/componants/news_item.dart';
import 'package:news/models/SourcesResponse.dart';
import 'package:news/network/remote/api_manager.dart';
import 'package:news/componants/source_item.dart';

class SourcesTitle extends StatefulWidget {
  List<Sources> sources;

  // Function onClick;

  SourcesTitle(this.sources);

  @override
  State<SourcesTitle> createState() => _SourcesTitleState();
}

class _SourcesTitleState extends State<SourcesTitle> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DefaultTabController(
          length: widget.sources.length,
          child: TabBar(
            onTap: (value) {
              // onClick(value){}
              index = value;
              setState(() {});
            },
            indicatorColor: Colors.transparent,
            isScrollable: true,
            tabs: widget.sources.map((e) {
              return SourceItem(
                  e.name ?? "", widget.sources.indexOf(e) == index);
            }).toList(),
            padding: EdgeInsets.only(top: 8),
          ),
        ),
        FutureBuilder(
          future: ApiManager.getNewsData(widget.sources[index].id ?? ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text("something went wrong"));
            }
            var articls = snapshot.data?.articles ?? [];
            return Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return NewsItem(articls[index]);
                },
                itemCount: articls.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
