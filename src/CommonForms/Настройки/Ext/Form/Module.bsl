﻿&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)	
	kinopoisk_unofficial_api_token = Константы.kinopoisk_unofficial_api_token.Получить();
	Стиль = Константы.СтильОформления.Получить(); 
	РезервноеКопированиеНаЯндексДиск = Константы.РезервноеКопированиеНаЯндексДиск.Получить();
	ЯД_ID_Приложения = Константы.ЯД_ID_Приложения.Получить();
	ЯД_КодАвторизации = Константы.ЯД_КодАвторизации.Получить();
	ЯД_ПарольПриложения = Константы.ЯД_ПарольПриложения.Получить();
	ЯД_СрокДействияТокена = Константы.ЯД_СрокДействияТокена.Получить();
	ЯД_Токен = Константы.ЯД_Токен.Получить();
	ПарольДляВхода = Константы.ПарольДляВхода.Получить();
	СкрыватьПросмотренныеСерии = Константы.СкрыватьПросмотренныеСерии.Получить(); 
	Элементы.ВерсияПриложения.Заголовок = Нстр("ru = 'Версия приложения:';en = 'Version:'") + " " + Константы.ВерсияПриложения.Получить();	
	ВысотаШрифтаСписка = Константы.ВысотаШрифтаСписка.Получить();
	ВыводитьКнопкиЖанровИСтранВСписокКино = Константы.ВыводитьКнопкиЖанровИСтранВСписокКино.Получить();
	ПроверкаНаДубльПоКодуКинопоиска = Константы.ПроверкаНаДубльПоКодуКинопоиска.Получить();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	ОбновитьВидимость();
КонецПроцедуры

&НаКлиенте
Процедура kinopoisk_unofficial_api_tokenПриИзменении(Элемент)
	УстановитьЗначениеКонстанты("kinopoisk_unofficial_api_token", kinopoisk_unofficial_api_token);
	УстановитьЗначениеКонстанты("ИспользуетсяЗаполнениеИзКинопоискаПоАПИ", НЕ kinopoisk_unofficial_api_token = "");
КонецПроцедуры

&НаСервере
Процедура УстановитьЗначениеКонстанты(ИмяКонстанты, ЗначениеКонстанты)
	Константы[ИмяКонстанты].Установить(ЗначениеКонстанты);
КонецПроцедуры

&НаКлиенте
Процедура СтильПриИзменении(Элемент)	
	УстановитьЗначениеКонстанты("СтильОформления", Стиль);	
	ТекстВопроса = Нстр("ru = 'Для применения нужно перезапустить программу. Перезапустить?';
					|en = 'To apply, you need to restart the program. Restart?'");	
	ЗадатьВопросПерезапуск(ТекстВопроса);		
КонецПроцедуры 

&НаКлиенте
Асинх Процедура ЗадатьВопросПерезапуск(ТекстВопроса)
	Результат = Ждать ВопросАсинх(ТекстВопроса, РежимДиалогаВопрос.ДаНет,10, КодВозвратаДиалога.Да," ",КодВозвратаДиалога.Да);	
	Если Результат = КодВозвратаДиалога.Да Тогда
		ЗавершитьРаботуСистемы(Ложь, Истина);
	Иначе
		ПоказатьДлительнуюОперацию(Ложь);
	КонецЕсли;		
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьВидимость()
	Элементы.НастройкиРезервногоКопированияЯД.Видимость = РезервноеКопированиеНаЯндексДиск;
	#Если ТонкийКлиент или ВебКлиент Тогда
	ОбновитьИнтерфейс();
	#КонецЕсли
КонецПроцедуры

&НаКлиенте
Асинх Процедура СохранитьДанные(Команда)	
	ПоказатьДлительнуюОперацию(Истина);	
	ПоказатьДаилогВыбораФайла = Ложь;
	Если РезервноеКопированиеНаЯндексДиск И СлужебноеКлиент.УстройствоИмеетДоступВИнтернет() Тогда
		ТекстВопроса = Нстр("ru = 'Путь сохранения данных:'; en = 'Data storage path:'");
		Результат = Ждать ВопросАсинх(ТекстВопроса, ПолучитьКнопкиДиалога(), 20, КодВозвратаДиалога.Отмена, " ", КодВозвратаДиалога.Отмена);	
		Если Результат = КодВозвратаДиалога.Да Тогда
			СохранитьДанныеНаЯД();
		ИначеЕсли Результат = КодВозвратаДиалога.Нет Тогда	
			ПоказатьДаилогВыбораФайла = Истина;
		КонецЕсли;
	Иначе
		ПоказатьДаилогВыбораФайла = Истина;
	КонецЕсли;
	Если ПоказатьДаилогВыбораФайла Тогда
		Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.ВыборКаталога); 
		Диалог.Каталог = КаталогДокументов();
		ВыбранныеФайлы = Ждать Диалог.ВыбратьАсинх();	
		Если ВыбранныеФайлы <> Неопределено Тогда		
			ПутьКФайлу = ВыбранныеФайлы[0];
			ПолучитьИСохранитьДанные(ПутьКФайлу);
		КонецЕсли;	
	КонецЕсли;      
	ПоказатьДлительнуюОперацию(Ложь);
