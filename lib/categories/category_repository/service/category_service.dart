import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/category.dart';

class CategoryService {
  final FirebaseFirestore _firestore;
  final String _collectionName = 'categories';

  CategoryService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get categoriesCollection =>
      _firestore.collection(_collectionName);

  Future<List<Category>> getAllCategories() async {
    final snapshot = await categoriesCollection.get();
    return snapshot.docs
        .map((doc) => Category.fromJson({'id': doc.id, ...doc.data()}))
        .toList();
  }

  Future<Category?> getCategoryById(String id) async {
    final doc = await categoriesCollection.doc(id).get();
    if (doc.exists) {
      return Category.fromJson({'id': doc.id, ...doc.data() ?? {}});
    }
    return null;
  }

  Future<void> addCategory(Category category) async {
    await categoriesCollection
        .doc(category.id)
        .set(category.toJson()..remove('id'));
  }

  Future<void> updateCategory(Category category) async {
    await categoriesCollection
        .doc(category.id)
        .update(category.toJson()..remove('id'));
  }

  Future<void> deleteCategory(String id) async {
    await categoriesCollection.doc(id).delete();
  }
}
