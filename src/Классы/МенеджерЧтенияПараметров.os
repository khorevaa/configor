#Использовать asserts
#Использовать logos
#Использовать tempfiles

Перем МассивПутейПоиска;
Перем ПутьКФайлуПараметров;
Перем ИмяФайлаПараметров;
Перем РасширениеФайлаПараметров;
Перем КлассЧтенияФайлаПараметров;
Перем ЧтениеФайлаПараметровВыполнено; // булево - флаг, что чтение выполнено

Перем ИндексПараметров; // Соответствие - плоский индекс всех параметров
Перем ПрочитанныеПараметры; // Соответствие - результат чтения из файла

Перем КлассПриемникПараметров; // Произвольный класс обеспечивающий: Функция Параметры() Экспорт, Процедура УстановитьПараметры(НовыеПараметры) Экспорт

Перем Лог;

Процедура ПриСозданииОбъекта()

	МассивПутейПоиска = Новый Массив;

	ДобавитьСтандартныеПутиПоиска();

	ИндексПараметров = Новый Соответствие;
	ПрочитанныеПараметры = Новый Структура;

	ЧтениеФайлаПараметровВыполнено = Ложь;

КонецПроцедуры

Процедура УстановитьФайлПараметров(Знач ПутьКФайлу) Экспорт

	ПутьКФайлуПараметров = ПутьКФайлу;
	ЧтениеФайлаПараметровВыполнено = Ложь;

КонецПроцедуры

Процедура ДобавитьКаталогПоиска(Знач ПутьПоискаФайлов) Экспорт

	МассивПутейПоиска.Добавить(ПутьПоискаФайлов);

КонецПроцедуры

//
Функция ИспользуемыйФайлПараметров() Экспорт
	Возврат ПолучитьПутьКФайлуПараметров();
КонецФункции

Процедура УстановитьИмяФайла(Знач ИмяФайла) Экспорт

	ИмяФайлаПараметров = ИмяФайла;
	ЧтениеФайлаПараметровВыполнено = Ложь;

КонецПроцедуры

Процедура УстановитьРасширениеФайла(Знач РасширениеФайла, Знач КлассЧтенияФайла = Неопределено) Экспорт

	РасширениеФайлаПараметров = РасширениеФайла;

	Если Не КлассЧтенияФайла = Неопределено Тогда

		КлассЧтенияФайлаПараметров = КлассЧтенияФайла;

	КонецЕсли;

КонецПроцедуры

Процедура УстановитьКлассПриемник(КлассПараметров) Экспорт

	КлассПриемникПараметров = КлассПараметров;

КонецПроцедуры

Функция Параметр(Знач ИмяПараметра, Знач ЗначениеПоУмолчанию = Неопределено) Экспорт

	ЗначениеИзИндекса = ИндексПараметров[ИмяПараметра];

	Если НЕ ЗначениеИзИндекса = Неопределено Тогда
		Возврат ЗначениеИзИндекса;
	КонецЕсли;

	Возврат ЗначениеПоУмолчанию;

КонецФункции

Функция ЧтениеВыполнено() Экспорт
	Возврат ЧтениеФайлаПараметровВыполнено;
КонецФункции

Процедура Прочитать() Экспорт

	НайтиИУстановитьФайлПараметров();

	Если НЕ ЗначениеЗаполнено(ПутьКФайлуПараметров) Тогда
		Возврат;
	КонецЕсли;

	ПрочитанныеПараметры = КлассЧтенияФайлаПараметров.Прочитать(ПутьКФайлуПараметров);

	Лог.Отладка("ПрочитанныеПараметры количество <%1>", ПрочитанныеПараметры.Количество());

	ОбновитьИндексПараметров();

	ЧтениеФайлаПараметровВыполнено = Истина;

	Если Не КлассПриемникПараметров = Неопределено Тогда
		ВыгрузитьПараметрыВКлассПриемник();
	КонецЕсли;

КонецПроцедуры

Процедура Записать() Экспорт
	
	ЗаписатьВФайл(ПутьКФайлуПараметров, РасширениеФайлаПараметров)

КонецПроцедуры

Процедура ЗаписатьВФайл(Знач ПутьКФайлуПараметров, Знач ФорматЗаписи = "json") Экспорт
	// Запись параметров
