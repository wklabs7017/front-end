class Equipment {
  final String equipmentStatus;
  final String manufacturer;
  final String modelName;
  final String contactInformation;
  final DateTime installationDate;
  bool selected = false;

  Equipment(
    this.equipmentStatus,
    this.manufacturer,
    this.modelName,
    this.contactInformation,
    this.selected,
    this.installationDate,
  );
}
