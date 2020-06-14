import 'package:flutterfirebasecrud/model/CategoryModel.dart';

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

  return categoryList;
}
