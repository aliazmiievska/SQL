;WITH 


-- початкова СпецифікаціяНомекл розрахована на N:N, але фірмою використовується як 1:N, 
-- тому архітектура коду трохи крива


-- помилки ---------
spr_SpecifNomenkl_VyhodIzdelia AS ( -- підфайл
    SELECT
        spr_SpecifNomenkl_VyhodIzdelia._Reference207_IDRRef
        ,spr_SpecifNomenkl_VyhodIzdelia._Fld2796RRef AS FK_Номенклатура
        ,spr_SpecifNomenkl_VyhodIzdelia._Fld2798 AS Количество_ВиходногоИзделия
        ,_Reference207_IDRRef AS ID

    FROM _Reference207_VT2794 AS spr_SpecifNomenkl_VyhodIzdelia
)

,Більше1ВиходнеІздПомилка AS ( -- перевірка 1:N на випадок, якщо фірма почне використовувати як N:N, або станеться баг в базі
    SELECT 
        _Reference207_IDRRef AS ID
        ,COUNT(_Reference207_IDRRef) AS Більше1ВиходнеІздПомилка
    FROM 
        _Reference207_VT2794
    
    GROUP BY 
        _Reference207_IDRRef
    HAVING 
        COUNT(_Reference207_IDRRef) > 1
)
-- помилки ---------


-- BASE ------------------------------------------------------------------------------------------
,spr_SpecifNomenkl AS ( -- ../spr/spr_SpecifNomenkl.sql
    SELECT
        spr_SpecifNomenkl_VyhodIzdelia.FK_Номенклатура AS FK_Номенклатура

        ,spr_SpecifNomenkl._IDRRef AS ID
        ,spr_SpecifNomenkl._Code AS Code
        ,spr_SpecifNomenkl._Description AS Назва
        ,spr_SpecifNomenkl._Marked AS ПоміткаВидалення
        ,spr_SpecifNomenkl._Fld2757 AS Активна
        ,spr_SpecifNomenkl_VyhodIzdelia.Количество_ВиходногоИзделия 

        ,Більше1ВиходнеІздПомилка.Більше1ВиходнеІздПомилка AS Більше1ВиходнеІздПомилка

    FROM 
        _Reference207 AS spr_SpecifNomenkl
        LEFT JOIN 
            spr_SpecifNomenkl_VyhodIzdelia AS spr_SpecifNomenkl_VyhodIzdelia 
            ON 
                spr_SpecifNomenkl._IDRRef = spr_SpecifNomenkl_VyhodIzdelia.ID
        LEFT JOIN 
            Більше1ВиходнеІздПомилка AS Більше1ВиходнеІздПомилка -- перевірка 1:N на випадок N:N
            ON 
                spr_SpecifNomenkl._IDRRef = Більше1ВиходнеІздПомилка.ID

    WHERE
        spr_SpecifNomenkl._Marked = 0 -- ПоміткаВидалення
        AND 
        spr_SpecifNomenkl._Fld2757 = 1 -- Активна
)
-- BASE ------------------------------------------------------------------------------------------


-- табличні ---------------------------------------------------------------
,spr_SpecifNomenkl_IsxodKomplektuyushie AS ( -- таблична
    SELECT
        spr_SpecifNomenkl_IsxodKomplektuyushie._Reference207_IDRRef AS FK_spr_SpecifNomenkl
        -- тут є FK номенклатура, але для 1:N воно не треба

        ,spr_SpecifNomenkl_IsxodKomplektuyushie._Fld2772RRef AS ВидНормативаFK
        ,spr_SpecifNomenkl_IsxodKomplektuyushie._Fld2773_RRRef AS НоменклатураFK
        ,spr_SpecifNomenkl_IsxodKomplektuyushie._Fld2775 AS Кількість
        ,spr_SpecifNomenkl_IsxodKomplektuyushie._Fld2776RRef AS ОдиницяВиміруFK
        ,spr_SpecifNomenkl_IsxodKomplektuyushie._Fld2777RRef AS СтаттяЗатратFK
        ,spr_SpecifNomenkl_IsxodKomplektuyushie._Fld2781 AS Кратність
        ,spr_SpecifNomenkl_IsxodKomplektuyushie._Fld2782RRef AS ВидПроізводстваFK
        ,spr_SpecifNomenkl_IsxodKomplektuyushie._Fld2783RRef AS СпецифікаціяFK
        
    FROM 
        _Reference207_VT2770 AS spr_SpecifNomenkl_IsxodKomplektuyushie
)

