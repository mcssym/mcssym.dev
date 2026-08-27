import '../../domain/entities/education.dart';
import '../../domain/entities/experience.dart';
import '../../domain/entities/featured_project.dart';
import '../../domain/entities/localized_text.dart';
import '../../domain/entities/portfolio.dart';

const Portfolio portfolioContent = Portfolio(
  name: 'Maxime Fankam',
  headline: 'Software Engineer',
  introduction: LocalizedText(
    en: 'Software engineer with a full-stack background across mobile and web. I specialize in Flutter and mobile SDK development while staying deeply connected to JavaScript/TypeScript, React, Node.js and NestJS. I care about software architecture, developer tooling and open-source ecosystems that help teams move faster without locking them into specific implementations.',
    fr: 'Ingénieur logiciel avec un parcours full-stack couvrant le mobile et le web. Je suis spécialisé dans Flutter et le développement de SDK mobiles, tout en gardant une forte expérience en JavaScript/TypeScript, React, Node.js et NestJS. Je m’intéresse particulièrement à l’architecture logicielle, aux outils développeurs et aux écosystèmes open source qui accélèrent les équipes sans les enfermer dans une implémentation particulière.',
  ),
  location: 'Lyon, France',
  linkedinUrl: 'https://www.linkedin.com/in/mcssym/',
  githubUrl: 'https://github.com/mcssym',
  mediumUrl: 'https://medium.com/@mcssym',
  stackOverflowUrl: 'https://stackoverflow.com/users/8131314/mcssym',
  skills: <String>[
    'Flutter',
    'Dart',
    'Mobile SDKs',
    'Software Architecture',
    'Open Source',
    'JavaScript',
    'TypeScript',
    'React',
    'Node.js',
    'NestJS',
    'Symfony',
    'Full-stack Development',
  ],
  languages: <String>[
    'French — Native / Bilingual',
    'English — Professional Working',
    'German — Limited Working',
  ],
  experiences: <Experience>[
    Experience(
      company: 'Contentsquare',
      role: LocalizedText(en: 'Senior Software Engineer', fr: 'Senior Software Engineer'),
      start: 'May 2026',
      end: 'Present',
    ),
    Experience(
      company: 'Contentsquare',
      role: LocalizedText(en: 'Software Engineer', fr: 'Software Engineer'),
      start: 'Jul 2023',
      end: 'May 2026',
    ),
    Experience(
      company: 'Orkester',
      role: LocalizedText(en: 'Lead Full-stack Developer — Web / Flutter', fr: 'Lead Développeur Full-stack — Web / Flutter'),
      start: 'Jan 2022',
      end: 'Jun 2023',
      location: LocalizedText(en: 'Lyon, France', fr: 'Lyon, France'),
    ),
    Experience(
      company: 'Orkester',
      role: LocalizedText(en: 'Web / Flutter Developer', fr: 'Développeur Web / Flutter'),
      start: 'Dec 2020',
      end: 'Jan 2022',
      location: LocalizedText(en: 'Villeurbanne, France', fr: 'Villeurbanne, France'),
    ),
    Experience(
      company: 'Orkester',
      role: LocalizedText(en: 'Work-study Web Developer', fr: 'Alternant Développeur Web'),
      start: 'Oct 2019',
      end: 'Nov 2020',
      location: LocalizedText(en: 'Villeurbanne, France', fr: 'Villeurbanne, France'),
    ),
    Experience(
      company: 'Orkester',
      role: LocalizedText(en: 'Web Development Intern', fr: 'Stagiaire en développement Web'),
      start: 'Jul 2019',
      end: 'Sep 2019',
      location: LocalizedText(en: 'Villeurbanne, France', fr: 'Villeurbanne, France'),
    ),
    Experience(
      company: 'Orkester',
      role: LocalizedText(en: 'Web Development Intern', fr: 'Stagiaire en développement Web'),
      start: 'Feb 2019',
      end: 'Jun 2019',
      location: LocalizedText(en: 'Villeurbanne, France', fr: 'Villeurbanne, France'),
    ),
    Experience(
      company: 'Educati Inc',
      role: LocalizedText(en: 'Full-stack React / Node.js Developer', fr: 'Développeur Full-stack React / Node.js'),
      start: 'Dec 2016',
      end: 'Sep 2018',
      location: LocalizedText(en: 'Yaoundé, Cameroon', fr: 'Yaoundé, Cameroun'),
      summary: LocalizedText(
        en: 'Web and mobile development for a proprietary application solution.',
        fr: 'Développement web et mobile pour une solution applicative propriétaire.',
      ),
    ),
    Experience(
      company: 'Independent',
      role: LocalizedText(en: 'Symfony Web Developer', fr: 'Développeur Web Symfony'),
      start: 'Sep 2015',
      end: 'Nov 2016',
    ),
  ],
  education: <Education>[
    Education(
      institution: 'SUPINFO International University',
      program: LocalizedText(en: 'Master of Science — Computer Science', fr: 'Master of Science — Informatique'),
      period: '2018 — 2020',
    ),
    Education(
      institution: 'IAI Cameroun',
      program: LocalizedText(en: 'Engineer — Network & Systems Administration', fr: 'Ingénieur — Administration réseaux et systèmes'),
      period: '2013 — 2016',
    ),
    Education(
      institution: 'Douala University',
      program: LocalizedText(en: 'Mathematics & Computer Science', fr: 'Mathématiques et Informatique'),
      period: '2011 — 2013',
    ),
  ],
  featuredProject: FeaturedProject(
    name: 'Flueco',
    role: 'Creator & Maintainer',
    url: 'https://github.com/flutter-ecosystem/flueco',
    description: LocalizedText(
      en: 'A Flutter ecosystem focused on loosely coupled tools, shared abstractions and service providers. Flueco is designed to let applications choose implementations for concerns such as dependency injection, HTTP, storage, routing and event handling without coupling feature code to one specific tool.',
      fr: 'Un écosystème Flutter centré sur des outils faiblement couplés, des abstractions partagées et des service providers. Flueco permet à une application de choisir ses implémentations pour l’injection de dépendances, HTTP, le stockage, le routing ou les événements sans coupler le code métier à un outil spécifique.',
    ),
    principles: <String>[
      'Loose coupling',
      'Service providers',
      'Pluggable implementations',
      'Developer tooling',
    ],
  ),
);
