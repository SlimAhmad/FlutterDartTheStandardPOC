class NullCustomerException implements Exception {
  final String message;

  const NullCustomerException({
    this.message = 'Customer is null.',
  });

  @override
  String toString() =>
      'NullCustomerException: $message';
}

class InvalidCustomerException implements Exception {
  final String message;

  const InvalidCustomerException({
    this.message = 'Customer is invalid.',
  });

  @override
  String toString() =>
      'InvalidCustomerException: $message';
}