КонецПроцедуры

Процедура ОбновитьИндексПараметров()

	// Рекурсивный вызов для входящих параметров
	ДобавитьЗначениеПараметра("", ПрочитанныеПараметры);

КонецПроцедуры

Функция ЭтоМассив(Знач Значение)
	Возврат ТипЗнч(Значение) = Тип("Массив");
КонецФункции

Функция ЭтоСоответствие(Знач Значение)
	Возврат ТипЗнч(Значение) = Тип("Соответствие");
КонецФункции

Функция ЭтоСтруктура(Знач Значение)
	Возврат ТипЗнч(Значение) = Тип("Структура");
КонецФункции

Процедура ДобавитьПараметрВИндекс(Знач ИмяПараметра, Знач ЗначениеПараметра)

	// Вставляем все значение целиком
	// Для получения массивов и соответствий сразу
	Если Не ПустаяСтрока(ИмяПараметра) Тогда
		Лог.Отладка("Добавляю параметр <%1> со значением <%2> в индекс", ИмяПараметра, ЗначениеПараметра);
		ИндексПараметров.Вставить(ИмяПараметра, ЗначениеПараметра);
	КонецЕсли;

	// Рекурсивное заполнение значения параметра
	ДобавитьЗначениеПараметра(ИмяПараметра, ЗначениеПараметра);

КонецПроцедуры

Процедура ДобавитьЗначениеПараметра(Знач ИмяПараметра, Знач ЗначениеПараметра)

	Если ЭтоМассив(ЗначениеПараметра) Тогда
		ДобавитьПараметрМассивВИндекс(ЗначениеПараметра, ИмяПараметра);
	ИначеЕсли ЭтоСоответствие(ЗначениеПараметра) Тогда
		ДобавитьСоответствиеВИндекс(ЗначениеПараметра, ИмяПараметра);
	ИначеЕсли ЭтоСтруктура(ЗначениеПараметра) Тогда
		ДобавитьСоответствиеВИндекс(ЗначениеПараметра, ИмяПараметра);
	КонецЕсли;

КонецПроцедуры

Процедура ДобавитьПараметрМассивВИндекс(Знач МассивЗначений, Знач ИмяРодителя = "")

	Лог.Отладка("Обрабатываю массив значений <%1> ", ИмяРодителя);

	ШаблонИмениПараметра = "%1";

	Если Не ПустаяСтрока(ИмяРодителя) Тогда
		ШаблонИмениПараметра = ИмяРодителя + ".%1";
	КонецЕсли;

	Для ИндексЗначения = 0 По МассивЗначений.ВГраница() Цикл

		ИмяПараметра = СтрШаблон(ШаблонИмениПараметра, ИндексЗначения);
		ДобавитьПараметрВИндекс(ИмяПараметра, МассивЗначений[ИндексЗначения]);

	КонецЦикла;

КонецПроцедуры

Процедура ДобавитьСоответствиеВИндекс(Знач ВходящиеПараметры, Знач ИмяРодителя = "")

	Лог.Отладка("Обрабатываю соответствие значений <%1> ", ИмяРодителя);

	ШаблонИмениПараметра = "%1";

	Если Не ПустаяСтрока(ИмяРодителя) Тогда
		ШаблонИмениПараметра = ИмяРодителя + ".%1";
	КонецЕсли;

	Для каждого КлючЗначение Из ВходящиеПараметры Цикл

		Лог.Отладка("Обрабатываю соответствие ключ <%1> ", КлючЗначение.Ключ);

		ИмяПараметра = СтрШаблон(ШаблонИмениПараметра, КлючЗначение.Ключ);
		ЗначениеПараметра = КлючЗначение.Значение;

		ДобавитьПараметрВИндекс(ИмяПараметра, ЗначениеПараметра);

	КонецЦикла;

КонецПроцедуры

