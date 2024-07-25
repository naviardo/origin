#!/bin/bash
clear

p=~/bash # путь к целевому каталогу
cd "${p}" # сделать указанный каталог текущим

# прочесть содержимое текущего каталога - файлы и подкаталоги (но не включая . - родительский каталог),
# отсортировать по убыванию размера файла/каталога и отрезать первую часть строк (где размер файла/каталога)
files=$(find -mindepth 1 -maxdepth 1 -printf '%s %f\n' | sort -nr | cut -d' ' -f2-)

IFS=$'\n' # временной определить внутренний разделитель полей как новая строка
# прочесть все строки в массив array
while read -r line; do
    array+=("$line") 
done <<< "$files"
unset IFS # вернуть дефолтное значение

len=${#array[@]}
chunk_size=7 # количество выводимых строк за один раз
start=0 counter=1 # задаем стартовый индекс в массиве и счетчик файлов/подкаталогов
while : # бесконечный цикл while
do
    chunk=("${array[@]:$start:$chunk_size}") # берем первую партию имен - делаем срез массива
    for fname in "${chunk[@]}" ; do # перебираем первую партию имен
        if [[ -d $fname ]]; then # определяем тип
            type="каталог"