,spr_SpecifNomenkl_ParamVypuskaProdukcii AS ( -- таблична
    SELECT
        spr_SpecifNomenkl_ParamVypuskaProdukcii._Reference207_IDRRef AS FK_spr_SpecifNomenkl

        ,spr_SpecifNomenkl_ParamVypuskaProdukcii._Fld2828RRef AS ВидПараметраFK
        ,spr_SpecifNomenkl_ParamVypuskaProdukcii._Fld2829 AS Значення
    FROM 
        _Reference207_VT2826 AS spr_SpecifNomenkl_ParamVypuskaProdukcii
)
-- табличні ---------------------------------------------------------------


-- для пропса -----------------
,spr_Nomenklatura AS ( -- ../spr/spr_Nomenklatura.sql
    SELECT
        spr_Nomenklatura._IDRRef AS НоменклатураID
        ,spr_Nomenklatura._Code AS НоменклатураCode
        ,spr_Nomenklatura._Description AS НазваНоменклатури
        ,spr_Nomenklatura._Marked AS ПоміткаВидаленняНоменклатури
        ,spr_Nomenklatura._Folder AS ГрупаНоменклатури

        ,spr_Nomenklatura._Fld2306RRef AS FK_ВидНоменклатурьі_Номенклатура
        ,spr_Nomenklatura._Fld23716 AS КількістьВУпаковці_Номенклатура
        ,spr_Nomenklatura._Fld25116RRef AS FK_Проект_КаналЗбуту_Номенклатура
    FROM _Reference149 AS spr_Nomenklatura
)

,spr_VidyParamProizvods AS ( -- ../spr/spr_VidyParamProizvods.sql
    SELECT
        spr_VidyParamProizvods._IDRRef AS ID_ВидиПарамПроізводства,
        spr_VidyParamProizvods._Code AS Code_ВидиПарамПроізводства,
        spr_VidyParamProizvods._Description AS Назва_ВидиПарамПроізводства,
        spr_VidyParamProizvods._Marked AS ПоміткаВидалення_ВидиПарамПроізводства,
        spr_VidyParamProizvods._Folder AS ГрупаНоменклатури_ВидиПарамПроізводства
    FROM _Reference23884 AS spr_VidyParamProizvods
)

,spr_VidyParamVypuskProd AS ( -- ../spr/spr_VidyParamVypuskProd.sql
    SELECT
        spr_VidyParamVypuskProd._IDRRef AS ID_ВидиПарамВипускПрод,
        spr_VidyParamVypuskProd._Code AS Code_ВидиПарамВипускПрод,
        spr_VidyParamVypuskProd._Description AS Назва_ВидиПарамВипускПрод,
        spr_VidyParamVypuskProd._Marked AS ПоміткаВидалення_ВидиПарамВипускПрод,
        spr_VidyParamVypuskProd._Folder AS ГрупаНоменклатури_ВидиПарамВипускПрод
    FROM _Reference56 AS spr_VidyParamVypuskProd
)

,спр_ЕдиницьіИзмерения AS ( -- ../spr/спр_ЕдиницьіИзмерения.sql
    SELECT
        спр_ЕдиницьіИзмерения._IDRRef AS ID_ЕдиницьіИзмерения
        ,спр_ЕдиницьіИзмерения._Code AS Code_ЕдиницьіИзмерения
        ,спр_ЕдиницьіИзмерения._Description AS Назва_ЕдиницьіИзмерения
        ,спр_ЕдиницьіИзмерения._Marked AS ПоміткаВидалення_ЕдиницьіИзмерения
    FROM _Reference89 AS спр_ЕдиницьіИзмерения
)

,спр_СтатьиЗатрат AS ( -- ../spr/спр_СтатьиЗатрат.sql
    SELECT
        спр_СтатьиЗатрат._IDRRef AS ID_СтатьиЗатрат
        ,спр_СтатьиЗатрат._Code AS Код_СтатьиЗатрат
        ,спр_СтатьиЗатрат._Description AS Наименование_СтатьиЗатрат
        ,спр_СтатьиЗатрат._Marked AS ПометкаУдаления_СтатьиЗатрат
    FROM _Reference216 AS спр_СтатьиЗатрат
)
-- для пропсу -----------------