Процедура НайтиИУстановитьФайлПараметров()

	НайденныйФайл = Неопределено;

	Если ЗначениеЗаполнено(ПутьКФайлуПараметров) Тогда

		НайденныйФайл = Новый Файл(ПутьКФайлуПараметров);

	Иначе
		
		МассивДоступныхМасокФайлов = Новый Массив;
			
		Если ЗначениеЗаполнено(РасширениеФайлаПараметров) Тогда
			МассивДоступныхМасокФайлов.Добавить(СтрШаблон("%1%2", ИмяФайлаПараметров, РасширениеФайлаПараметров));
		Иначе

			МассивДоступныхМасокФайлов.Добавить(СтрШаблон("%1.%2", ИмяФайлаПараметров, "yaml"));
			МассивДоступныхМасокФайлов.Добавить(СтрШаблон("%1.%2", ИмяФайлаПараметров, "yml"));
			МассивДоступныхМасокФайлов.Добавить(СтрШаблон("%1.%2", ИмяФайлаПараметров, "json"));
		
		КонецЕсли;

		Лог.Отладка("Ищю файлы с именем <%1>", ИмяФайлаПараметров);

		Для каждого ПутьПоиска Из МассивПутейПоиска Цикл

			Лог.Отладка("  поиск в каталоге <%1>", ПутьПоиска);

			Для каждого ФайлПоиска Из МассивДоступныхМасокФайлов Цикл
				
				МассивФайлов = НайтиФайлы(ПутьПоиска, ФайлПоиска);

				Если МассивФайлов.Количество() > 0  Тогда
					НайденныйФайл = МассивФайлов[0]; // Всегда берется первый найденный
				КонецЕсли;

			КонецЦикла;

		КонецЦикла;

		Если Не ЗначениеЗаполнено(НайденныйФайл) Тогда
			Возврат;
		КонецЕсли;

	КонецЕсли;

	Лог.Отладка("Использую файл параметров <%1>", НайденныйФайл.ПолноеИмя);

	Если РасширениеФайлаПараметров = НайденныйФайл.Расширение Тогда
		КлассЧтенияФайла = КлассЧтенияФайлаПараметров;
	Иначе
		КлассЧтенияФайла = ПолучитьОбработчикПоРасширению(НайденныйФайл.Расширение);
	КонецЕсли;

	УстановитьФайлПараметров(НайденныйФайл.ПолноеИмя);

	РасширениеФайлаПараметров = НайденныйФайл.Расширение;
	КлассЧтенияФайлаПараметров = КлассЧтенияФайла;

КонецПроцедуры

Функция ПолучитьОбработчикПоРасширению(Знач РасширениеФайла)

	Лог.Отладка("Получаю класс чтения файла по расширению <%1>", РасширениеФайла);

	Если НРег(РасширениеФайла) = ".yaml"
		ИЛИ НРег(РасширениеФайла) = ".yml" Тогда
		Возврат Новый ЧтениеПараметровYAML();
	ИначеЕсли НРег(РасширениеФайла) = ".json" Тогда
		Возврат Новый ЧтениеПараметровJSOn();
	Иначе
		ВызватьИсключение "Расширение данного файла не поддерживаться для чтения";
	КонецЕсли;

КонецФункции

Процедура ПроверитьКлассЧтенияФайлаПараметров()

	НеобходимыйИнтерфейсЕсть = ПроверитьМетодКласса(КлассЧтенияФайлаПараметров, "Прочитать", 1);

	Если НЕ НеобходимыйИнтерфейсЕсть Тогда
		ВызватьИсключение СтрШаблон("Класс <%1> не реализует необходимой функции <%2>", КлассЧтенияФайлаПараметров , "Прочитать(ИмяФайла)" );
	КонецЕсли;

КонецПроцедуры

Процедура ВыгрузитьПараметрыВКлассПриемник()

	СтруктураПараметров = КлассПриемникПараметров.ПолучитьПараметры();

	ЗаполнитьСтруктуруПараметров(СтруктураПараметров);

	КлассПриемникПараметров.УстановитьПараметры(СтруктураПараметров);

КонецПроцедуры

Процедура ДобавитьСоответствиеВСтруктуру(Знач ВходящиеПараметры, Знач ИмяРодителя = "")

	ШаблонИмениПараметра = "%1";

	Если Не ПустаяСтрока(ИмяРодителя) Тогда
		ШаблонИмениПараметра = ИмяРодителя + ".%1";
	КонецЕсли;

	Для каждого КлючЗначение Из ВходящиеПараметры Цикл

		ИмяПараметра = СтрШаблон(ШаблонИмениПараметра, КлючЗначение.Ключ);
		ЗначениеПараметра = КлючЗначение.Значение;

		ДобавитьПараметрВИндекс(ИмяПараметра, ЗначениеПараметра);

	КонецЦикла;

