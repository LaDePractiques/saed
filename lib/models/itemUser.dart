class ItemUser {
  String expanded;
  String title;
  bool isExpanded;

  ItemUser(String expanded, String title, bool isExpanded) {
    this.expanded = expanded;
    this.title = title;
    this.isExpanded = isExpanded;
  }

  get getExpanded => this.expanded;
  get getTitle => this.title;
  get getIsExpanded => this.isExpanded;
}
