import 'package:flueco/flueco.dart' show FluecoSR;
import 'package:flueco_state_management/flueco_state_management.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../domain/entities/article.dart';
import '../../../../../domain/entities/education.dart';
import '../../../../../domain/entities/experience.dart';
import '../../../../../domain/entities/portfolio.dart';
import '../../../../../domain/entities/repository.dart';
import '../../../../../domain/use_cases/get_developer_feed_use_case.dart';
import '../../../../../domain/use_cases/get_portfolio_use_case.dart';
import '../../../components/editorial_rule.dart';
import '../../../components/section_heading.dart';
import '../../../theming/editorial_theme.dart';
import 'home.viewmodel.dart';
import 'home.viewstate.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) => const _HomeProvider(child: _HomeBody());
}

class _HomeProvider extends StatelessWidget {
  final Widget child;
  const _HomeProvider({required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>(
      create: (_) {
        final HomeViewModel vm = HomeViewModel(
          getPortfolio: FluecoSR.of(context).resolve<GetPortfolioUseCase>(),
          getFeed: FluecoSR.of(context).resolve<GetDeveloperFeedUseCase>(),
        );
        vm.initialize();
        return vm;
      },
      builder: (_, __) => child,
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final HomeViewModel vm = ViewModel.watch<HomeViewModel>(context);
    final HomeViewState state = vm.state;
    final Portfolio? p = state.portfolio;
    if (p == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Theme(
      data: state.darkMode ? EditorialTheme.dark() : EditorialTheme.light(),
      child: Builder(
        builder: (BuildContext context) => Scaffold(
          body: SelectionArea(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1240),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: <Widget>[
                        _Masthead(state: state, vm: vm),
                        _Hero(p: p, state: state),
                        _Profile(p: p, state: state),
                        _Experience(p: p, state: state),
                        _Flueco(p: p, state: state),
                        _Feeds(p: p, state: state),
                        _Credentials(p: p, state: state),
                        _Footer(p: p, state: state),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Masthead extends StatelessWidget {
  final HomeViewState state;
  final HomeViewModel vm;
  const _Masthead({required this.state, required this.vm});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(top: 18, bottom: 28),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(child: Text('LYON · FRANCE', style: Theme.of(context).textTheme.labelMedium)),
                TextButton(onPressed: vm.toggleLanguage, child: Text(state.languageCode == 'en' ? 'FR' : 'EN')),
                IconButton(
                  onPressed: vm.toggleTheme,
                  tooltip: state.languageCode == 'fr' ? 'Changer le thème' : 'Toggle theme',
                  icon: Icon(state.darkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
                ),
              ],
            ),
            const EditorialRule(),
            const SizedBox(height: 18),
            Text('THE SOFTWARE ENGINEER', textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 18, letterSpacing: 4)),
            const SizedBox(height: 8),
            Text('OPEN SOURCE · MOBILE · WEB · ARCHITECTURE', textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 18),
            const EditorialRule(double: true),
          ],
        ),
      );
}

class _Hero extends StatelessWidget {
  final Portfolio p;
  final HomeViewState state;
  const _Hero({required this.p, required this.state});

  @override
  Widget build(BuildContext context) {
    final Widget copy = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(p.name, style: Theme.of(context).textTheme.displayLarge),
        const SizedBox(height: 14),
        Text(p.headline.toUpperCase(), style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 15)),
        const SizedBox(height: 22),
        Text(p.introduction.resolve(state.languageCode), style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 24),
        Wrap(
          spacing: 20,
          runSpacing: 8,
          children: <Widget>[
            _Link('LinkedIn', p.linkedinUrl),
            _Link('GitHub', p.githubUrl),
            _Link('Medium', p.mediumUrl),
            _Link('Stack Overflow', p.stackOverflowUrl),
          ],
        ),
      ],
    );
    final Widget portrait = Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all(color: Theme.of(context).dividerColor)),
      child: ClipRect(
        child: ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            .33,.33,.33,0,0,.33,.33,.33,0,0,.33,.33,.33,0,0,0,0,0,1,0,
          ]),
          child: Image.asset('assets/images/maxime_fankam.jpeg', fit: BoxFit.cover),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 70),
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints c) {
        if (c.maxWidth < 820) {
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[copy, const SizedBox(height: 34), portrait]);
        }
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Expanded(flex: 6, child: copy),
          const SizedBox(width: 52),
          Expanded(flex: 4, child: portrait),
        ]);
      }),
    );
  }
}

class _Profile extends StatelessWidget {
  final Portfolio p;
  final HomeViewState state;
  const _Profile({required this.p, required this.state});

