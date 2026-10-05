/// A delivery address typed in on the Select Address page.
class Address {
  const Address({
    required this.fullName,
    required this.line,
    required this.city,
    required this.pincode,
    required this.state,
    required this.saveIt,
  });

  final String fullName;
  final String line;
  final String city;
  final String pincode;
  final String state;

  /// "Save this Address" tickbox on the address page.
  final bool saveIt;

  /// Short one-line version, used in the bag and order confirmation.
  String get summary => '$line, $city $pincode';
}
