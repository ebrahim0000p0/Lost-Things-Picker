class PossModel {
  final String possessId;
  final String ownerId;
  final String description;
  final String picture;
  final String serialNumber;
  final String category;
  final String ownerName;
  PossModel(
      {this.possessId,
      this.ownerId,
      this.description,
      this.picture,
      this.serialNumber,
      this.category,
      this.ownerName});

  toJson() {
    return {
      'category': category,
      'serialNumber': serialNumber,
      'description': description,
      'ownerId': ownerId,
      'picture': picture,
      'possessId': possessId,
      'ownerName': ownerName,
    };
  }
}
