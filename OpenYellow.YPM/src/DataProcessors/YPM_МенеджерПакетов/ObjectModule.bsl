Процедура ОбновитьИндекс(Знач АдресИндекса) Экспорт
    
    ЛогОбновления = "";
    ДобавитьСтрокуЛога("Начало обновления индекса...");
    ДобавитьСтрокуЛога("Получение индекса из " + АдресИндекса);
    
    Попытка
        МассивИндекса = YPM_Инструменты.GetJSON(АдресИндекса);
        ДобавитьСтрокуЛога("Индекс получен! Число элементов: " + Строка(МассивИндекса.Количество()));
    Исключение
        ДобавитьСтрокуЛога(ОписаниеОшибки());
        Возврат;
    КонецПопытки;
    
    Для Каждого Блок Из МассивИндекса Цикл
        
        Попытка
            ДобавитьСтрокуЛога("Получение данных из блока " + Блок);
            ДанныеБлока = YPM_Инструменты.GetJSON(Блок);
            ЗаписатьДанныеБлока(ДанныеБлока);
        Исключение
            ДобавитьСтрокуЛога(ОписаниеОшибки());
            Продолжить;
        КонецПопытки;
    КонецЦикла;
    
    ДобавитьСтрокуЛога("Загрузка завершена!");
    
КонецПроцедуры

Процедура ЗаписатьДанныеБлока(Знач ДанныеБлока) 
    
    Для Каждого Репозиторий Из ДанныеБлока Цикл
       
        Название = Репозиторий["name"];
        Автор    = Репозиторий["authorName"];
        Версии   = Репозиторий["versions"];
        
        НЗ = РегистрыСведений.YPM_ИндексПакетов.СоздатьНаборЗаписей();
        НЗ.Отбор.Репозиторий.Установить(Название);
        НЗ.Отбор.Автор.Установить(Автор);
        
        НЗ.Прочитать();
        НЗ.Очистить();
        
        СтруктураЗаписи = Новый Структура;
        СтруктураЗаписи.Вставить("Репозиторий"        , Название);
        СтруктураЗаписи.Вставить("Автор"              , Автор);
        СтруктураЗаписи.Вставить("Описание"           , Репозиторий["description"]);
        СтруктураЗаписи.Вставить("СтраницаАвтора"     , Репозиторий["authorURL"]);
        СтруктураЗаписи.Вставить("СтраницаРепозитория", Репозиторий["URL"]);
        СтруктураЗаписи.Вставить("Лицензия"           , Репозиторий["license"]);
        СтруктураЗаписи.Вставить("Звезд"              , Репозиторий["stars"]);
        
        Для Каждого Версия Из Версии Цикл
            
            Файлы = Версия["files"];
            СтруктураЗаписи.Вставить("Версия", Версия["version"]);
            
            Для Каждого Файл Из Файлы Цикл
                
                СтруктураЗаписи.Вставить("Файл"      , Файл["file"]);
                СтруктураЗаписи.Вставить("АдресФайла", Файл["fileURL"]);
                СтруктураЗаписи.Вставить("Размер"    , Файл["size"]);
                СтруктураЗаписи.Вставить("Скачиваний", Файл["downloads"]);
                СтруктураЗаписи.Вставить("Тип"       , Файл["type"]);
                
                ЗаполнитьЗначенияСвойств(НЗ.Добавить(), СтруктураЗаписи);
                         
            КонецЦикла;
            
        КонецЦикла;
        
        НЗ.Записать(Истина);
         
    КонецЦикла;
    
КонецПроцедуры

Процедура ДобавитьСтрокуЛога(Знач Текст)
   ЛогОбновления = ЛогОбновления + Текст + Символы.ПС; 
КонецПроцедуры

