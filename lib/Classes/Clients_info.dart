class Clients_info {
  Clients_info(
      {this.goal,
      this.weight,
      this.weightLoss,
      this.gender,
      this.activityLevel,
      this.dob,
      this.height,
      this.mail,
      this.password,
      this.username,
      this.UID,
      this.kcal,
      this.carbs,
      this.fats,
      this.proteins});
  factory Clients_info.fromMap(Map<String, dynamic> data) {
    return Clients_info(
      activityLevel: data['Activity level'],
      dob: data['Date of Birth'].toString(),
      gender: data['Gender'],
      goal: data['Goal'],
      height: data['Height'],
      password: data['Password'],
      username: data['Username'],
      weight: data['Weight'],
      weightLoss: data['Weight Loss'],
      kcal: data['Kcal'],
      carbs: data['Carbs'],
      fats: data['Fats'],
      proteins: data['Proteins'],
      mail: data['Mail'],
    );
  }
  String? UID;
  String? goal;
  double? weight;
  double? weightLoss;
  String? gender;
  String? activityLevel;
  double? height;
  String? dob;
  String? username;
  String? mail;
  String? password;
  int? kcal;
  int? carbs;
  int? proteins;
  int? fats;
}
