SELECT 
    DATEADD(YEAR, -2000, regProd._Period) AS Дата,
    YEAR(regProd._Period) - 2000 AS Рік,
    MONTH(regProd._Period) AS Місяць,
    DAY(regProd._Period) AS День,
    kontr._Code AS Контрагент,
    nom._Code AS Номенклатура,
    man._Code AS Менеджер,
    regProd._Fld23791 AS Кількість,
    regProd._Fld24461 AS Сума,
    ref25107._Code AS ВидПланування_Код,
    ref25107._Description AS ВидПланування_Назва

FROM _AccumRg23786 AS regProd

JOIN _Reference120 AS kontr 
    ON kontr._IDRRef = regProd._Fld23788RRef
JOIN _Reference149 AS nom 
    ON nom._IDRRef = regProd._Fld23789RRef
JOIN _Reference174 AS man 
    ON man._IDRRef = regProd._Fld23790RRef
LEFT JOIN _Reference25107 AS ref25107  
    ON ref25107._IDRRef = regProd._Fld25111RRef;
