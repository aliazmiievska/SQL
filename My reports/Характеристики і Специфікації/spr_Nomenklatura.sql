;WITH 


-------------------------------------------------------------- BASE ---------------------------
spr_Nomenklatura AS ( -- ../spr/spr_Nomenklatura.sql
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
-------------------------------------------------------------- BASE ---------------------------


---------------------------------- Свойства півот ---------------------------------------------
-- для пропса
,regSv_ZnachSvoistvOb AS (
    SELECT
        regSv_ZnachSvoistvOb._SimpleKey AS ID,
        regSv_ZnachSvoistvOb._Fld17698_RRRef AS Обьект,
        regSv_ZnachSvoistvOb._Fld17699RRef AS Свойство,
        regSv_ZnachSvoistvOb._Fld17700_RRRef AS Значення
    FROM 
        _InfoRg17697 AS regSv_ZnachSvoistvOb
)
,planVidHar_SvoistwaOb AS (
    SELECT
        planVidHar_SvoistwaOb._IDRRef AS ID,
        planVidHar_SvoistwaOb._Code AS Code,
        planVidHar_SvoistwaOb._Description AS NameN,
        planVidHar_SvoistwaOb._Marked AS ПоміткаВидалення,
        
        planVidHar_SvoistwaOb._Fld22859RRef AS Призначення
    FROM 
        _Chrc1016 AS planVidHar_SvoistwaOb
)
-- для пропса
,спр_ЗначенияСвойствОбьектов AS ( -- ../spr/спр_ЗначенияСвойствОбьектов.sql
    SELECT
        спр_ЗначенияСвойствОбьектов._IDRRef AS ID_ЗначенияСвойствОбьектов,
        спр_ЗначенияСвойствОбьектов._Code AS Code_ЗначенияСвойствОбьектов,
        спр_ЗначенияСвойствОбьектов._Description AS НазваВластивості_ЗначенияСвойствОбьектов,
        спр_ЗначенияСвойствОбьектов._Marked AS ПоміткаВидалення_ЗначенияСвойствОбьектов,
        спр_ЗначенияСвойствОбьектов._Folder AS Група_ЗначенияСвойствОбьектов
    FROM
        _Reference93 AS спр_ЗначенияСвойствОбьектов
)

-- пропс Viz
,PropsSvoistvaViz_Nomenklatura AS (
    SELECT
        regSv_ZnachSvoistvOb.Обьект AS FK_Номенклатура_Свойства
        ,planVidHar_SvoistwaOb.NameN AS НазваСвойства
        ,спр_ЗначенияСвойствОбьектов.НазваВластивості_ЗначенияСвойствОбьектов AS НазваЗначення

    FROM regSv_ZnachSvoistvOb
        LEFT JOIN 
            planVidHar_SvoistwaOb
            ON 
                regSv_ZnachSvoistvOb.Свойство = planVidHar_SvoistwaOb.ID
        LEFT JOIN 
            спр_ЗначенияСвойствОбьектов
            ON 
                regSv_ZnachSvoistvOb.Значення = спр_ЗначенияСвойствОбьектов.ID_ЗначенияСвойствОбьектов

    WHERE (
        planVidHar_SvoistwaOb.NameN = 'Категорія'
        OR 
            planVidHar_SvoistwaOb.NameN = 'Бренд'
        OR 
            planVidHar_SvoistwaOb.NameN = 'Група Пріоритета'
        OR 
            planVidHar_SvoistwaOb.NameN = 'SKU'
    )
)

-- пропс півот візуалізація 
,PropsPivotViz_Nomenklatura AS (
    SELECT
        pvt.FK_Номенклатура_Свойства,
        Категорія,
        Бренд,
        SKU,
        [Група Пріоритета]
    FROM (
        SELECT
            FK_Номенклатура_Свойства,
            НазваСвойства,
            НазваЗначення
        FROM PropsSvoistvaViz_Nomenklatura
    ) src
    
    PIVOT (
        MIN(НазваЗначення)
        FOR НазваСвойства IN (
            [Категорія],
            [Бренд],
            [SKU],
            [Група Пріоритета]
        )
    ) pvt
)
---------------------------------- Свойства півот ---------------------------------------------


------- Візуалізейшн пропс --------------------------------------------------------------------
-- для пропса
,спр_ВидиНоменклатури AS ( -- ../spr/спр_ВидиНоменклатури.sql
    SELECT
        спр_ВидиНоменклатури._IDRRef AS ID_ВидиНоменклатури
        ,спр_ВидиНоменклатури._Code AS Code_ВидиНоменклатури
        ,спр_ВидиНоменклатури._Description AS Назва_ВидиНоменклатури
        ,спр_ВидиНоменклатури._Marked AS ПоміткаВидалення_ВидиНоменклатури
    FROM _Reference51 AS спр_ВидиНоменклатури
)

-- для пропса
,спр_Проекти AS ( -- ../spr/спр_Проекти.sql
    SELECT
        спр_Проекти._IDRRef AS ID_Проекти
        ,спр_Проекти._Code AS Code_Проекти
        ,спр_Проекти._Description AS Назва_Проекти
        ,спр_Проекти._Marked AS ПоміткаВидалення_Проекти
    FROM _Reference181 AS спр_Проекти

    WHERE 
        спр_Проекти._Marked = 0 -- ПоміткаВидалення
)

-- головний пропс для візуалізації
,PropsViz_Nomenklatura AS ( -- ../props/PropsViz_Nomenklatura.sql
    SELECT
        spr_Nomenklatura.НоменклатураID
        ,spr_Nomenklatura.НоменклатураCode
        ,spr_Nomenklatura.НазваНоменклатури
        ,spr_Nomenklatura.ПоміткаВидаленняНоменклатури
        ,spr_Nomenklatura.ГрупаНоменклатури

        ,спр_ВидиНоменклатури.Назва_ВидиНоменклатури
        ,spr_Nomenklatura.КількістьВУпаковці_Номенклатура
        ,спр_Проекти.Назва_Проекти

        ,PropsPivotViz_Nomenklatura.Категорія
        ,PropsPivotViz_Nomenklatura.Бренд
        ,PropsPivotViz_Nomenklatura.SKU
        ,PropsPivotViz_Nomenklatura.[Група Пріоритета]
        ,CASE 
        WHEN ISNULL(PropsPivotViz_Nomenklatura.Бренд, 'Інше') IN (
            'NATURELLE',
            'Purfix',
            'Biolly',
            'Summer Fresh',
            'Super Baby',
            'Baby Zaya'
        )
        THEN 'Власний Бренд'
        ELSE 'Інше'
    END AS ТипБренду
    FROM spr_Nomenklatura
        LEFT JOIN 
            спр_ВидиНоменклатури 
            ON 
                спр_ВидиНоменклатури.ID_ВидиНоменклатури = spr_Nomenklatura.FK_ВидНоменклатурьі_Номенклатура
        LEFT JOIN 
            спр_Проекти
            ON 
                спр_Проекти.ID_Проекти = spr_Nomenklatura.FK_Проект_КаналЗбуту_Номенклатура
        LEFT JOIN 
            PropsPivotViz_Nomenklatura
            ON 
                PropsPivotViz_Nomenklatura.FK_Номенклатура_Свойства = spr_Nomenklatura.НоменклатураID
)
------- Візуалізейшн пропс --------------------------------------------------------------------


SELECT *
FROM PropsViz_Nomenklatura