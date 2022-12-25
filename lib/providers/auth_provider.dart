import 'package:flutter/material.dart';
import 'package:gsg_app/admin/models/course.dart';
import 'package:gsg_app/models/attendence.dart';
import 'package:string_validator/string_validator.dart';
import '../app_router/app_router.dart';
import '../data_repositories/auth_helper.dart';
import '../data_repositories/firestore_helper.dart';
import '../models/app_user.dart';
import '../models/link.dart';
import '../models/task.dart';
import '../views/screens/join_as_screen.dart';
import '../views/screens/course_screens/user_main_screen.dart';

class AuthProvider extends ChangeNotifier {
  GlobalKey<FormState> signInKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordRegisterController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  AppUser? loggedUser;
  Course? loggedCourse;
  //dark mode
  bool isDarkMode = false;
  changeIsDarkMode() {
    isDarkMode = !isDarkMode;
    notifyListeners();
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

  //user methods
  signIn(Course course) async {
    if (signInKey.currentState!.validate()) {
      String? userId = await AuthHelper.authHelper
          .signIn(loginEmailController.text, passwordLoginController.text);
      if (userId != null) {
        loggedUser =
            await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId);
        notifyListeners();
        if (loggedUser != null && loggedUser!.isTrainer) {
          AppRouter.appRouter.goToWidgetAndReplace(UserMainScreen(
            isTrainer: loggedUser!.isTrainer,
            course: course,
          ));
        }
      }
    }
  }

  signUp(Course course, bool isTrainer) async {
    if (signUpKey.currentState!.validate()) {
      String? result = await AuthHelper.authHelper.signUp(
          registerEmailController.text, passwordRegisterController.text);
      if (result != null) {
        loggedUser = await FirestoreHelper.firestoreHelper.addNewUser(AppUser(
            id: result,
            courseId: course.id!,
            isTrainer: isTrainer,
            email: registerEmailController.text,
            userName: userNameController.text,
            phoneNumber: phoneController.text));
        AppRouter.appRouter.goToWidgetAndReplace(UserMainScreen(
          isTrainer: loggedUser!.isTrainer,
          course: course,
        ));
      }
    }
  }

  getUser(String id) async {
    loggedUser = await FirestoreHelper.firestoreHelper.getUserFromFirestore(id);
    loggedUser!.id = id;
    notifyListeners();
  }

  getCourse(String id) async {
    loggedCourse =
        await FirestoreHelper.firestoreHelper.getCourseFromFirestore(id);
    loggedCourse!.id = id;
    notifyListeners();
  }

  checkUser() async {
    await Future.delayed(const Duration(seconds: 3));
    String? userId = AuthHelper.authHelper.checkUser();
    if (userId != null) {
      getUser(userId);
      AppRouter.appRouter.goToWidgetAndReplace(UserMainScreen(
        isTrainer: loggedUser!.isTrainer,
        course: getCourse(loggedUser!.courseId),
      ));
    } else {
      AppRouter.appRouter.goToWidgetAndReplace(const JoinAsScreen());
    }
  }

  signOut() async {
    await AuthHelper.authHelper.signOut();
    AppRouter.appRouter.goToWidgetAndReplace(const JoinAsScreen());
  }

  //task methods
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController taskSubmitionController = TextEditingController();
  TextEditingController taskMarkController = TextEditingController();
  TextEditingController taskDeadlineController = TextEditingController();
  GlobalKey<FormState> addTaskKey = GlobalKey();
  addNewTask(String courseId) async {
    if (addTaskKey.currentState!.validate()) {
      AppRouter.appRouter.showLoadingDialog();
      Task task = Task(
          publishingTime: DateTime.now(),
          title: taskTitleController.text,
          description: taskDescriptionController.text,
          deadline: DateTime.parse(taskDeadlineController.text),
          mark: int.parse(
              taskMarkController.text == '' ? '0' : taskMarkController.text),
          courseId: courseId);

      String? id = await FirestoreHelper.firestoreHelper.addNewTask(task);

      AppRouter.appRouter.hideDialog();
      if (id != null) {
        task.id = id;
        await FirestoreHelper.firestoreHelper.updateTask(task);
        allTasks.add(task);
        getAllTasks(courseId);
        notifyListeners();
        taskTitleController.clear();
        taskDescriptionController.clear();
        taskDeadlineController.clear();
        notifyListeners();
        AppRouter.appRouter.showCustomDialog('Success', 'Task has been added');
      }
    }
  }

  List<Task> allTasks = [];
  getAllTasks(String courseId) async {
    //allTasks = null;
    notifyListeners();
    List<Task>? tasks =
        await FirestoreHelper.firestoreHelper.getAllTasks(courseId);
    allTasks = tasks ?? [];
    notifyListeners();
  }

  updateTask(Task task) async {}
  deleteTask(Task task) async {}

  //attendence methods
  addNewQuestion(String courseId) async {
    AppRouter.appRouter.showLoadingDialog();
    Attendence attendence =
        Attendence(publishingTime: DateTime.now(), courseId: courseId);

    String? id =
        await FirestoreHelper.firestoreHelper.addNewQuestion(attendence);

    AppRouter.appRouter.hideDialog();
    if (id != null) {
      attendence.id = id;
      await FirestoreHelper.firestoreHelper.updateAttendence(attendence);
      allAttendenceQuestions.add(attendence);
      getAllQuestions(courseId);
      notifyListeners();
      AppRouter.appRouter
          .showCustomDialog('Success', 'Attendence Question has been added');
    }
  }

  List<Attendence> allAttendenceQuestions = [];
  getAllQuestions(String courseId) async {
    notifyListeners();
    List<Attendence>? questions =
        await FirestoreHelper.firestoreHelper.getAllQuestions(courseId);
    allAttendenceQuestions = questions ?? [];
    notifyListeners();
  }

  deleteQuestion(Attendence attendence) async {}

  //link methods
  TextEditingController linkUrlController = TextEditingController();
  TextEditingController linkDescriptionController = TextEditingController();
  addNewLink(String courseId) async {
    if (addTaskKey.currentState!.validate()) {
      AppRouter.appRouter.showLoadingDialog();
      Link link = Link(
          description: linkDescriptionController.text,
          url: linkUrlController.text,
          courseId: courseId);

      String? id = await FirestoreHelper.firestoreHelper.addNewLink(link);

      AppRouter.appRouter.hideDialog();
      if (id != null) {
        link.id = id;
        await FirestoreHelper.firestoreHelper.updateLink(link);
        allLinks.add(link);
        getAllLinks(courseId);
        notifyListeners();
        linkUrlController.clear();
        linkDescriptionController.clear();
        notifyListeners();
        AppRouter.appRouter.showCustomDialog('Success', 'Link has been added');
      }
    } else {
      AppRouter.appRouter.showCustomDialog('Error', 'Something went wrong');
    }
  }

  List<Link> allLinks = [];
  getAllLinks(String courseId) async {
    //allLinks = null;
    notifyListeners();
    List<Link>? links =
        await FirestoreHelper.firestoreHelper.getAllLinks(courseId);
    allLinks = links ?? [];
    notifyListeners();
  }

  updateLink(Link link) async {}
  deleteLink(Link link) async {}
}
