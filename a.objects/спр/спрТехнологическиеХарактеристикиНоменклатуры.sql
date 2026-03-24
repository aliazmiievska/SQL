;WITH 

-----------------------------------------------------------------------------------------------------

spr_TechnolHaraktNomen AS ( -- ../spr/spr_TechnolHaraktNomen.sql
    SELECT
        spr_TechnolHaraktNomen._Fld24298RRef AS FK_Номенклатура,

        spr_TechnolHaraktNomen._IDRRef AS ID,
        spr_TechnolHaraktNomen._Code AS Code,
        spr_TechnolHaraktNomen._Description AS Назва,
        spr_TechnolHaraktNomen._Marked AS ПоміткаВидалення,
        spr_TechnolHaraktNomen._Fld24300 AS Активна
    FROM _Reference24296 AS spr_TechnolHaraktNomen

    WHERE 
        spr_TechnolHaraktNomen._Marked = 0 -- ПоміткаВидалення
        AND 
        spr_TechnolHaraktNomen._Fld24300 = 1 -- Активна
),
--
-----------------------------------------------------------------------------------------------------

spr_TechnolHaraktNomen_SpisokHarakt AS ( -- підфайл
    SELECT
        spr_TechnolHaraktNomen_SpisokHarakt._Reference24296_IDRRef AS FK_Характеристика,

        spr_TechnolHaraktNomen_SpisokHarakt._Fld24304RRef AS СвойствоRref,

        spr_TechnolHaraktNomen_SpisokHarakt._Fld24305_TYPE AS ТипЗначення,
        spr_TechnolHaraktNomen_SpisokHarakt._Fld24305_S AS ЗначенняСимвольне,
        spr_TechnolHaraktNomen_SpisokHarakt._Fld24305_N AS ЗначенняЧислове,
        spr_TechnolHaraktNomen_SpisokHarakt._Fld24305_T AS ЗначенняДата,
        spr_TechnolHaraktNomen_SpisokHarakt._Fld24305_L AS ЗначенняЛогічне,
        spr_TechnolHaraktNomen_SpisokHarakt._Fld24305_RRRef AS ЗначенняRRRef,
        spr_TechnolHaraktNomen_SpisokHarakt._Fld24305_RTRef AS ЗначенняRTRef,

        spr_TechnolHaraktNomen_SpisokHarakt._Fld24306 AS Відхилення



    FROM _Reference24296_VT24302 AS spr_TechnolHaraktNomen_SpisokHarakt
),

-- for PropsOneColumnChar
spr_Nomenklatura AS ( -- ../spr/spr_Nomenklatura.sql
    SELECT
        spr_Nomenklatura._IDRRef AS ID,
        spr_Nomenklatura._Code AS Code,
        spr_Nomenklatura._Description AS НазваНоменклатури,
        spr_Nomenklatura._Marked AS ПоміткаВидалення,
        spr_Nomenklatura._Folder AS Група
    FROM _Reference149 AS spr_Nomenklatura
),

-- for PropsOneColumnChar
spr_ZnachSvoistvOb AS ( -- ../spr/spr_ZnachSvoistvOb.sql
    SELECT
        spr_ZnachSvoistvOb._IDRRef AS ID,
        spr_ZnachSvoistvOb._Code AS Code,
        spr_ZnachSvoistvOb._Description AS НазваСвойства,
        spr_ZnachSvoistvOb._Marked AS ПоміткаВидалення,
        spr_ZnachSvoistvOb._Folder AS Група
    FROM
        _Reference93 AS spr_ZnachSvoistvOb
),

