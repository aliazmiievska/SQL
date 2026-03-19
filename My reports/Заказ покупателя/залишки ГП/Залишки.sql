SELECT 

    DATEADD(year, -2000, регНак_ТоварыНаСкладах._Period) AS Дата,
    спр_Номенклатура._Code AS НоменклатураКод,
    спр_Номенклатура._Description AS НоменклатураНазва,
    спр_Склады._Description AS Склад,
    SUM(
        IIF(регНак_ТоварыНаСкладах._RecordKind = 0, -регНак_ТоварыНаСкладах._Fld22379, регНак_ТоварыНаСкладах._Fld22379)
    ) AS Сума

FROM 
    _AccumRg22373 AS регНак_ТоварыНаСкладах
    JOIN 
        _Reference149 AS спр_Номенклатура 
        ON 
            спр_Номенклатура._IDRRef = регНак_ТоварыНаСкладах._Fld22375RRef
    JOIN   
        _Reference199 AS спр_Склады 
        ON 
            спр_Склады._IDRRef = регНак_ТоварыНаСкладах._Fld22374RRef

WHERE  
    регНак_ТоварыНаСкладах._Active = 1

GROUP BY 
    DATEADD(year, -2000, регНак_ТоварыНаСкладах._Period),
    спр_Номенклатура._Code,
    спр_Номенклатура._Description,
    спр_Склады._Description

HAVING 
    SUM(
        IIF(регНак_ТоварыНаСкладах._RecordKind = 0, -регНак_ТоварыНаСкладах._Fld22379, регНак_ТоварыНаСкладах._Fld22379)
    ) <> 0
    
ORDER BY 
    DATEADD(year, -2000, регНак_ТоварыНаСкладах._Period),
    спр_Номенклатура._Code,
    спр_Склады._Description;
