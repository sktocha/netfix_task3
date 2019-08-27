# Description

Test task.
Форма зворотнього зв'язку на сайті.

Поля:

-   name (не менше 3 символів, та не більше 250)
-   email (мінімальна перевірка на валідність)
-   message (не менше 50 символів)
-   файл (формат будь-який)
-   reCAPTCHA  [https://www.google.com/recaptcha/intro/v3.html](https://www.google.com/recaptcha/intro/v3.html)

Після успішної валідації всі звернення шлемо на пошту. Файл має бути прикріплений до листа
#### Requirements

Для виконання тестового завдання обов'язково слід використовувати:

-   Ruby, bundle, sinatra, javascript
-   Покрити код тестами (бажано rspec)
-   Розмістити проект на своєму github профілі
-   OOP paradigm

Що не слід використовувати:

-   Rails
-   СУБД
-   react (angular, vue, ...)

Додатковим плюсом буде:

-   params validation
-   heroku
-   bootstrap or foundation
-   rubocop
-   reek

## Installing

```
bundle
```
## Run
SMTP_U - email for smtp
SMTP_P - password for smtp
```
SMTP_U='*' SMTP_P='*' rackup
```
## Running the tests
```
bin/rspec
```
## Running the rubcocop
```
bin/rubocop
```

## License

This project is licensed under the MIT License
