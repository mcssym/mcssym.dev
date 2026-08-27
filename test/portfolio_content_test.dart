import 'package:flutter_test/flutter_test.dart';
import 'package:mcssym_dev/foundation/content/portfolio_content.dart';

void main() {
  test('portfolio has the expected identity and flagship project', () {
    expect(portfolioContent.name, 'Maxime Fankam');
    expect(portfolioContent.headline, 'Software Engineer');
    expect(portfolioContent.featuredProject.name, 'Flueco');
    expect(portfolioContent.featuredProject.role, 'Creator & Maintainer');
  });
}
