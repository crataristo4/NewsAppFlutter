import 'package:mynewsapp/model/CategoryModel.dart';

List<CategoryModel> getAllCategories() {
  List<CategoryModel> categoryList = new List<CategoryModel>();

  //business
  CategoryModel categoryModel = new CategoryModel();
  categoryModel.categoryName = "Business";
  categoryList.add(categoryModel);

//entertainment
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Entertainment";
  categoryList.add(categoryModel);

  //General
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "General";
  categoryList.add(categoryModel);

  //sports
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Sports";
  categoryList.add(categoryModel);

  //tech
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Technology";
  categoryList.add(categoryModel);

  //health
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Health";
  categoryList.add(categoryModel);

  //science
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Science";
  categoryList.add(categoryModel);

  return categoryList;
}