КонецПроцедуры

Процедура ЗаполнитьСтруктуруПараметров(СтруктураПараметров)

	ЕстьОбработчикПолученияЗначения = Ложь; //  Проверить на доступный метод ПриПолученииЗначения(ИмяСвойства, ЗначениеСвойства, СтандартнаяОбработка)

	Для каждого КлючЗначение Из СтруктураПараметров Цикл

		ИмяКлюча = КлючЗначение.Ключ;
		ТекущееЗначение = КлючЗначение.Значение;

		ИмяПараметра = ИмяКлюча;

		НовоеЗначение = Параметр(ИмяПараметра);

		Если НовоеЗначение = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		СтандартнаяОбработка = Истина;

		ПриУстановкиЗначенияПараметра(ИмяПараметра, ИмяКлюча, НовоеЗначение, СтандартнаяОбработка);
		
		Если СтандартнаяОбработка Тогда

			СтруктураПараметров[ИмяКлюча] = ОбработатьЗначениеРекурсивно(ТекущееЗначение, НовоеЗначение, ИмяКлюча);

		КонецЕсли;

	КонецЦикла;

КонецПроцедуры

Процедура ПриУстановкиЗначенияПараметра(Знач ПолныйПутьКлюча, Знач ИмяКлюча, Значение, СтандартнаяОбработка)
	
	ЕстьНужныйМетод = Истина; // Добавить поверку 1 раз в кеш
	Если ЕстьНужныйМетод Тогда
		КлассПриемникПараметров.ПриУстановкиЗначенияПараметра(ПолныйПутьКлюча, ИмяКлюча, Значение, СтандартнаяОбработка);
	КонецЕсли;

КонецПроцедуры

Функция ОбработатьЗначениеРекурсивно(Знач ЗначениеСтруктуры, Знач ЗначениеПараметра, Знач ИмяПараметра = "")

	Если ЗначениеПараметра = Неопределено Тогда
		Возврат ЗначениеСтруктуры;
	КонецЕсли;

	Если ЭтоМассив(ЗначениеСтруктуры) Тогда
		Возврат ОбработатьЗначениеМассив(ЗначениеСтруктуры, ЗначениеПараметра, ИмяПараметра);
	ИначеЕсли ЭтоСоответствие(ЗначениеСтруктуры) Тогда
		Возврат ОбработатьЗначениеСоответствие(ЗначениеСтруктуры, ЗначениеПараметра, ИмяПараметра);
	ИначеЕсли ЭтоСтруктура(ЗначениеСтруктуры) Тогда
		Возврат ОбработатьЗначениеСтруктуру(ЗначениеСтруктуры, ЗначениеПараметра, ИмяПараметра);
	Иначе
		Возврат ЗначениеПараметра;
	КонецЕсли;

КонецФункции

Функция ОбработатьЗначениеМассив(Знач МассивСтруктуры, Знач МассивЗначений, Знач ИмяРодителя = "")

	Лог.Отладка("Обработка массива");
	Лог.Отладка("Структура приемник: ");
	Лог.Отладка("-- Имя родителя <%1>", ИмяРодителя);
	Лог.Отладка("-- Количество элементов <%1>", МассивЗначений.Количество());

	ШаблонИмениПараметра = "%1";

	Если Не ПустаяСтрока(ИмяРодителя) Тогда
		ШаблонИмениПараметра = ИмяРодителя + ".%1";
	КонецЕсли;

	Если МассивЗначений.Количество() = 0 Тогда
		Возврат МассивСтруктуры;
	КонецЕсли;

	Если МассивСтруктуры.Количество() > 0 Тогда
		ЗначениеСтруктуры = МассивЗначений[0];
	КонецЕсли;

	МассивСтруктуры.Очистить();

	Для ИндексЗначения = 0 По МассивЗначений.ВГраница() Цикл

		ИмяПараметра = СтрШаблон(ШаблонИмениПараметра, ИндексЗначения);

		СтандартнаяОбработка = Истина;

		ЗначениеПараметра = Параметр(ИмяПараметра);

		НовоеЗначение = ОбработатьЗначениеРекурсивно(ЗначениеСтруктуры, ЗначениеПараметра, ИмяПараметра);

		Лог.Отладка("Параметр <%1>  значение <%2>", ИмяПараметра, НовоеЗначение);
		ПриУстановкиЗначенияПараметра(ИмяПараметра, ИндексЗначения, НовоеЗначение, СтандартнаяОбработка);
		
		Если СтандартнаяОбработка Тогда

			МассивСтруктуры.Добавить(НовоеЗначение);

		КонецЕсли;

	КонецЦикла;

	Возврат МассивСтруктуры;

