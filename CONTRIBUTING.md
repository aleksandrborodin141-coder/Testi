# Вклад в TasteWay

Спасибо за интерес к участию в проекте TasteWay! Здесь описано как правильно внести вклад.

## 📋 Перед началом

1. Сделай Fork репозитория
2. Клонируй свой fork: `git clone https://github.com/YOUR_USERNAME/tasteway_flutter.git`
3. Добавь upstream: `git remote add upstream https://github.com/ORIGINAL_OWNER/tasteway_flutter.git`
4. Создай feature ветку: `git checkout -b feature/your-feature-name`

## 🔧 Локальная разработка

### Требования
- Flutter 3.24.0+
- Dart 3.0.0+
- Android Studio или VS Code с Flutter плагином
- Android SDK 21+

### Установка зависимостей
\`\`\`bash
flutter pub get
flutter pub run build_runner build
\`\`\`

### Запуск тестов
\`\`\`bash
flutter test
\`\`\`

### Анализ кода
\`\`\`bash
flutter analyze
\`\`\`

## 📝 Правила кода

- Следуй [Dart Style Guide](https://dart.dev/guides/language/effective-dart/style)
- Используй `const` конструкторы где возможно
- Документируй public методы и классы
- Пиши тесты для новых функций

## 🐛 Отправка ошибок

При отправке issue, пожалуйста включи:
- Версию Flutter и Dart
- Операционную систему и версию
- Полный stack trace если есть
- Шаги для воспроизведения

## 🎯 Отправка Pull Request

1. Убедись что код собирается: `flutter build apk`
2. Запусти тесты: `flutter test`
3. Запусти анализатор: `flutter analyze`
4. Push на твою ветку: `git push origin feature/your-feature-name`
5. Открой PR в main репозитории

### PR Description Template
\`\`\`markdown
## Описание
Краткое описание изменений.

## Тип изменения
- [ ] Баг-фикс
- [ ] Новая фича
- [ ] Breaking change
- [ ] Документация

## Как тестировать
Шаги для тестирования изменений.

## Чек-лист
- [ ] Код собирается без ошибок
- [ ] Все тесты проходят
- [ ] Добавлены новые тесты
- [ ] Документация обновлена
- [ ] Нет новых warning при анализе
\`\`\`

## 📚 Структура проекта

\`\`\`
lib/
├── core/
│   ├── constants/     # API ключи, URL, конфиги
│   └── theme/         # Темы, стили, палитра цветов
├── data/
│   ├── datasources/   # API клиенты, локальное хранилище
│   ├── models/        # Data-модели с сериализацией
│   └── repositories/  # Реализация интерфейсов репозиториев
├── domain/
│   ├── entities/      # Бизнес-сущности
│   └── repositories/  # Интерфейсы репозиториев
├── presentation/
│   ├── bloc/          # BLoC классы
│   ├── screens/       # Экраны приложения
│   ├── widgets/       # Переиспользуемые виджеты
│   └── routes/        # Навигация
└── services/          # Вспомогательные сервисы
\`\`\`

## ❓ Вопросы?

Откройте Discussion или напишите нам в Telegram: @tasteway_support

---

Спасибо за вклад в TasteWay! 🎉
