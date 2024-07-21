#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
          
    ОтборПоТипу  = 1;
    КлючОбъекта  = "YPM";
    КлючНастроек = "АдресИндекса";
    АдресИндекса = ХранилищеОбщихНастроек.Загрузить(КлючОбъекта, КлючНастроек);
    
    Если Не ЗначениеЗаполнено(АдресИндекса) Тогда
        
        АдресИндекса = "https://openyellow.neocities.org/ypm_index/index.json";
        ХранилищеОбщихНастроек.Сохранить(КлючОбъекта, КлючНастроек, АдресИндекса);
        
    КонецЕсли;
    
    СписокФайлов.Параметры.УстановитьЗначениеПараметра("Автор"      , "");
    СписокФайлов.Параметры.УстановитьЗначениеПараметра("Репозиторий", "");
    СписокФайлов.Параметры.УстановитьЗначениеПараметра("ОтборПоТипу", ОтборПоТипу);
    СписокПакетов.Параметры.УстановитьЗначениеПараметра("ОтборПоТипу", ОтборПоТипу);
    
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
    СписокПакетовПриАктивизацииСтроки(Неопределено);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОтборПоТипуПриИзменении(Элемент)
    СписокПакетов.Параметры.УстановитьЗначениеПараметра("ОтборПоТипу", ОтборПоТипу);
    СписокФайлов.Параметры.УстановитьЗначениеПараметра("ОтборПоТипу", ОтборПоТипу);
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписокПакетов

&НаКлиенте
Процедура СписокПакетовПриАктивизацииСтроки(Элемент)
    
    ТД = Элементы.СписокПакетов.ТекущиеДанные;
    
    Если ТД <> Неопределено Тогда
        
        СписокФайлов.Параметры.УстановитьЗначениеПараметра("Автор", ТД.Автор);
        СписокФайлов.Параметры.УстановитьЗначениеПараметра("Репозиторий", ТД.Репозиторий);
        СтраницаРепозитория = ТД.СтраницаРепозитория; 
        
    КонецЕсли;
    
КонецПроцедуры

&НаКлиенте
Процедура СписокПакетовСтраницаРепозиторияНажатие(Элемент, СтандартнаяОбработка)
    
    СтандартнаяОбработка = Ложь;
    ТД = Элементы.СписокПакетов.ТекущиеДанные;
    
    Если Не ТД = Неопределено Тогда
        ОО = Новый ОписаниеОповещения();
        НачатьЗапускПриложения(ОО, ТД.СтраницаРепозитория);
    КонецЕсли;
    
КонецПроцедуры

&НаКлиенте
Процедура СписокПакетовСтраницаАвтораНажатие(Элемент, СтандартнаяОбработка)
    
    СтандартнаяОбработка = Ложь;
    ТД = Элементы.СписокПакетов.ТекущиеДанные;
    
    Если Не ТД = Неопределено Тогда
        ОО = Новый ОписаниеОповещения();
        НачатьЗапускПриложения(ОО, ТД.СтраницаАвтора);
    КонецЕсли;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СохранитьАдресИндекса(Команда)
    СохранитьАдресИндексаНаСервере(АдресИндекса);
КонецПроцедуры

&НаКлиенте
Процедура АдресИндексаПоУмолчанию(Команда)
    АдресИндекса = "https://openyellow.neocities.org/ypm_index/index.json";
    СохранитьАдресИндексаНаСервере(АдресИндекса);
КонецПроцедуры

&НаКлиенте
Процедура ОбновитьИндекс(Команда)
    ОбновитьИндексНаСервере();
КонецПроцедуры

&НаКлиенте
Процедура Скачать(Команда)
    
    ТД = Элементы.СписокФайлов.ТекущиеДанные;
    
    Если Не ТД = Неопределено Тогда
        
        ОО    = Новый ОписаниеОповещения("ПослеВыбораПути", ЭтотОбъект, ТД.АдресФайла);
        Режим = РежимДиалогаВыбораФайла.Сохранение;                   
        Диалог = Новый ДиалогВыбораФайла(Режим);
        Диалог.ПолноеИмяФайла = ТД.Файл;
        Диалог.МножественныйВыбор = Ложь;
        Диалог.Показать(ОО);
        
    КонецЕсли;
    
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервереБезКонтекста
Процедура СохранитьАдресИндексаНаСервере(Знач АдресИндекса)
    
    КлючОбъекта  = "YPM";
    КлючНастроек = "АдресИндекса";

    ХранилищеОбщихНастроек.Сохранить(КлючОбъекта, КлючНастроек, АдресИндекса);
    
КонецПроцедуры

&НаСервере
Процедура ОбновитьИндексНаСервере()
    
    ТекущийОбъект = ЭтотОбъект.РеквизитФормыВЗначение("Объект");
    ТекущийОбъект.ОбновитьИндекс(АдресИндекса);
    ЭтотОбъект.ЗначениеВРеквизитФормы(ТекущийОбъект, "Объект");
    
КонецПроцедуры

Процедура ПослеВыбораПути(Результат, АдресФайла) Экспорт
    
    Если Не Результат = Неопределено Тогда
        
        ДД = YPM_Инструменты.Get(АдресФайла);
        ДД.Записать(Результат[0]);    
    КонецЕсли;
    
КонецПроцедуры

#КонецОбласти
