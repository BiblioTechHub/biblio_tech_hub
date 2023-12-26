import 'package:test/test.dart';

int sum(int a, int b) {
  return a + b;
}

void main() {
  test('Sum function should return the correct result', () {
    expect(sum(1, 2), 3);
    expect(sum(-1, 2), 1);
  });
}
