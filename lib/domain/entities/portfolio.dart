import 'education.dart';
import 'experience.dart';
import 'featured_project.dart';
import 'localized_text.dart';

final class Portfolio {
  final String name;
  final String headline;
  final LocalizedText introduction;
  final String location;
  final String linkedinUrl;
  final String githubUrl;
  final String mediumUrl;
  final String stackOverflowUrl;
  final List<String> skills;
  final List<String> languages;
  final List<Experience> experiences;
  final List<Education> education;
  final FeaturedProject featuredProject;

  const Portfolio({
    required this.name,
    required this.headline,
    required this.introduction,
    required this.location,
    required this.linkedinUrl,
    required this.githubUrl,
    required this.mediumUrl,
    required this.stackOverflowUrl,
    required this.skills,
    required this.languages,
    required this.experiences,
    required this.education,
    required this.featuredProject,
  });
}