-- for PropsOneColumnChar
planVidHar_TechSvoistvaOb AS ( -- ../spr/planVidHar_TechSvoistvaOb.sql
    SELECT
        planVidHar_TechSvoistvaOb._IDRRef AS ID,
        planVidHar_TechSvoistvaOb._Code AS Code,
        planVidHar_TechSvoistvaOb._Description AS NameN,
        planVidHar_TechSvoistvaOb._Marked AS ПоміткаВидалення,

        planVidHar_TechSvoistvaOb._Fld24417RRef AS ТипВластивості,
        planVidHar_TechSvoistvaOb._Type AS Тип,
        planVidHar_TechSvoistvaOb._Fld24398RRef AS ВаріантРозрахунку,

        planVidHar_TechSvoistvaOb._Fld24399_TYPE AS ТипДанихДляРозрахунку,
        planVidHar_TechSvoistvaOb._Fld24399_RRRef AS РозрахунокПосилання,
        planVidHar_TechSvoistvaOb._Fld24399_N AS РозрахунокЧисло
    FROM _Chrc24297 AS planVidHar_TechSvoistvaOb
),

-- всі свойства в колонці, тип чар
PropsOneColumnChar AS ( -- пропс

    SELECT
        spr_TechnolHaraktNomen.FK_Номенклатура AS FK_Номенклатура_Характеристики,

        spr_TechnolHaraktNomen.Code AS КодХарактеристики,
        spr_TechnolHaraktNomen.Назва AS НазваХарактеристики,
        planVidHar_TechSvoistvaOb.NameN AS НазваСвойства,
        spr_TechnolHaraktNomen_SpisokHarakt.Відхилення AS Відхилення,

        CASE -- все конвертується, бо кейс приймає тільки один тип даних (в півоті будуть нормальні типи)
            WHEN spr_TechnolHaraktNomen_SpisokHarakt.ТипЗначення = 0x1 
                THEN CONVERT(NVARCHAR(100), spr_TechnolHaraktNomen_SpisokHarakt.ЗначенняДата, 120)

            WHEN spr_TechnolHaraktNomen_SpisokHarakt.ТипЗначення = 0x2 
                THEN 
                    CASE 
                        WHEN spr_TechnolHaraktNomen_SpisokHarakt.ЗначенняЛогічне = 1 
                            THEN N'Так'
                        ELSE N'Ні'
                    END

            WHEN spr_TechnolHaraktNomen_SpisokHarakt.ТипЗначення = 0x3 
                THEN CAST(spr_TechnolHaraktNomen_SpisokHarakt.ЗначенняЧислове AS NVARCHAR(100))

            WHEN spr_TechnolHaraktNomen_SpisokHarakt.ТипЗначення = 0x5                -- знаходила вручну
                THEN CAST(spr_TechnolHaraktNomen_SpisokHarakt.ЗначенняСимвольне AS NVARCHAR(100))

            WHEN spr_TechnolHaraktNomen_SpisokHarakt.ЗначенняRTRef = 0x00000095
                THEN spr_Nomenklatura.НазваНоменклатури

            WHEN spr_TechnolHaraktNomen_SpisokHarakt.ЗначенняRTRef = 0x0000005D
                THEN spr_ZnachSvoistvOb.НазваСвойства

            ELSE NULL
                
        END AS Значення

    FROM spr_TechnolHaraktNomen
        LEFT JOIN spr_TechnolHaraktNomen_SpisokHarakt
            ON spr_TechnolHaraktNomen.ID = spr_TechnolHaraktNomen_SpisokHarakt.FK_Характеристика
        LEFT JOIN spr_Nomenklatura
            ON spr_TechnolHaraktNomen_SpisokHarakt.ЗначенняRRRef = spr_Nomenklatura.ID
        LEFT JOIN spr_ZnachSvoistvOb
            ON spr_TechnolHaraktNomen_SpisokHarakt.ЗначенняRRRef = spr_ZnachSvoistvOb.ID
        LEFT JOIN spr_ZnachSvoistvOb AS spr_ZnachSvoistvOb_base
            ON spr_TechnolHaraktNomen_SpisokHarakt.СвойствоRref = spr_ZnachSvoistvOb_base.ID
        LEFT JOIN planVidHar_TechSvoistvaOb
            ON spr_TechnolHaraktNomen_SpisokHarakt.СвойствоRref = planVidHar_TechSvoistvaOb.ID
)

-- відображення, можна змінити
SELECT * FROM PropsOneColumnChar
ORDER BY КодХарактеристики