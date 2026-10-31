# Медицинские публикации

Каталог научных статей из PubMed на Flutter: список с поиском, карточка статьи и переход к связанным публикациям.
Одна кодовая база для веба, macOS, iOS и Android.

![Flutter](https://img.shields.io/badge/Flutter-3.47-02569B?logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.13-0175C2?logo=dart&logoColor=white)
![flutter_bloc](https://img.shields.io/badge/flutter__bloc-9.1-00A6E0)
![go_router](https://img.shields.io/badge/go__router-18.0-4CAF50)
![Platforms](https://img.shields.io/badge/platforms-web%20%7C%20macOS%20%7C%20iOS%20%7C%20Android-lightgrey)

## Содержание

- [Возможности](#возможности)
- [Стек](#стек)
- [Быстрый старт](#быстрый-старт)
- [Архитектура](#архитектура)
- [Навигация](#навигация)
- [Тема и локализация](#тема-и-локализация)
- [Данные](#данные)
- [Проверка качества](#проверка-качества)
- [Сценарии ручной проверки](#сценарии-ручной-проверки)
- [Работа с репозиторием](#работа-с-репозиторием)
- [Источники и лицензии](#источники-и-лицензии)

## Возможности

- **Каталог из 20 статей** PubMed: тип публикации, название, первый автор.
- **Поиск на лету** по названию, описанию и авторам. Пустой результат показывает отдельный экран.
- **Карточка статьи**: тип, дата выхода, PMID, описание, полный список авторов, связанные статьи.
- **Связанные статьи** открываются поверх текущей, «назад» возвращает по одному экрану.
- **Адрес в браузере** отражает открытую статью: `/#/article/22745249`. Ссылку можно скопировать и открыть.
- **Светлая и тёмная тема**, переключаются кнопкой в шапке.
- **Русский и английский интерфейс**, переключаются кнопкой в шапке. Данные статей не переводятся.
- **Адаптивная вёрстка**: в широком окне контент ограничен по ширине, в узком строки переносятся.
- **Работает без сети**: данные и шрифт лежат в приложении.

## Стек

| Задача | Решение |
|---|---|
| UI | Flutter 3.47, Material 3 |
| Язык | Dart 3.13: `sealed`- и `final`-классы, `switch` по шаблонам |
| Состояние | [flutter_bloc](https://pub.dev/packages/flutter_bloc) 9: Cubit для списка, Bloc для статьи |
| Навигация | [go_router](https://pub.dev/packages/go_router) 18 |
| Локализация | `flutter_localizations`, `gen_l10n`, ARB-файлы |
| Тема | `ColorScheme.fromSeed`, шрифт Nunito |

## Быстрый старт

### Требования

| Платформа | Что нужно |
|---|---|
| Все | Flutter SDK 3.47 и новее (`flutter doctor` без ошибок для нужной платформы) |
| Web | Google Chrome или Microsoft Edge |
| macOS, iOS | Xcode, для iOS ещё симулятор (Xcode → Settings → Components) |
| Android | Android Studio, Android SDK, Command-line Tools, эмулятор или телефон |

### Запуск

```bash
git clone https://github.com/CancelTell/medicine-publications-flutter.git
cd medicine-publications-flutter
flutter pub get        
```

| Платформа | Команда |
|---|---|
| Web | `flutter run -d chrome` |
| macOS | `flutter run -d macos` |
| iOS | `open -a Simulator`, затем `flutter run -d <id симулятора>` |
| Android | `flutter emulators --launch <имя>`, затем `flutter run -d <id эмулятора>` |

Список доступных устройств и их id: `flutter devices`.

В запущенном приложении: `r` применяет изменения кода без потери состояния (hot reload), `R` перезапускает с нуля, `q` выходит.

> Код локализации (`lib/l10n/app_localizations*.dart`) генерируется и не хранится в git.
> Ошибка `Target of URI doesn't exist: 'l10n/app_localizations.dart'` в свежем клоне лечится командой `flutter pub get`.

## Архитектура

Код разбит по фичам. Внутри фичи три слоя, и зависимости направлены только внутрь, к `domain`:
- **domain** описывает, что такое статья и откуда её можно получить. Здесь нет Flutter и нет деталей источника данных.
- **data** реализует интерфейс репозитория. Сейчас на моках, в ЛР3 на сети. Остальные слои этой замены не заметят.
- **presentation** показывает доменную модель как есть. Форматирование для экрана (авторы, PMID, цвет и подпись типа) вынесено в расширения в `utils/`.

### Структура

```text
lib/
├── main.dart                       точка входа
├── app.dart                        корень: провайдеры, тема, язык, роутер
├── common/
│   ├── localization/locale_cubit.dart
│   ├── navigation/app_router.dart  AppRoutes и AppRouter
│   ├── theme/                      AppColors, AppTheme, ThemeCubit
│   └── widgets/                    AppScaffold, кнопки темы и языка
├── features/
│   └── article/
│       ├── data/                   ArticleRepository, mockArticles
│       ├── domain/                 ArticleModel, ArticleType, IArticleRepository
│       └── presentation/
│           ├── bloc/list/          ArticleListCubit, ArticleListState
│           ├── bloc/detail/        ArticleDetailBloc, события и состояния
│           ├── utils/              расширения для показа модели
│           └── view/               экраны и widgets/
└── l10n/                           app_ru.arb, app_en.arb
```

### Состояние

Всё, что видно на экране, лежит в состоянии. Экран только рисует его и передаёт действия пользователя. Каждое состояние описано одним `sealed`-типом, поэтому `switch` в экране обязан разобрать все варианты, иначе код не скомпилируется.

| Экран | Логика | Входы | Состояния |
|---|---|---|---|
| Список | `ArticleListCubit` | `load()`, `search(query)` | `ArticleListLoading`, `ArticleListLoaded`, `ArticleListNotFound` |
| Статья | `ArticleDetailBloc` | событие `ArticleDetailOpened(pmid)` | `ArticleDetailLoading`, `ArticleDetailLoaded`, `ArticleDetailNotFound` |

- **Cubit списка** создаётся в корне приложения и живёт всё время работы. Поэтому после возврата со статьи на месте остаются запрос, результат и позиция прокрутки.
- **Bloc статьи** создаёт сам экран статьи. У каждой открытой статьи свой Bloc, он закрывается вместе с экраном.
- **Устаревшие ответы отбрасываются**: если пользователь напечатал новую букву, пока шёл поиск, старый результат не покажется.
- Ни Cubit, ни Bloc не знают о `BuildContext` и навигации.

### Зависимости

Все зависимости собираются в `app.dart`:

```dart
MultiRepositoryProvider(
  providers: [
    RepositoryProvider<IArticleRepository>(create: (_) => const ArticleRepository()),
  ],
  child: MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => ArticleListCubit(context.read<IArticleRepository>())..load()),
      BlocProvider(create: (_) => ThemeCubit()),
      BlocProvider(create: (_) => LocaleCubit()),
    ],
    child: ...,
  ),
);
```

Репозиторий регистрируется по интерфейсу. Только `app.dart` знает, какая реализация за ним стоит.

## Навигация

| Адрес | Экран |
|---|---|
| `/` | Список статей |
| `/article/:id` | Статья с PMID `id`, вложена в `/` |
| `/article/abc`, неизвестный адрес | «Такой страницы нет» |
| `/article/1` (нет в каталоге) | «Статьи с PMID 1 в каталоге нет» |

- Статья вложена в маршрут списка: при открытии по прямой ссылке под ней всё равно лежит список, и кнопка «назад» работает.
- Переход делает виджет через `context.push(AppRoutes.detail(pmid))`. Связанная статья тоже открывается через `push`, поэтому «назад» возвращает к предыдущей статье, а не сразу в список.
- В адресе передаётся только идентификатор. Модель через `extra` не передаётся.

## Тема и локализация

**Тема.** Палитра строится из одного опорного цвета через `ColorScheme.fromSeed`, отдельно для светлой и тёмной темы. Все цвета берутся из `colorScheme` или `AppColors`, в виджетах их нет. Цвета типов публикаций в обеих темах одинаковые: это часть данных, а не оформления.

| Тип | Подпись | Значок |
|---|---|---|
| `research` | Исследование | `science` |
| `review` | Обзор | `library_books` |
| `randTrial` | Рандомизированное исследование | `groups` |
| `validStudy` | Валидационное исследование | `verified` |

**Локализация.** Подписи интерфейса лежат в `lib/l10n/app_ru.arb` (шаблон) и `app_en.arb`, код к ним генерирует `gen_l10n`. Даты форматируются по языку: «декабрь 2023 г.» и «December 2023». Множественное число учитывает правила языка: «1 статья», «3 статьи», «20 статей».

Данные каталога (названия, авторы, описания) не переводятся: так они выглядят в PubMed.

## Данные

`lib/features/article/data/mock_articles.dart` содержит 20 настоящих статей из PubMed: COVID-19, GLP-1-агонисты, CRISPR, ИИ в медицине.

| Поле | Тип | Смысл |
|---|---|---|
| `pmid` | `int` | Идентификатор PubMed |
| `title` | `String` | Название |
| `authors` | `List<String>` | Авторы в формате PubMed |
| `description` | `String` | Краткое описание |
| `type` | `ArticleType` | Тип публикации |
| `publishedAt` | `DateTime` | Дата выхода |
| `relatedIds` | `List<int>` | PMID связанных статей (только из этого каталога) |


## Проверка качества

```bash
flutter analyze                    # статический анализ: 0 замечаний
dart run tool/check_arb.dart       # ключи и параметры в ru и en совпадают
dart format --output=none --set-exit-if-changed lib   # код отформатирован
```

## Сценарии ручной проверки

| # | Действие | Ожидаемый результат |
|---|---|---|
| 1 | Открыть приложение | 20 карточек: значок и тип, название, первый автор |
| 2 | Прокрутить, открыть статью, вернуться | Список на той же позиции |
| 3 | Открыть `/#/article/22745249`, в «Связанных» открыть Cong 2013, дважды «назад» | список, адрес меняется на каждом шаге |
| 4 | Переключить тему | Темнеют фон, шапка, карточки, поле поиска; текст читается |
| 5 | Переключить язык | Подписи и формат даты меняются, данные статей нет |
| 6 | Найти `semaglutide`, открыть статью, вернуться | Запрос и 3 найденные статьи на месте |
| 7 | Найти `zzz` | «По запросу «zzz» ничего не найдено» |
| 8 | Запустить на macOS, iOS или Android | Всё работает так же |


## Источники и лицензии

- Метаданные статей: [PubMed](https://pubmed.ncbi.nlm.nih.gov/), National Library of Medicine.
- Шрифт [Nunito](https://fonts.google.com/specimen/Nunito): SIL Open Font License 1.1.
- Значки: [Material Icons](https://fonts.google.com/icons), Apache License 2.0.
