import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../admin/models/course.dart';
import '../admin/models/participent.dart';
import '../models/attendence.dart';
import '../models/link.dart';
import '../models/task.dart';

class FirestoreHelper {
  FirestoreHelper._();
  static FirestoreHelper firestoreHelper = FirestoreHelper._();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  //login
  Future<AppUser> getUserFromFirestore(String courseId, String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestore
        .collection('courses')
        .doc(courseId)
        .collection('participents')
        .doc(id)
        .get();
    Map<String, dynamic>? data = documentSnapshot.data();
    AppUser appUser = AppUser.fromMap(data!);
    return appUser;
  }

  //get course
  Future<Course> getCourseFromFirestore(String id) async {
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await firestore.collection('courses').doc(id).get();
    Map<String, dynamic>? data = documentSnapshot.data();
    Course course = Course.fromMap(data!);
    return course;
  }

  //// admin methods
  ///courses
  Future<String?> addNewCourse(Course course) async {
    try {
      DocumentReference<Map<String, dynamic>> courseDocument =
          await firestore.collection('courses').add(course.toMap());

      return courseDocument.id;
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool> deleteCourse(String id) async {
    try {
      await firestore.collection('courses').doc(id).delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<List<Course>?> getAllCourses() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('courses').get();
      List<Course>? courses = snapshot.docs.map((doc) {
        return Course.fromMap(doc.data());
      }).toList();
      return courses;
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<bool?> updateCourse(Course course) async {
    try {
      await firestore
          .collection('courses')
          .doc(course.id)
          .update(course.toMap());
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  ///participents
  Future<List<AppUser>?> getParticipents(String courseId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('courses')
        .doc(courseId)
        .collection('participents')
        .get();
    return querySnapshot.docs.map((doc) {
      return AppUser.fromMap(doc.data());
    }).toList();
  }

  addNewParticipent(AppUser appUser) async {
    firestore
        .collection('courses')
        .doc(appUser.courseId)
        .collection('participents')
        .doc(appUser.id)
        .set(appUser.toMap());
  }

  Future<bool?> updateParticipent(AppUser user) async {
    try {
      await firestore
          .collection('courses')
          .doc(user.courseId)
          .collection('participents')
          .doc(user.id)
          .update(user.toMap());
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> deleteParticipent(AppUser user) async {
    try {
      await firestore
          .collection('courses')
          .doc(user.courseId)
          .collection('participents')
          .doc(user.id)
          .delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  ////inside the course(user methods):
  // tasks functions
  Future<String?> addNewTask(Task task) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await firestore
              .collection('courses')
              .doc(task.courseId)
              .collection('tasks')
              .add(task.toMap());
      return documentReference.id;
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Task>?> getAllTasks(String courseId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('courses')
        .doc(courseId)
        .collection('tasks')
        .get();
    return querySnapshot.docs.map((doc) {
      return Task.fromMap(doc.data());
    }).toList();
  }

  Future<bool> deleteTask(Task task) async {
    try {
      await firestore
          .collection('courses')
          .doc(task.courseId)
          .collection('tasks')
          .doc(task.id)
          .delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool?> updateTask(Task task) async {
    try {
      await firestore
          .collection('courses')
          .doc(task.courseId)
          .collection('tasks')
          .doc(task.id)
          .update(task.toMap());
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  //// questions functions
  Future<String?> addNewQuestion(Attendence question) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await firestore
              .collection('courses')
              .doc(question.courseId)
              .collection('questions')
              .add(question.toMap());
      return documentReference.id;
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Attendence>?> getAllQuestions(String courseId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('courses')
        .doc(courseId)
        .collection('questions')
        .get();
    return querySnapshot.docs.map((doc) {
      return Attendence.fromMap(doc.data());
    }).toList();
  }

  Future<bool> deleteQuestion(Attendence question) async {
    try {
      await firestore
          .collection('courses')
          .doc(question.courseId)
          .collection('questions')
          .doc(question.id)
          .delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool?> updateAttendence(Attendence attendence) async {
    try {
      await firestore
          .collection('courses')
          .doc(attendence.courseId)
          .collection('questions')
          .doc(attendence.id)
          .update(attendence.toMap());
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  //// links functions
  Future<String?> addNewLink(Link link) async {
    try {
      DocumentReference<Map<String, dynamic>> documentReference =
          await firestore
              .collection('courses')
              .doc(link.courseId)
              .collection('links')
              .add(link.toMap());
      return documentReference.id;
    } on Exception catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<Link>?> getAllLinks(String courseId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await firestore
        .collection('courses')
        .doc(courseId)
        .collection('links')
        .get();
    return querySnapshot.docs.map((doc) {
      return Link.fromMap(doc.data());
    }).toList();
  }

  Future<bool> deleteLink(Link link) async {
    try {
      await firestore
          .collection('courses')
          .doc(link.courseId)
          .collection('links')
          .doc(link.id)
          .delete();
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool?> updateLink(Link link) async {
    try {
      await firestore
          .collection('courses')
          .doc(link.courseId)
          .collection('links')
          .doc(link.id)
          .update(link.toMap());
      return true;
    } on Exception catch (e) {
      log(e.toString());
      return false;
    }
  }
}
