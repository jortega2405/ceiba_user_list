
class Posts {
  int userId;
  int id;
  String title;
  

  Posts({
    required this.userId,
    required this.id,
    required this.title,
    });
    
    factory Posts.fromJson(Map<String,dynamic> json){
      return Posts(
        userId: json["userId"] as int,
        id: json["id"] as int, 
        title: json["title"] as String,
      );
    }
}