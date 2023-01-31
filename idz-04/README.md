# ИДЗ-4. Построение многопоточных приложений.

## Вариант 19.

# Условие задачи

Задача о магазине - 2 (забывчивые покупатели). В магазине работают два отдела, каждый отдел обладает уникальным ассортиментом. В каждом отделе работает один продавец. В магазин ходят исключительно забывчивые покупатели, поэтому каждый покупатель носит с собой список товаров, которые желает купить. Покупатель приобретает товары точно в том порядке, в каком они записаны в его списке. При этом товары в списке расположены в случайном порядке, что заставляет покупателя переходить от отдела к отделу, если это требуется для совершения покупок. Продавец может обслужить только одного покупателя за раз. Покупатель, вставший в очередь, засыпает пока не дойдет до продавца. Продавец засыпает, если в его отделе нет покупателей, и просыпается, если появится хотя бы один. Создать многопоточное приложение,моделирующее работу магазина в течение рабочего дня.

# Оглавление

### Введение

- [О программе](#О-программе)
  - [Входные данные](#Входные-данные)
  - [Аргументы запуска](#Аргументы-запуска)
- [Представленные файлы](#Представленные-файлы)

### Отчет

- [Mark 4](#Mark-4)
- [Mark 5](#Mark-5)
- [Mark 6](#Mark-6)
- [Mark 7](#Mark-7)
- [Mark 8](#Mark-8)

### Прочее

- [Checklist](#Checklist)

# Введение

## О программе

*Проект имеет стандартную для C++ структуру, так что для компиляции можете использовать любой удобный для вас инструмент :)*

Программа изначально разрабатывалась с учетом всех требований включительно **до оценки 8**.
С самого начала присутствует работа с файлами, генерация случайных данных и прочий необходимый функционал.

## Входные данные

При вводе значений, программа подразумевает, что пользователь вводит данные в корректном формате. В программе заложена обработка критических ситуаций (к примеру, отсутствие пути к файлу, при наличии аргумента `--input_file`), однако, пожалуйста, вводите адекватные значение

*АВС это не КПО, не вижу смысла тратить преимущественную часть времени разработки программы на проработку всех возможных вариантов ввода. Все же цель работы - показать навыки работы с многопоточностью*

### Формат данных
- `b` - товар из хлебного отдела
- `m` - товар из молочного отдела

#### Формат файла / --data
`[кол-во покупателей][набор товаров разделенные ';']`
Пример: `2mmm;bbb;`
Сгенерируется два Покупателя. Первому надо купить 3 товара из молочного отдела, втором 3 товар из хлебного отдела.

Пример: `1bm;`
Один покупатель, которому надо купить хлеб и молоко

#### Консольный ввод
При запросе на ввод покупателей от программы, следует ввести значения вида `[набор товаров разделенные ';']` n раз.

## Аргументы запуска

|Аргумент|Описание|Пример|
|---|---|---|
|**Ввод**|*Допустимо одновременное использование только одного из аргументов*|
|`--input_file <входной файл>`|Получение данных для создания Покупателей из файла||
|`--random <кол-во покупателей>`|Запуск программы в режиме генерацией случайных данных||
|`--data <кол-во-покупателей_данные>`|Получение данных для создания Покупателей из аргумента|`./a.out --data 2mbmbmbm;mmmmm;`|
|**Вывод**||
|`--output_file <выходной файл>`|Дублирование выхода программы в файл|

## Представленные файлы

```
| /cpp-source - исходный код программы на языке C++
| /results - Результаты прогонов на разных наборах данных
```

# Mark 4
## Модель параллельных вычислений
Данная задача является моделью вычислений "Клиент-Сервер".

(Это модель, когда клиентский поток запрашивает сервер и ждет ответа. Серверный поток ожидает запроса от клиента, затем действует в соответствии с поступившим запросом)

Наблюдается схожесть с определением: в нашем случае, когда Покупатель обращается к Консультанту, он точно так же ожидает от него ответа. 

## Результаты выполнения программы
Ознакомиться с результатами работы программы можно в папке (/results)[/results].

# Mark 5
## Сценарий поведения представленных в условии задания сущностей

### Customer
Каждый покупатель носит с собой список товаров, которые он желает купить.
Придя в магазин, он смотрит первый невычеркнутый товар и определяет отдел в который следует обратиться. Покупатель, встает в очередь, ждет пока она не закончится, и затем обращается к продавцу, производит покупку. После этого, покупатель покидает отдел и повторяет процесс снова пока не останется не купленных товаров.

### Consultant
Продавец ждет пока кто-нибудь не встанет в очередь. Как только приходит покупатель, он помогает ему совершить покупку. После этого он засыпает и процесс повторяется снова до закрытия магазина.
Важно: Продавец может обслуживать только одного покупателя за раз.   
 
### Department
Абстракция 

# Mark 6

Реализован класс `Store` который содержит внутри себя 2 отдела (`Department`) - молочный и хлебный.
Внутри каждого отдела заключен объект консультанта - `Consultant`.
`Customer`- это покупатель, который последовательно читая список товаров, обращается в нужный отдел.

Ознакомится с тем, как отображается каждый из субъектов предметной области на программу, советую обратится к [коду](/cpp-source). Там довольно много кода с комментариями, и вставлять все это сюда как-то не хочется :) 

# Mark 7
Дополнительных изменений не потребовалось.
Ознакомиться с результатами работы программы в файловом режиме можно ознакомиться в папке (/results)[/results].

# Mark 8
Дополнительных изменений не потребовалось.
Ознакомиться с результатами работы программы в режиме генерации случайных данных можно ознакомиться в папке (/results)[/results].

# Checklist

### 4 балла
- [x] Приведено условие задачи.
- [x] Описана модель параллельных вычислений, используемая при разработке многопоточной программы.
- [x] Описаны входные данные программы, включающие вариативные
диапазоны, возможные при многократных запусках.
- [x] Реализовано консольное приложение, решающее поставленную задачу с использованием одного варианта синхропримитивов.
- [x] Ввод данных в приложение реализован с консоли.
- [x] Результаты работы приведены в отчете.

### 5 баллов
В дополнение к требованиям на предыдущую оценку
- [x] В программу добавлены комментарии, поясняющие выполняемые
действия и описание используемых переменных.
- [x] В отчете должен быть приведен сценарий, описывающий одновременное поведение представленных в условии задания сущностей в терминах предметной области. То есть, описано поведение объектов
разрабатываемой программы как взаимодействующих субъектов, а не то, как это будет реализовано в программе.

### 6 баллов
В дополнение к требованиям на предыдущую оценку
- [x] В отчете подробно описан обобщенный алгоритм, используемый
при реализации программы исходного словесного сценария. В котором показано, как на программу отображается каждый из субъектов предметной области.
- [x] Реализован ввод данных из командной строки.
- [x] Результаты изменений отражены в отчете.

### 7 баллов
В дополнение к требованиям на предыдущую оценку
- [x] В программу добавлены ввод данных из файла и вывод результатов
в файл.
- [x] Приведены входные и выходные файлы с различными результатами выполнения программы.
- [x] Результаты работы программы должны выводиться на экран и записываться в файл.
- [x] Ввод данных из командной строки расширен с учетом введенных
изменений.
- [x] Результаты изменений отражены в отчете.

### 8 баллов
В дополнение к требованиям на предыдущую оценку
- [x] В программу добавлена генерация случайных данных в допустимых диапазонах.
- [x] Приведены входные и выходные файлы с различными результатами выполнения программы.
- [x] Ввод данных из командной строки расширен с учетом введенных
изменений.
- [x] Результаты изменений отражены в отчете.