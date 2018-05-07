# language: ru

Функционал: Формирование параметров через конструктор 
    Как разработчик
    Я хочу иметь инструмент описания параметров своего проекта для чтения из файлов
    Чтобы предоставить возможность пользователям моего проекта задавать свои параметры в формате конструктора

Контекст: Тестовый контекст
    Когда Я создаю временный каталог и сохраняю его в контекст
    И Я сохраняю значение временного каталога в переменной "КаталогПроекта"
    И Я устанавливаю рабочей каталог во временный каталог
    И Я создаю МенеджерПараметров и сохраняю его в контекст
    И Я устанавливаю АвтоНастройки с параметрами
    | .config |
    | ''     |
    | json   |
    И Я включаю отладку лога с именем "oscript.lib.configor.constructor"

Сценарий: Чтение файла параметров согласно конструктору параметров
    Допустим Я подключаю тестовый класс описания параметров
    И Я добавляю файл ".config.json" в каталог проекта с содержанием 
    """
    {
        "version": "1.0",
        "ПараметрСтрока": "ПростоСтрока",
        "ПараметрДата": "2017-01-01T00:00:00Z",
        "ПараметрЧисло": 10,
        "ПараметрМассив": [
            "Элемент1",
            "Элемент2",
            "Элемент3"
        ],
        "ПараметрСтруктура": {
            "Строка": "ПростоСтрока",
            "Дата": "2017-01-01T00:00:00Z",
            "Число": 10,
            "Массив": [
                "Элемент1",
                "Элемент2",
                "Элемент3"
            ],
            "Структура": {
                "Строка": "ЗначениеСтруктуры",
                "Строка2": "ЗначениеСтруктуры2"
            },
            "Соответствие": {
                "КлючВнутри1": "Значение1",
                "КлючВнутри2": "Значение2"
            }
        },
        "ПараметрСоответствие": {
            "Ключ1": "Значение1",
            "Ключ2": "Значение2"
        }
    }
    """
    Когда Я выполняю чтение параметров
    Тогда Значение параметра класса "version" равно "1.0"
    И Значение параметра класса "ПараметрСтрока" равно "ПростоСтрока"
    # И Значение параметра класса "ПараметрДата" равно "2017-01-01T00:00:00Z"
    # И Значение параметра класса "ПараметрЧисло" равно "10"
    И Значение параметра класса "ПараметрСоответствие.Ключ1" равно "Значение1"
    И Значение параметра класса "ПараметрСоответствие.Ключ2" равно "Значение2"

Сценарий: Конструктор полей строка, число, дата, булево
    Допустим Я добавляю поле "ПараметрСтрока string" с типом "Строка" и значением "" для параметров "МенеджерПараметров"
    И Я добавляю поле "ПараметрЧисло number" с типом "Число" и значением "" для параметров "МенеджерПараметров"
    И Я добавляю поле "ПараметрДата datetime" с типом "Дата" и значением "" для параметров "МенеджерПараметров"
    И Я добавляю поле "ПараметрБулево boolean" с типом "Булево" и значением "" для параметров "МенеджерПараметров"
    И Я добавляю файл ".config.json" в каталог проекта с содержанием 
    """
    {
        "ПараметрСтрока": "ПростоСтрока",
        "datetime": "2017-01-01T00:00:00Z",
        "number": 10,
        "ПараметрБулево": "Да"
    }
    """
    Когда Я выполняю чтение параметров
    Тогда Дата параметра конструктора "ПараметрДата" равна "20170101"
    И Строка параметра конструктора "ПараметрСтрока" равна "ПростоСтрока"
    И Число параметра конструктора "ПараметрЧисло" равна "10"
    И Булево параметров конструктора "ПараметрБулево" равна "Да"

Сценарий: Конструктор вложенных параметров с полями 
    Допустим Я создаю новые параметры с именем "Глобальные globals" и сохраняю в "Глобальные"
    И Я добавляю поле "Глобальные globals" из объекта "Глобальные" для параметров "МенеджерПараметров"
    И Я добавляю поле "ПараметрСтрока string" с типом "Строка" и значением "Зелёная" для параметров "Глобальные"
    И Я добавляю поле "ПараметрЧисло number" с типом "Число" и значением "9" для параметров "Глобальные"
    И Я добавляю поле "ПараметрДата datetime" с типом "Дата" и значением "" для параметров "Глобальные"
    И Я добавляю поле "ПараметрБулево boolean" с типом "Булево" и значением "" для параметров "Глобальные"
    # И Я добавляю поле "Массив" массив с типом "Строка" для параметров "Глобальные"
    # И Я добавляю поле "МассивОбъектов" массив из объектов "Строка" для параметров "Глобальные"
    И Я добавляю файл ".config.json" в каталог проекта с содержанием 
    """
    {
        "globals":
        {
            "string": "Красная",
            "datetime": "2017-01-01T00:00:00Z",
            //"number": 5,
            "boolean": true
        }
    }
    """
    Когда Я выполняю чтение параметров
    Тогда Дата параметра конструктора "ПараметрДата" равна "20170101"
    И Строка параметра конструктора "Глобальные.ПараметрСтрока" равна "ПростоСтрока"
    И Число параметра конструктора "Глобальные.ПараметрЧисло" равна "10"
    И Булево параметров конструктора "Глобальные.ПараметрБулево" равна "Да"
