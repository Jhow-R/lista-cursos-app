class Database {

  bool created = false;

  Future<bool> createDatabase() async {
    await Future.delayed( Duration(seconds: 2));
    this.created = true;
    return created;
  }

}