КонецПроцедуры

&НаКлиенте
Функция ПолучитьКнопкиДиалога()	
	Кнопки = Новый СписокЗначений;
	Кнопки.Добавить(КодВозвратаДиалога.Да, Нстр("ru = 'Яндекс Диск'; en = 'Yandex Disk'"));
	Кнопки.Добавить(КодВозвратаДиалога.Нет, Нстр("ru = 'Это устройство'; en = 'This device'"));
	Кнопки.Добавить(КодВозвратаДиалога.Отмена, Нстр("ru = 'Отмена'; en = 'Cancel'"));	
	Возврат Кнопки	
КонецФункции

&НаКлиенте
Процедура СохранитьДанныеНаЯД()	
	Сруктура = ЯндексДискОбменДанными.СформироватьСтруктуруПараметров(ЯД_КодАвторизации, ЯД_ID_Приложения, ЯД_ПарольПриложения, ЯД_СрокДействияТокена, ЯД_Токен);	
	ПутьКФайлу = КаталогВременныхФайлов();
	ИмяФайла = "";
	ПолучитьИСохранитьДанные(ПутьКФайлу, ИмяФайла);	
	АдресФайла = ПоместитьВоВременноеХранилище(Новый ДвоичныеДанные(ПутьКФайлу + ИмяФайла));
	ЯндексДискОбменДанными.ЗагрузитьФайл("app:/" + ИмяФайла, АдресФайла, Истина, Сруктура);
	УдалитьФайлы(ПутьКФайлу + ИмяФайла);	
КонецПроцедуры

