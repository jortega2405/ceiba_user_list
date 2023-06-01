import 'dart:async';
import 'package:ceiba_user_list/models/user_model.dart';
import 'package:ceiba_user_list/services/user_service.dart';

class HomeScreenViewModel {
  final StreamController<List<UserModel>> _filteredUsersController =
      StreamController<List<UserModel>>.broadcast();

  Stream<List<UserModel>> get filteredUsersStream =>
      _filteredUsersController.stream;

  List<UserModel> _users = [];
  List<UserModel> _filteredUsers = [];

  void init() async {
    try {
      _users = await UserServices.getUsers();
      _filteredUsers = _users;
      _filteredUsersController.add(_filteredUsers);
    } catch (error) {
      _filteredUsersController.addError(error);
    }
  }

  void filterUsers(String filter) {
    _filteredUsers = _users.where((u) =>
        u.name!.toLowerCase().contains(filter.toLowerCase()) ||
        u.phone!.toLowerCase().contains(filter.toLowerCase()) ||
        u.email!.toLowerCase().contains(filter.toLowerCase())).toList();
    _filteredUsersController.add(_filteredUsers);
  }

  void dispose() {
    _filteredUsersController.close();
  }
}
