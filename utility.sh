#!/bin/bash

#Полховский Н.В.

# Функция вывода справки
help() {
  echo "Справка по утилите:"
  echo " -u, --users: Вывести список пользователей и их домашних директорий."
  echo " -p, --processes: Вывести список запущенных процессов."
  echo " -h -h, --help: Вывести справку."
  echo " -l PATH, --log PATH: Записать вывод в файл по указанному пути."
  echo " -e PATH, --errors PATH: Записать ошибки в файл по указанному пути."
}

# Функция вывода списка пользователей
users() {
  # Вывод списка пользователей без awk
  getent passwd | while IFS=: read -r user passwd uid gid gcos home shell; do
    echo "$user:$home"
  done | sort
}

# Функция вывода списка процессов
processes() {
  # Вывод списка процессов
  ps aux | sort -k 2
}

# Основная функция
main() {
  local log_file=""
  local error_file=""

  

  # Обработка аргументов командной строки с помощью getopts
  while getopts ":uph:l:e:" opt; do
    case $opt in
      u)
        # Перенаправление вывода в файл перед вызовом функции
        if [[ -n "$log_file" ]]; then
          exec >"$log_file"
        fi
        users
        ;;
      p)
        # Перенаправление вывода в файл перед вызовом функции
        if [[ -n "$log_file" ]]; then
          exec >"$log_file"
        fi
        processes
        ;;
      h)
        help
        return 0
        ;;
      l)
        log_file="$OPTARG"
        ;;
      e)
        error_file="$OPTARG"
        ;;
      \?)
        echo "Неверный аргумент: -$OPTARG" >&2
        return 1
        ;;
      :)
        echo "Отсутствует аргумент для: -$OPTARG" >&2
        return 1
        ;;
    esac
  done

  # Перенаправление stderr в файл
  if [[ -n "$error_file" ]]; then
    # Проверка доступности пути к файлу
    if [[ ! -w "$error_file" ]]; then
      echo "Ошибка: Отсутствует доступ к файлу: $error_file" >&2
      return 1
    fi
    exec 2>"$error_file"
  fi

  trap "echo 'Исскуственная ошибка!' >&2" DEBUG

  # Если не заданы аргументы, вывести справку
  if [[ $# -eq 0 ]]; then
    help
  fi

}

# Запуск основной функции
main "$@"