  @override
  Widget build(BuildContext context) {
    final bool fr = state.languageCode == 'fr';
    return _Section(
      child: Column(
        children: <Widget>[
          SectionHeading(kicker: fr ? 'Le profil' : 'The profile', title: fr ? 'Du code au système.' : 'From code to systems.'),
          const SizedBox(height: 28),
          LayoutBuilder(builder: (BuildContext context, BoxConstraints c) {
            final Widget skills = _ListBlock(title: fr ? 'COMPÉTENCES' : 'SKILLS', values: p.skills);
            final Widget languages = _ListBlock(title: fr ? 'LANGUES' : 'LANGUAGES', values: p.languages);
            if (c.maxWidth < 720) return Column(children: <Widget>[skills, const SizedBox(height: 30), languages]);
            return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Expanded(child: skills), const SizedBox(width: 54), Expanded(child: languages)]);
          }),
        ],
      ),
    );
  }
}

class _Experience extends StatelessWidget {
  final Portfolio p;
  final HomeViewState state;
  const _Experience({required this.p, required this.state});

  @override
  Widget build(BuildContext context) {
    final bool fr = state.languageCode == 'fr';
    return _Section(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SectionHeading(kicker: fr ? 'Chronique professionnelle' : 'Career chronicle', title: fr ? 'Expérience' : 'Experience'),
          const SizedBox(height: 18),
          ...p.experiences.map((Experience e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                    SizedBox(width: 150, child: Text('${e.start}\n${e.end}', style: Theme.of(context).textTheme.labelMedium)),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Text(e.company, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 5),
                      Text(e.role.resolve(state.languageCode), style: Theme.of(context).textTheme.bodyLarge),
                      if (e.location != null) Text(e.location!.resolve(state.languageCode), style: Theme.of(context).textTheme.labelMedium),
                      if (e.summary != null) ...<Widget>[const SizedBox(height: 8), Text(e.summary!.resolve(state.languageCode))],
                    ])),
                  ]),
                  const SizedBox(height: 18),
                  const EditorialRule(),
                ]),
              )),
        ],
      ),
    );
  }
}

class _Flueco extends StatelessWidget {
  final Portfolio p;
  final HomeViewState state;
  const _Flueco({required this.p, required this.state});

  @override
  Widget build(BuildContext context) {
    final bool fr = state.languageCode == 'fr';
    final project = p.featuredProject;
    return _Section(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        SectionHeading(kicker: fr ? 'À la une · Open source' : 'Front page · Open source', title: project.name),
        const SizedBox(height: 28),
        LayoutBuilder(builder: (BuildContext context, BoxConstraints c) {
          final Widget story = Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(project.role.toUpperCase(), style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 16),
            Text(project.description.resolve(state.languageCode), style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 22),
            _Link(fr ? 'Voir le projet sur GitHub →' : 'Read the project on GitHub →', project.url),
          ]);
          final Widget principles = _ListBlock(title: fr ? 'PRINCIPES' : 'PRINCIPLES', values: project.principles);
          if (c.maxWidth < 720) return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[story, const SizedBox(height: 30), principles]);
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Expanded(flex: 2, child: story), const SizedBox(width: 54), Expanded(child: principles)]);
        }),
      ]),
    );
  }
}

class _Feeds extends StatelessWidget {
  final Portfolio p;
  final HomeViewState state;
  const _Feeds({required this.p, required this.state});

  @override
  Widget build(BuildContext context) {
    final bool fr = state.languageCode == 'fr';
    if (state.loading) {
      return const _Section(child: Center(child: Padding(padding: EdgeInsets.all(28), child: CircularProgressIndicator())));
    }
    return _Section(
      child: Column(children: <Widget>[
        SectionHeading(kicker: fr ? 'Le bureau du développeur' : 'The developer desk', title: fr ? 'Code & publications' : 'Code & writings'),
        const SizedBox(height: 28),
        LayoutBuilder(builder: (BuildContext context, BoxConstraints c) {
          final Widget repos = _FeedColumn(
            title: 'GITHUB',
            empty: fr ? 'Le flux GitHub est momentanément indisponible.' : 'GitHub feed is temporarily unavailable.',
            children: state.repositories.map((Repository r) => _FeedItem(
              title: r.name,
              body: r.description.isEmpty ? r.language : r.description,
              meta: '${r.language} · ★ ${r.stars} · Forks ${r.forks}',
              url: r.url,
            )).toList(),
          );
          final Widget articles = _FeedColumn(
            title: 'MEDIUM',
            empty: fr ? 'Le flux Medium est momentanément indisponible.' : 'Medium feed is temporarily unavailable.',
            children: state.articles.map((Article a) => _FeedItem(
              title: a.title,
              body: a.description,
              meta: a.publishedAt == null ? 'Medium' : '${a.publishedAt!.year}',
              url: a.url,
            )).toList(),
          );
          if (c.maxWidth < 800) return Column(children: <Widget>[repos, const SizedBox(height: 42), articles]);
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Expanded(child: repos), const SizedBox(width: 54), Expanded(child: articles)]);
        }),
      ]),
    );
  }
}

