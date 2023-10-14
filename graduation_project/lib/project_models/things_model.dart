class ThingsModel {
  String location,
      category,
      ownerId,
      picture,
      ownerName,
      description,
      detailedAdderss;
  ThingsModel(
      {this.category,
      this.location,
      this.ownerId,
      this.picture,
      this.ownerName,
      this.description,
      this.detailedAdderss});
  toJson() {
    return {
      'category': category,
      'location': location,
      'owner': ownerId,
      'picture': picture,
      'ownerName': ownerName,
      'detailedAdderss': detailedAdderss,
      'describtion': description
    };
  }
}
