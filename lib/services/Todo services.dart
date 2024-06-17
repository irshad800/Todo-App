List<Map> Data = [];
void AddTask({required String title, required String details}) {
  Map<String, dynamic> m1 = {
    "title": title,
    "details": details,
    "isCompleted": false
  };
  Data.add(m1);
  print(Data);
}