class _Credentials extends StatelessWidget {
  final Portfolio p;
  final HomeViewState state;
  const _Credentials({required this.p, required this.state});

  @override
  Widget build(BuildContext context) {
    final bool fr = state.languageCode == 'fr';
    return _Section(
      child: Column(children: <Widget>[
        SectionHeading(kicker: fr ? 'Archives' : 'The archives', title: fr ? 'Formation & distinction' : 'Education & distinction'),
        const SizedBox(height: 28),
        LayoutBuilder(builder: (BuildContext context, BoxConstraints c) {
          final Widget education = Column(crossAxisAlignment: CrossAxisAlignment.start, children: p.education.map((Education e) => Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Text(e.period, style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 4),
              Text(e.institution, style: Theme.of(context).textTheme.titleLarge),
              Text(e.program.resolve(state.languageCode)),
            ]),
          )).toList());
          final Widget award = Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Text(fr ? 'DISTINCTION' : 'HONOUR', style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 10),
            Text('Winner — HackAfrik', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            Text(fr ? 'Novembre 2014 · Application Android de santé réalisée pendant la compétition.' : 'November 2014 · Android health application built during the competition.'),
          ]);
          if (c.maxWidth < 720) return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[education, award]);
          return Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Expanded(flex: 2, child: education), const SizedBox(width: 54), Expanded(child: award)]);
        }),
      ]),
    );
  }
}

class _Footer extends StatelessWidget {
  final Portfolio p;
  final HomeViewState state;
  const _Footer({required this.p, required this.state});

  @override
  Widget build(BuildContext context) {
    final bool fr = state.languageCode == 'fr';
    return Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 44),
      child: Column(children: <Widget>[
        const EditorialRule(double: true),
        const SizedBox(height: 28),
        Text(fr ? 'POUR ÉCHANGER, RETROUVEZ-MOI SUR LINKEDIN.' : 'FOR CONVERSATIONS, FIND ME ON LINKEDIN.', textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 16),
        _Link('linkedin.com/in/mcssym', p.linkedinUrl),
        const SizedBox(height: 28),
        Text('© ${DateTime.now().year} ${p.name} · Built with Flutter & Flueco', style: Theme.of(context).textTheme.labelMedium),
      ]),
    );
  }
}

class _Section extends StatelessWidget {
  final Widget child;
  const _Section({required this.child});
  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.only(bottom: 72), child: child);
}

class _ListBlock extends StatelessWidget {
  final String title;
  final List<String> values;
  const _ListBlock({required this.title, required this.values});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
    Text(title, style: Theme.of(context).textTheme.labelLarge),
    const SizedBox(height: 12),
    ...values.map((String value) => Padding(padding: const EdgeInsets.only(bottom: 7), child: Text(value, style: Theme.of(context).textTheme.bodyMedium))),
  ]);
}

class _FeedColumn extends StatelessWidget {
  final String title;
  final String empty;
  final List<Widget> children;
  const _FeedColumn({required this.title, required this.empty, required this.children});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
    Text(title, style: Theme.of(context).textTheme.labelLarge),
    const SizedBox(height: 16),
    if (children.isEmpty) Text(empty) else ...children,
  ]);
}

class _FeedItem extends StatelessWidget {
  final String title;
  final String body;
  final String meta;
  final String url;
  const _FeedItem({required this.title, required this.body, required this.meta, required this.url});
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => _open(url),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Text(meta.toUpperCase(), style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 5),
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        if (body.isNotEmpty) ...<Widget>[const SizedBox(height: 7), Text(body, maxLines: 4, overflow: TextOverflow.ellipsis)],
        const SizedBox(height: 16),
        const EditorialRule(),
      ]),
    ),
  );
}

class _Link extends StatelessWidget {
  final String label;
  final String url;
  const _Link(this.label, this.url);
  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () => _open(url),
    child: Text(label, style: Theme.of(context).textTheme.labelLarge?.copyWith(decoration: TextDecoration.underline)),
  );
}

Future<void> _open(String url) async {
  final Uri uri = Uri.parse(url);
  await launchUrl(uri, webOnlyWindowName: '_blank');
}
