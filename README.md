# Description

Test task.

[origin](https://github.com/galetahub/hire-ruby-developer#task-3)


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
### ENV variables(they are must for dev/prod env):
#### smtp
  checked with gmail

  password from app access([https://www.lifewire.com/get-a-password-to-access-gmail-by-pop-imap-2-1171882](https://www.lifewire.com/get-a-password-to-access-gmail-by-pop-imap-2-1171882))

  - SMTP_U - email for smtp(it will send and receive letter from contact form)
  - SMTP_P - password for smtp

#### captcha
  - CAPTCHA_SITE_KEY - for google captcha v3
  - CAPTCHA_SECRET_KEY - for google captcha v3

### run command
```
SMTP_U='xxx' SMTP_P='xxx' CAPTCHA_SITE_KEY='xxx' CAPTCHA_SECRET_KEY='xxx' rackup
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
