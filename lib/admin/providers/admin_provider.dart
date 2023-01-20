import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:string_validator/string_validator.dart';
import '../../app_router/app_router.dart';
import '../../data_repositories/auth_helper.dart';
import '../../data_repositories/firestore_helper.dart';
import '../models/participent.dart';
import '../models/course.dart';

class AdminProvider extends ChangeNotifier {
  AdminProvider() {
    getAllCourses();
  }

  //validation methods
  String? emailValidation(String? email) {
    if (email == null || email.isEmpty) {
      return 'Required Field';
    } else if (!(isEmail(email))) {
      return 'Incorrect Email Syntax';
    }
    return null;
  }

  String? passwordValidation(String? password) {
    if (password == null || password.isEmpty) {
      return 'Required Field';
    } else if (password.length <= 6) {
      return 'Password must be larger than 6 characters';
    }
    return null;
  }

  String? requiredValidation(String? content) {
    if (content == null || content.isEmpty) {
      return "Required field";
    }
    return null;
  }

  String? phoneValidation(String content) {
    if (!isNumeric(content)) {
      return "Incorrect phone number";
    }
    return null;
  }

  String? urlValidation(String content) {
    if (!isURL(content)) {
      return "Incorrect URL Syntax";
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
  getAllCourses() async {
    allCourses = await FirestoreHelper.firestoreHelper.getAllCourses() ?? [];
    notifyListeners();
  }

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

  //Participents methods
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneNumberController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  AppUser? loggedUser;

  addNewParticipent(Course course, bool isTrainer) async {
    if (signUpKey.currentState!.validate()) {
      String? result = await AuthHelper.authHelper
          .signUp(userEmailController.text, userPasswordController.text);
      if (result != null) {
        loggedUser = await FirestoreHelper.firestoreHelper.addNewParticipent(
            AppUser(
                id: result,
                courseId: course.id!,
                isTrainer: isTrainer,
                email: userEmailController.text,
                userName: userNameController.text,
                phoneNumber: userPhoneNumberController.text,
                password: userPasswordController.text));
      }
    }
  }

  List<AppUser> allParticipents = [];
  getAllParticipents(String courseId) async {
    List<AppUser>? users =
        await FirestoreHelper.firestoreHelper.getParticipents(courseId);
    allParticipents = users ?? [];
    notifyListeners();
  }

  updateParticipent(AppUser user) async {
    AppRouter.appRouter.showLoadingDialog();
    AppUser newUser = AppUser(
      id: user.id,
      courseId: user.courseId,
      userName: userNameController.text.isEmpty
          ? user.userName
          : userNameController.text,
      email: userEmailController.text.isEmpty
          ? user.email
          : userEmailController.text,
      phoneNumber: userPhoneNumberController.text.isEmpty
          ? user.phoneNumber
          : userPhoneNumberController.text,
      password: userPasswordController.text.isEmpty
          ? user.phoneNumber
          : userPhoneNumberController.text,
    );

    bool? isUpdated =
        await FirestoreHelper.firestoreHelper.updateParticipent(newUser);

    if (isUpdated != null && isUpdated) {
      int index = allParticipents.indexOf(user);
      allParticipents[index] = newUser;
      userEmailController.clear();
      userPhoneNumberController.clear();
      userNameController.clear();
      notifyListeners();
      AppRouter.appRouter.hideDialog();
      AppRouter.appRouter.hideDialog();
    }
  }

  deleteParticipent(AppUser user) async {
    AppRouter.appRouter.showLoadingDialog();
    bool isDeleted =
        await FirestoreHelper.firestoreHelper.deleteParticipent(user);
    if (isDeleted) {
      AuthHelper.authHelper.firebaseAuth.currentUser!.delete();
      allParticipents.remove(user);
      notifyListeners();
    }
    AppRouter.appRouter.hideDialog();
  }
}
