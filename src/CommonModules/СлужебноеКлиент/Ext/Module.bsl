﻿Функция УстройствоИмеетДоступВИнтернет() Экспорт
	#Если НЕ ТонкийКлиент Тогда
		Возврат НЕ ИнформацияОбИнтернетСоединении.ПолучитьТипСоединения() = ТипИнтернетСоединения.НетСоединения;	
	#Иначе	
		Возврат Истина
	#КонецЕсли
КонецФункции

Процедура ПроверитьУстановитьВерсиюПриложения() Экспорт

	СлужебноеВызовСервера.ПроверитьУстановитьВерсиюПриложения();
	
КонецПроцедуры