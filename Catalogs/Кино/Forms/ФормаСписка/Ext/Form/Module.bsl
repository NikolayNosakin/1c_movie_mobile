﻿
&НаКлиенте
Процедура ПриОткрытии(Отказ)
	#Если МобильныйКлиент или МобильноеПриложение Тогда			
		Элементы.Поиск.Видимость = Истина;	
	#КонецЕсли
КонецПроцедуры

&НаКлиенте
Процедура Жанры(Команда)
	ОткрытьФорму("Справочник.Жанры.ФормаСписка");
КонецПроцедуры

&НаКлиенте
Процедура Страны(Команда)
	ОткрытьФорму("Справочник.Страны.ФормаСписка");
КонецПроцедуры
