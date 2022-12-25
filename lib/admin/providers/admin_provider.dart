import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../app_router/app_router.dart';
import '../../data_repositories/firestore_helper.dart';
import '../models/course.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    getAllCourses();
  }
  String? requiredValidation(String? content) {
    if (content == null || content.isEmpty) {
      return "Required field";
    }
    return null;
  }

  // add new course
  File? imageFile;
  String? imageUrl;
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> courseFormKey = GlobalKey<FormState>();
  pickImageForCourse() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageUrl = pickedFile.path;
      imageFile = File(imageUrl!);
      notifyListeners();
    }
  }

  addNewCourse() async {
    if (imageFile != null) {
      if (courseFormKey.currentState!.validate()) {
        // add course process
        AppRouter.appRouter.showLoadingDialog();
        Course course = Course(
          imageUrl: imageUrl ?? '',
          name: nameController.text,
        );

        String? id = await FirestoreHelper.firestoreHelper.addNewCourse(course);

        AppRouter.appRouter.hideDialog();
        if (id != null) {
          course.id = id;
          await FirestoreHelper.firestoreHelper.updateCourse(course);
          allCourses.add(course);
          getAllCourses();
          notifyListeners();
          nameController.clear();
          imageFile = null;
          imageUrl = null;
          notifyListeners();
          AppRouter.appRouter
              .showCustomDialog('Success', 'Your course has been added');
        }
      }
    } else {
      AppRouter.appRouter
          .showCustomDialog('Error', 'You have to pick image first');
    }
  }

  // get courses
  List<Course> allCourses = [];
  //List<AppUser>? allUsers;
  getAllCourses() async {
    allCourses = await FirestoreHelper.firestoreHelper.getAllCourses() ?? [];
    notifyListeners();
  }

  /*getAllParticipents(String courseId) async {
    allUsers = await FirestoreHelper.firestoreHelper.getParticipents(courseId);
    notifyListeners();
  }*/

  // delete course
  deleteCourse(Course course) async {
    AppRouter.appRouter.showLoadingDialog();
    bool deleteSuccess =
        await FirestoreHelper.firestoreHelper.deleteCourse(course.id!);
    if (deleteSuccess) {
      allCourses.remove(course);
      notifyListeners();
    }
    AppRouter.appRouter.hideDialog();
  }

  updateCourse(Course course) async {
    AppRouter.appRouter.showLoadingDialog();
    if (imageUrl != null) {
      course.imageUrl = imageUrl!;
    }
    Course newCourse = Course(
      id: course.id,
      imageUrl: course.imageUrl,
      name: nameController.text.isEmpty ? course.name : nameController.text,
    );

    bool? isUpdated =
        await FirestoreHelper.firestoreHelper.updateCourse(newCourse);

    if (isUpdated != null && isUpdated) {
      int index = allCourses.indexOf(course);
      allCourses[index] = newCourse;
      imageFile = null;
      imageUrl = null;
      nameController.clear();
      notifyListeners();
      AppRouter.appRouter.hideDialog();
      AppRouter.appRouter.hideDialog();
    }
  }
}
