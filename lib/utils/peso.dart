/// Formats a price as Philippine Peso, e.g. 30 -> ₱30.00
String formatPeso(double price) {
  return '₱${price.toStringAsFixed(2)}';
}
