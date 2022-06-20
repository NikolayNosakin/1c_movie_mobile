﻿
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)		
	
	Просмотренные = НЕ Константы.СкрыватьПросмотренныеСерии.Получить();
	УстановитьПараметрДинамисческогоСписка(); 
	
	Пароль = Константы.ПарольДляВхода.Получить();
	Если НЕ Пароль = "" Тогда
		ВходПоПаролю = Истина;
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура Жанры(Команда)
	ОткрытьФорму("Справочник.Жанры.ФормаСписка");
КонецПроцедуры

&НаКлиенте
Процедура Страны(Команда)
	ОткрытьФорму("Справочник.Страны.ФормаСписка");
КонецПроцедуры

&НаКлиенте
Процедура Настройки(Команда)
	ОткрытьФорму("ОбщаяФорма.Настройки");
КонецПроцедуры

&НаСервере
Процедура УстановитьПараметрДинамисческогоСписка()
	Список.Параметры.УстановитьЗначениеПараметра("Просмотренные", Просмотренные); 
	Список.Параметры.УстановитьЗначениеПараметра("Тип", Тип);
КонецПроцедуры

&НаКлиенте
Процедура СкрытьПросмотренныеПриИзменении(Элемент)
	УстановитьПараметрДинамисческогоСписка();
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	Если ВходПоПаролю Тогда 
		ОткрытьФорму("ОбщаяФорма.ВходПоПаролю",,,,,,,РежимОткрытияОкнаФормы.БлокироватьВесьИнтерфейс);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ТипОтборПриИзменении(Элемент)
	УстановитьПараметрДинамисческогоСписка();
КонецПроцедуры
