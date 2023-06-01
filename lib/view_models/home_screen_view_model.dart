import 'dart:async';
import 'package:ceiba_user_list/models/db_helper.dart';
import 'package:ceiba_user_list/models/user_model.dart';
import 'package:ceiba_user_list/services/user_service.dart';

class HomeScreenViewModel {
  final StreamController<List<UserModel>> _filteredUsersController =
      StreamController<List<UserModel>>.broadcast();

  Stream<List<UserModel>> get filteredUsersStream =>
      _filteredUsersController.stream;

  List<UserModel> _users = [];
  List<UserModel> _filteredUsers = [];
  final DbHelper _dbHelper = DbHelper();

  void init() async {
    try {
      _users = await _dbHelper.getUserList();
      if (_users.isEmpty) {
        _users = await UserServices.getUsers();

        for (var element in _users) {
          _dbHelper.insertUsers(element);
        }
      }

      _filteredUsers = _users;
      _filteredUsersController.add(_filteredUsers);
    } catch (error) {
      _filteredUsersController.addError(error);
    }
  }

  bool filterUsers(String filter) {
    _filteredUsers = _users
        .where((u) =>
            u.name!.toLowerCase().contains(filter.toLowerCase()) ||
            u.phone!.toLowerCase().contains(filter.toLowerCase()) ||
            u.email!.toLowerCase().contains(filter.toLowerCase()))
        .toList();
    _filteredUsersController.add(_filteredUsers);
    return _filteredUsers.isEmpty;
  }

  void dispose() {
    _filteredUsersController.close();
  }
}
