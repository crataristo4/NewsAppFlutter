import 'package:flutter/material.dart';
import 'package:mynewsapp/constants/MyConstansts.dart';
import 'package:mynewsapp/helper/News.dart';
import 'package:mynewsapp/model/NewsArticleModel.dart';
import 'package:mynewsapp/ui/Articles.dart';

class Categories extends StatefulWidget {
  final categoryTitle;

  Categories({this.categoryTitle});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isLoading = true;
  List<NewsArticleModel> _newsArticle = new List<NewsArticleModel>();

  @override
  void initState() {
    super.initState();

    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNews categoryNews = new CategoryNews();
    await categoryNews.getCategoryNews(widget.categoryTitle);
    _newsArticle = categoryNews.categoryNewsList;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.categoryTitle[0].toString().toUpperCase() +
            widget.categoryTitle.toString().substring(1)),
        elevation: 0,
      ),
      body: isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(), //progress bar
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    //news tiles
                    Container(
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _newsArticle.length,
                          itemBuilder: (context, index) {
                            return NewsBlogTile(
                              imageUrl: _newsArticle[index].urlToImage,
                              title: _newsArticle[index].title,
                              description: _newsArticle[index].description,
                              url: _newsArticle[index].url,
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

//news blog tiles
class NewsBlogTile extends StatelessWidget {
  final imageUrl, title, description, url;

  NewsBlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.description,
      @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //pass news details
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Articles(
                      newsUrl: url,
                    )));
      },
      child: Container(
        margin: EdgeInsets.all(MyConstants.margin8),
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(MyConstants.margin8),
                child: Image.network(imageUrl)),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  fontSize: MyConstants.font16),
            ),
            SizedBox(
              height: MyConstants.margin8,
            ),
            Text(
              description,
              style: TextStyle(color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