КонецФункции

Функция ОбработатьЗначениеСоответствие(Знач СтруктураПриемник, Знач ВходящееСоответсвие, Знач ИмяРодителя = "")
	
	Лог.Отладка("Обработка соответствие ");
	Лог.Отладка("Структура приемник: ");
	Лог.Отладка("-- Имя родителя <%1>", ИмяРодителя);
	ПоказатьПараметрыВРежимеОтладки(СтруктураПриемник, ИмяРодителя);

	ШаблонИмениПараметра = "%1";

	Если Не ПустаяСтрока(ИмяРодителя) Тогда
		ШаблонИмениПараметра = ИмяРодителя + ".%1";
	КонецЕсли;

	НоваяКоллекция = Новый Соответствие;

	Для каждого КлючЗначение Из СтруктураПриемник Цикл
		
		ИмяКлюча = КлючЗначение.Ключ;
		ТекущееЗначение = КлючЗначение.Значение;

		ИмяПараметра = СтрШаблон(ШаблонИмениПараметра, ИмяКлюча);

		НовоеЗначение = Параметр(ИмяПараметра);

		Если НовоеЗначение = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		СтандартнаяОбработка = Истина;

		ПриУстановкиЗначенияПараметра(ИмяПараметра, ИмяКлюча, НовоеЗначение, СтандартнаяОбработка);
		
		Если СтандартнаяОбработка Тогда

			НоваяКоллекция[ИмяКлюча] = ОбработатьЗначениеРекурсивно(ТекущееЗначение, НовоеЗначение, ИмяПараметра);

		КонецЕсли;

	КонецЦикла;

	Для каждого КлючЗначение Из НоваяКоллекция Цикл
	
		ИмяКлюча = КлючЗначение.Ключ;
		ТекущееЗначение = КлючЗначение.Значение;

		СтруктураПриемник.Вставить(ИмяКлюча, ТекущееЗначение);
	
	КонецЦикла;

	Возврат СтруктураПриемник;

КонецФункции

Функция ОбработатьЗначениеСтруктуру(Знач СтруктураПриемник, Знач ВходящаяСтруктура, Знач ИмяРодителя = "")

	Лог.Отладка("Обработка структуры ");
	Лог.Отладка("Структура приемник: ");
	Лог.Отладка("-- Имя родителя <%1>", ИмяРодителя);
	ПоказатьПараметрыВРежимеОтладки(СтруктураПриемник, ИмяРодителя);

	ШаблонИмениПараметра = "%1";

	Если Не ПустаяСтрока(ИмяРодителя) Тогда
		ШаблонИмениПараметра = ИмяРодителя + ".%1";
	КонецЕсли;

	Для каждого КлючЗначение Из СтруктураПриемник Цикл
		
		ИмяКлюча = КлючЗначение.Ключ;
		ТекущееЗначение = КлючЗначение.Значение;

		ИмяПараметра = СтрШаблон(ШаблонИмениПараметра, ИмяКлюча);

		НовоеЗначение = Параметр(ИмяПараметра);

		Если НовоеЗначение = Неопределено Тогда
			Продолжить;
		КонецЕсли;

		СтандартнаяОбработка = Истина;

		ПриУстановкиЗначенияПараметра(ИмяПараметра, ИмяКлюча, НовоеЗначение, СтандартнаяОбработка);
		
		Если СтандартнаяОбработка Тогда

			СтруктураПриемник[ИмяКлюча] = ОбработатьЗначениеРекурсивно(ТекущееЗначение, НовоеЗначение, ИмяПараметра);

		КонецЕсли;

	КонецЦикла;

	Возврат СтруктураПриемник;

