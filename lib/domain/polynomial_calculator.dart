
String derivative(String polynomial) {
  polynomial = polynomial.replaceAll(' ', ''); //Remove spaces in the polynomial

  // Regular expression to match polynomial terms
  final termRegex = RegExp(r'([+-]?\d*)x(\^\d+)?|([+-]?\d+)');
  final matches = termRegex.allMatches(polynomial);

  List<String> derivativeTerms = [];

  for (var match in matches) {
    String? coefficient = match.group(1); // Coefficient part
    String? exponent = match.group(2); // Exponent part
    String? constant = match.group(3); // Constant term

    if (constant != null) {
      // Constant term (derivative is zero, ignore)
      continue;
    }

    // Handle cases where coefficient or exponent is not explicitly given
    coefficient = coefficient == '-'
        ? '-1'
        : (coefficient == '+' || coefficient == null ? '1' : coefficient);
    int coeff = int.parse(coefficient);
    int exp = exponent != null ? int.parse(exponent.substring(1)) : 1;

    // Compute new coefficient and exponent
    int newCoeff = coeff * exp;
    int newExp = exp - 1;

    if (newExp == 0) {
      // x^0 -> constant
      derivativeTerms.add('$newCoeff');
    } else if (newExp == 1) {
      // x^1 -> x
      derivativeTerms.add('${newCoeff}x');
    } else {
      derivativeTerms.add('${newCoeff}x^$newExp');
    }
  }
  print("Derivative terms are here $derivativeTerms");

  // Join terms into the final derivative string
  return derivativeTerms.join(' + ').replaceAll('+ -', '- ');
}

void main() {
  // Test cases
  String polynomial = "3x^2 + 2x - 5";
  print("Polynomial: $polynomial");
  print("Derivative: ${derivative(polynomial)}");
}
