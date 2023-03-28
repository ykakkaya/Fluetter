import 'package:flutter/material.dart';
import 'package:news/viewmodel/article_list_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ArticleListViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Teknoloji Haberleri"),
          centerTitle: true,
        ),
        body: Center(
          child: ListView.builder(
              itemCount: vm.viewModel.articles.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(children: [
                    Image.network(vm.viewModel.articles[index].urlToImage ??
                        'https://img.tv100.com/rcman/Cw1280h720q95gc/storage/files/images/2022/10/26/son-dakika-eD6B_cover.jpg'),
                    ListTile(
                      title: Text(
                        vm.viewModel.articles[index].title ?? '',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      subtitle: Text(
                          vm.viewModel.articles[index].publishedAt.toString()),
                    ),
                    ButtonBar(
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              Uri uri = Uri.parse(
                                  vm.viewModel.articles[index].url.toString());
                              await launchUrl(uri);
                            },
                            child: Text("Habere Git"))
                      ],
                    )
                  ]),
                );
              }),
        ));
  }
}