--
-- пропс ----------------------------------------------
,propsVyvidChar_SpecifNomenkl AS (
    SELECT
        spr_SpecifNomenkl.FK_Номенклатура AS FK_Номенклатура_Специфікації

        ,spr_SpecifNomenkl.Количество_ВиходногоИзделия                  AS Количество_ВиходногоИзделия
        ,spr_SpecifNomenkl.Code                                         AS КодСпецифікації
        ,spr_SpecifNomenkl.Назва                                        AS НазваСпецифікації
        ,spr_SpecifNomenkl.Більше1ВиходнеІздПомилка                     AS Більше1ВиходнеІздПомилка
        ,'ПараметриВипуску'                                             AS ТипСписку
        ,spr_VidyParamVypuskProd.Назва_ВидиПарамВипускПрод              AS ВидПараметра_ВипускПродукції
        ,spr_SpecifNomenkl_ParamVypuskaProdukcii.Значення               AS Значення_ВипускПродукції
        ,NULL                                                           AS ВидПроізводства_Комплектуючої
        ,NULL                                                           AS Кратність_Комплектуючої
        ,NULL                                                           AS Кількість_Комплектуючої
        ,NULL                                                           AS Номенклатура_Комплектуючої
        ,NULL                                                           AS ОдиницяВиміру_Комплектуючої
        ,NULL                                                           AS Специфікація_Комплектуючої
        ,NULL                                                           AS СтаттяЗатрат_Комплектуючої
    FROM 
        spr_SpecifNomenkl
        INNER JOIN spr_SpecifNomenkl_ParamVypuskaProdukcii
            ON spr_SpecifNomenkl.ID = spr_SpecifNomenkl_ParamVypuskaProdukcii.FK_spr_SpecifNomenkl

            
        LEFT JOIN spr_VidyParamVypuskProd
            ON spr_SpecifNomenkl_ParamVypuskaProdukcii.ВидПараметраFK = spr_VidyParamVypuskProd.ID_ВидиПарамВипускПрод

UNION ALL

SELECT
        spr_SpecifNomenkl.FK_Номенклатура AS FK_Номенклатура_Специфікації

        ,spr_SpecifNomenkl.Количество_ВиходногоИзделия                  AS Количество_ВиходногоИзделия
        ,spr_SpecifNomenkl.Code                                         AS КодСпецифікації
        ,spr_SpecifNomenkl.Назва                                        AS НазваСпецифікації
        ,spr_SpecifNomenkl.Більше1ВиходнеІздПомилка                     AS Більше1ВиходнеІздПомилка
        ,'ІсходніКомплектуючі'                                          AS ТипСписку
        ,NULL                                                           AS ВидПараметра_ВипускПродукції
        ,NULL                                                           AS Значення_ВипускПродукції
        ,spr_VidyParamProizvods.Назва_ВидиПарамПроізводства             AS ВидПроізводства_Комплектуючої
        ,spr_SpecifNomenkl_IsxodKomplektuyushie.Кратність               AS Кратність_Комплектуючої
        ,spr_SpecifNomenkl_IsxodKomplektuyushie.Кількість               AS Кількість_Комплектуючої
        ,spr_Nomenklatura_Комплектуючі.НазваНоменклатури                AS НоменклатураКомплектуючої
        ,спр_ЕдиницьіИзмерения.Назва_ЕдиницьіИзмерения                  AS ОдиницяВиміру_Комплектуючої
        ,spr_SpecifNomenkl_Комплектуючі.Назва                           AS СпецифікаціяКомплектуючої
        ,спр_СтатьиЗатрат.Наименование_СтатьиЗатрат                     AS СтаттяЗатрат_Комплектуючої
    FROM 
        spr_SpecifNomenkl
        INNER JOIN spr_SpecifNomenkl_IsxodKomplektuyushie
            ON spr_SpecifNomenkl.ID = spr_SpecifNomenkl_IsxodKomplektuyushie.FK_spr_SpecifNomenkl

        LEFT JOIN spr_VidyParamProizvods
            ON spr_SpecifNomenkl_IsxodKomplektuyushie.ВидПроізводстваFK = spr_VidyParamProizvods.ID_ВидиПарамПроізводства
        LEFT JOIN спр_ЕдиницьіИзмерения
            ON spr_SpecifNomenkl_IsxodKomplektuyushie.ОдиницяВиміруFK = спр_ЕдиницьіИзмерения.ID_ЕдиницьіИзмерения
        LEFT JOIN спр_СтатьиЗатрат
            ON spr_SpecifNomenkl_IsxodKomplektuyushie.СтаттяЗатратFK = спр_СтатьиЗатрат.ID_СтатьиЗатрат
        LEFT JOIN spr_Nomenklatura AS spr_Nomenklatura_Комплектуючі
            ON spr_SpecifNomenkl_IsxodKomplektuyushie.НоменклатураFK = spr_Nomenklatura_Комплектуючі.НоменклатураID
        LEFT JOIN spr_SpecifNomenkl AS spr_SpecifNomenkl_Комплектуючі
            ON spr_SpecifNomenkl_IsxodKomplektuyushie.СпецифікаціяFK = spr_SpecifNomenkl_Комплектуючі.ID
)
-- пропс ----------------------------------------------


-- відображення, можна змінити --
SELECT * FROM propsVyvidChar_SpecifNomenkl
-- відображення, можна змінити --