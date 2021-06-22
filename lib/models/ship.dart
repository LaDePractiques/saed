class Ship {
  int id;
  int ownerId;
  String identification;
  String name;
  int countryId;

  Ship({this.id, this.ownerId, this.identification, this.name, this.countryId});

  get getId => id;
  get getOwnerId => ownerId;
  get getIdentification => identification;
  get getName => name;
  get getCountryId => countryId;
}
