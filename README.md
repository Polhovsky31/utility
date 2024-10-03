# utility
## Утилита системной информации

Описание:

Данный скрипт представляет собой утилиту командной строки, которая предоставляет информацию о системе. Она позволяет вывести список пользователей, список запущенных процессов, а также записывать результаты выполнения и ошибки в файлы.

Использование:

./utility.sh [опции]


Доступные опции:

 -u, --users: Выводит список пользователей и их домашних директорий.
 -p, --processes: Выводит список запущенных процессов.
 -h -h, --help: Выводит справку по утилите.
 -l PATH, --log PATH: Записывает вывод в файл по указанному пути.
 -e PATH, --errors PATH: Записывает ошибки в файл по указанному пути.

Примеры использования:

 Вывести список пользователей в файл: ./utility.sh -u -l /home/users.txt
 Вывести список процессов и записать ошибки в файл: ./utility.sh -p -e /home/errors.log

Замечания:

 Скрипт использует команду getent passwd для получения информации о пользователях и ps aux для получения информации о процессах.
 Скрипт использует getopts для обработки аргументов командной строки.
 Скрипт использует trap для записи искусственной ошибки в файл, заданный параметром -e.

Автор:

Полховский Н.В.