&НаКлиенте
Процедура ПолучитьИСохранитьДанные(ПутьКФайлу,ИмяФайла = "")
	ИмяФайла = "Movie_backup_"+Формат(ТекущаяДата(),"ДФ=yyyy.MM.dd")+"_"+Формат(ТекущаяДата(),"ДФ=чч.мм.сс")+".json";
	Данные = СохранениеВосстановлениеДанныхСервер.Сохранить();
	ПолныйПуть = ПутьКФайлу + СлужебноеКлиент.ПолучитьРазделительФайловойСистемы() + ИмяФайла;
	ТекДок = Новый ЗаписьТекста(ПолныйПуть);
	ТекДок.ЗаписатьСтроку(Данные);
	ТекДок.Закрыть();
	Сообщить(Нстр("ru = 'Данные записаны в файл ';
					|en = 'The data is written to a file '") + ПолныйПуть ,СтатусСообщения.Внимание);	
КонецПроцедуры

&НаКлиенте
Процедура ПоказатьДлительнуюОперацию(Показать)	
	Элементы.Группа2.Видимость = НЕ Показать;
	Элементы.ВерсияПриложения.Видимость = НЕ Показать;
	Элементы.ДлительнаяОперация.Видимость = Показать;	
КонецПроцедуры

&НаКлиенте
Асинх Процедура ВосстановитьДанные(Команда)	
	ПоказатьДлительнуюОперацию(Истина);	
	Если РезервноеКопированиеНаЯндексДиск И СлужебноеКлиент.УстройствоИмеетДоступВИнтернет() Тогда
		ТекстВопроса = Нстр("ru = 'Место получения данных:';
		|en = 'Place of data receipt:'");		
		Результат = Ждать ВопросАсинх(ТекстВопроса, ПолучитьКнопкиДиалога(), 20, КодВозвратаДиалога.Отмена, " ", КодВозвратаДиалога.Отмена);
		Если Результат = КодВозвратаДиалога.Да Тогда
			ВосстановитьДанныеС_ЯД();
			ВосстановлениеДанныхЯД_Видимость(Истина);
		ИначеЕсли Результат = КодВозвратаДиалога.Нет Тогда	
			ПоказатьВопросВосстановлениеДанных(Новый структура("Файл",Истина));	
		Иначе
			ПоказатьДлительнуюОперацию(Ложь);
		КонецЕсли;
	Иначе	
		ПоказатьВопросВосстановлениеДанных(Новый структура("Файл",Истина));	 
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Асинх Процедура ПоказатьВопросВосстановлениеДанных(Параметр)
	ТекстВопроса = Нстр("ru = 'Все имеющиеся данные будут удалены и заполнены данными из файла. Продолжить?';
						|en = 'All available data will be deleted and filled in with data from the file. Continue?'");
	Результат = Ждать ВопросАсинх(ТекстВопроса, РежимДиалогаВопрос.ДаНет, 20, КодВозвратаДиалога.Нет, " ", КодВозвратаДиалога.Нет);
	Если Результат = КодВозвратаДиалога.Да Тогда
		Если Параметр.Файл Тогда
			Диалог = Новый ДиалогВыбораФайла(РежимДиалогаВыбораФайла.Открытие);
			Диалог.МножественныйВыбор = Ложь; 
			ВыбранныеФайлы = Ждать Диалог.ВыбратьАсинх();	
			Если ВыбранныеФайлы = Неопределено Тогда		
				ПоказатьДлительнуюОперацию(Ложь);	
			Иначе	
				Восстановить(ВыбранныеФайлы[0]);
			КонецЕсли;				
		Иначе			
			ВосстановлениеДанныхЯД_Видимость(Ложь);
			Если НЕ Параметр.Путь = "" Тогда
				ВременныйФайл = ПолучитьИмяВременногоФайла("json");
				Сруктура = ЯндексДискОбменДанными.СформироватьСтруктуруПараметров(ЯД_КодАвторизации, ЯД_ID_Приложения, ЯД_ПарольПриложения, ЯД_СрокДействияТокена, ЯД_Токен);
				АдресФайла = ЯндексДискОбменДанными.СкачатьФайл(Параметр.Путь,Сруктура);
				ДанныеФайла = ПолучитьИзВременногоХранилища(АдресФайла);
				ДанныеФайла.Записать(ВременныйФайл);
				Восстановить(ВременныйФайл);
				УдалитьФайлы(ВременныйФайл);
			КонецЕсли;		
		КонецЕсли;
	Иначе
		ВосстановлениеДанныхЯД_Видимость(Ложь);
		ПоказатьДлительнуюОперацию(Ложь);
	КонецЕсли;
КонецПроцедуры	

&НаСервере
Процедура ВосстановитьДанныеС_ЯД()	
	Сруктура = ЯндексДискОбменДанными.СформироватьСтруктуруПараметров(ЯД_КодАвторизации, ЯД_ID_Приложения, ЯД_ПарольПриложения, ЯД_СрокДействияТокена, ЯД_Токен);	
	ЯндексДискОбменДанными.СписокФайлов(,,Сруктура,СписокФайлов);		
КонецПроцедуры

&НаКлиенте
Процедура ВосстановлениеДанныхЯД_Видимость(Видимость)
	Элементы.СписокФайлов.Видимость = Видимость;
	Элементы.ДлительнаяОперация.Видимость = НЕ Видимость;
КонецПроцедуры	

&НаКлиенте
Процедура Восстановить(ПутьКФайлу)	
	ЧТ = Новый ЧтениеТекста(ПутьКФайлу);
	Текст = ЧТ.Прочитать();
	Лог = "";
	СохранениеВосстановлениеДанныхСервер.Восстановить(Текст,Лог);
	Если Лог = "" Тогда
		ТекстВопроса = Нстр("ru = 'Восстановление данных завершено. Для нормальной работы желательно перезапустить программу. Перезапустить?';
					|en = 'Data recovery is complete. For normal operation, it is advisable to restart the program. Restart?'");
		ЗадатьВопросПерезапуск(ТекстВопроса);	
	Иначе
		Сообщить(Нстр("ru = 'В процессе восстановленя произошла ошибка. Описание ошибки: ';
					|en = 'An error occurred during the recovery process. Error Description:'") + Лог,СтатусСообщения.Внимание);
	КонецЕсли;
КонецПроцедуры	

&НаКлиенте
Процедура КонстантыПриИзменении(Элемент)
	УстановитьЗначениеКонстанты(Элемент.Имя, ЭтаФорма[Элемент.Имя]);
	ОбновитьВидимость();
	Если Элемент.Имя = "ВысотаШрифтаСписка" Тогда
		Оповестить("ИзменениеВысотыШрифтаСписка",ЭтаФорма[Элемент.Имя],ЭтаФорма);
	КонецЕсли;	
КонецПроцедуры

&НаКлиенте
Процедура КодАвторизации(Команда)
	ОткрытьФорму("ОбщаяФорма.ЯДФормаАвторизации", ,Элементы.ЯД_КодАвторизации, УникальныйИдентификатор);
КонецПроцедуры

&НаКлиенте
Процедура Токен(Команда) 
	Сруктура = ЯндексДискОбменДанными.СформироватьСтруктуруПараметров(ЯД_КодАвторизации, ЯД_ID_Приложения, ЯД_ПарольПриложения, ЯД_СрокДействияТокена, ЯД_Токен);
	ЯндексДискОбменДанными.Токен(Сруктура); 
	ЯД_СрокДействияТокена = Сруктура.СрокДействияТокена;	
	ЯД_Токен = Сруктура.Токен;
	УстановитьЗначениеКонстанты("ЯД_Токен", Сруктура.Токен); 
	УстановитьЗначениеКонстанты("ЯД_СрокДействияТокена", Сруктура.СрокДействияТокена);
КонецПроцедуры

&НаКлиенте
Процедура СписокФайловВыбор(Элемент, ВыбраннаяСтрока, Поле, СтандартнаяОбработка)
	СтандартнаяОбработка = Ложь;
	Строка = Элементы.СписокФайлов.ТекущиеДанные;
	ПоказатьВопросВосстановлениеДанных(Новый структура("Файл,Путь", Ложь,Строка.Путь));
КонецПроцедуры

&НаКлиенте
Процедура СписокФайловВыборЗначения(Элемент, Значение, СтандартнаяОбработка)	
	СтандартнаяОбработка = Ложь;
	Строка = Элементы.СписокФайлов.ТекущиеДанные;	
	ПоказатьВопросВосстановлениеДанных(Новый структура("Файл,Путь", Ложь, Строка.Путь));		
КонецПроцедуры

&НаКлиенте
Процедура СправкаАПИ(Команда)
	ФC1 = Новый ФорматированнаяСтрока(Нстр("ru = 'Данный токен нужен для автоматического заполнения данных о фильмах.';
						|en = 'This token is needed to automatically fill in data about movies.'"));
	ФC2 = Новый ФорматированнаяСтрока(Нстр("ru = 'Для получения токена зарегистрируйтесь на сайте kinopoiskapiunofficial.tech.';
						|en = 'To get a token, register on the kinopoiskapiunofficial.tech website.'"));	
	ФC3 = Новый ФорматированнаяСтрока(Нстр("ru = 'Перейти на сайт'; en = 'Go to the website'"),,,,"https://kinopoiskapiunofficial.tech");	
	Массив = Новый Массив;
	Массив.Добавить(ФC1);
	Массив.Добавить(Символы.ПС);
	Массив.Добавить(ФC2);
	Массив.Добавить(Символы.ПС);
	Массив.Добавить(ФC3);	
	ФормСтрока = Новый ФорматированнаяСтрока(Массив);
	ПоказатьПредупреждение(,ФормСтрока,,"Токен");
КонецПроцедуры