КонецФункции

Функция ПолучитьПутьКФайлуПараметров()

	ФайлПараметров = Новый Файл(ПутьКФайлуПараметров);

	Если ФайлПараметров.Существует() Тогда
		Возврат ФайлПараметров.ПолноеИмя;
	Иначе
		Возврат "";
	КонецЕсли;

КонецФункции

Функция ПроверитьМетодКласса(Знач ПроверяемыйКласс,
	Знач ИмяМетода,
	Знач ТребуемоеКоличествоПараметров = 0,
	Знач ЭтоФункция = Ложь)

	РефлекторПроверкиКоманд = Новый Рефлектор;

	ЕстьМетод = РефлекторПроверкиКоманд.МетодСуществует(ПроверяемыйКласс, ИмяМетода);
	Лог.Отладка("Проверяемый метод <%1> найден: %2", ИмяМетода, ЕстьМетод);
	Если Не ЕстьМетод Тогда
		Возврат Ложь;
	КонецЕсли;

	ТаблицаМетодов = РефлекторПроверкиКоманд.ПолучитьТаблицуМетодов(ПроверяемыйКласс);

	СтрокаМетода = ТаблицаМетодов.Найти(ИмяМетода, "Имя");
	Лог.Отладка("Поиск строки в таблице методов класса <%1> найдена: %2, общее количество методов класса: %3", ПроверяемыйКласс, НЕ СтрокаМетода = Неопределено, ТаблицаМетодов.Количество());
	Если СтрокаМетода = Неопределено Тогда
		Возврат Ложь;
	КонецЕсли;

	ПроверкаНаФункцию = ЭтоФункция = СтрокаМетода.ЭтоФункция;
	ПроверкаНаКоличествоПараметров = ТребуемоеКоличествоПараметров = СтрокаМетода.КоличествоПараметров;

	Лог.Отладка("Проверяемый метод <%1> корректен: %2", ИмяМетода, ПроверкаНаФункцию И ПроверкаНаКоличествоПараметров);
	Возврат ПроверкаНаФункцию
		И ПроверкаНаКоличествоПараметров;

КонецФункции // ПроверитьМетодУКласса()

Процедура ДобавитьСтандартныеПутиПоиска()

	СистемнаяИнформация = Новый СистемнаяИнформация;

	МассивПутейПоиска.Добавить(ТекущийКаталог());
	МассивПутейПоиска.Добавить(СистемнаяИнформация.ПолучитьПутьПапки(СпециальнаяПапка.ЛокальныйКаталогДанныхПриложений));
	МассивПутейПоиска.Добавить(СистемнаяИнформация.ПолучитьПутьПапки(СпециальнаяПапка.ПрофильПользователя));

КонецПроцедуры

Процедура ОчиститьСтандартныеПутиПоиска()

	МассивПутейПоиска.Очистить();

КонецПроцедуры

Процедура ПоказатьПараметрыВРежимеОтладки(ЗначенияПараметров, Знач Родитель = "")
	Если Родитель = "" Тогда
		Лог.Отладка("	Тип параметров %1", ТипЗнч(ЗначенияПараметров));
	КонецЕсли;
	Если ЗначенияПараметров.Количество() = 0 Тогда
		Лог.Отладка("	Коллекция параметров пуста!");
	КонецЕсли;
	Для каждого Элемент из ЗначенияПараметров Цикл
		ПредставлениеКлюча = Элемент.Ключ;
		Если Не ПустаяСтрока(Родитель) Тогда
			ПредставлениеКлюча  = СтрШаблон("%1.%2", Родитель, ПредставлениеКлюча);
		КонецЕсли;
		Лог.Отладка("	Получен параметр <%1> = <%2>", ПредставлениеКлюча, Элемент.Значение);
		Если ТипЗнч(Элемент.Значение) = Тип("Соответствие") 
			ИЛИ ТипЗнч(Элемент.Значение) = Тип("Структура")  Тогда
			ПоказатьПараметрыВРежимеОтладки(Элемент.Значение, ПредставлениеКлюча);
		КонецЕсли;
	КонецЦикла;
КонецПроцедуры

Лог = Логирование.ПолучитьЛог("oscript.lib.configor");