import 'package:flutter/material.dart';
import 'package:mynewsapp/constants/MyConstansts.dart';
import 'package:mynewsapp/helper/News.dart';
import 'package:mynewsapp/helper/data.dart';
import 'package:mynewsapp/model/CategoryModel.dart';
import 'package:mynewsapp/model/NewsArticleModel.dart';
import 'package:mynewsapp/ui/Articles.dart';
import 'package:mynewsapp/ui/Categories.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoryModel> categoryItems = new List<CategoryModel>();
  List<NewsArticleModel> _newsArticle = new List<NewsArticleModel>();

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    categoryItems = getAllCategories();

    getNews();
  }

  //fetch news from api
  getNews() async {
    // News newsItems = new News();
    // await newsItems.getAllNews();

    // _newsArticle = newsItems.newsList;

    setState(() {
      isLoading = false;
    });

    _newsArticle = await new News().getAllNews().asStream().toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "MyNews",
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "App",
              style: TextStyle(color: Colors.black),
            )
          ],
        ),
      ),
      body: isLoading
          ? Center(
              child: Container(
                child: CircularProgressIndicator(), //progress bar
              ),
            )
          : ListView(
              children: <Widget>[
                //news categories
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: MyConstants.margin16),
                  height: MyConstants.columnHeight70,
                  child: ListView.builder(
                    itemCount: categoryItems.length,
                    itemBuilder: (context, index) {
                      return TitleCategory(
                        title: categoryItems[index].categoryName,
                      );
                    },
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),

                //news tiles
                SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
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
                ),
              ],
            ),
    );
  }
}

//news title category
class TitleCategory extends StatelessWidget {
  final title;
  TitleCategory({this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        String titleToLowerCase = title.toString().toLowerCase();
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            Categories(categoryTitle: titleToLowerCase,)));
      },
      child: Container(
        margin: EdgeInsets.all(MyConstants.margin8),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(MyConstants.margin8),
              child: Container(
                child: Text(
                  title,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: MyConstants.font16,
                      fontWeight: FontWeight.w500),
                ),
                alignment: Alignment.center,
                width: MyConstants.imageWidth120,
                height: MyConstants.imageHeight60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(MyConstants.margin8),
                  color: Colors.black,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//news blog tiles
class NewsBlogTile extends StatelessWidget {
  final imageUrl, title, description, url;

  NewsBlogTile({@required this.imageUrl,
    @required this.title,
    @required this.description, @required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //pass news details
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Articles(newsUrl: url,)));
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
