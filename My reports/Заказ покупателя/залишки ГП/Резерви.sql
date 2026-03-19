SELECT 
    DATEADD(year, -2000, itog._Period) AS Дата,
    nom._Code AS НоменклатураКод,
    nom._Description AS НоменклатураНазва,
    SUM(
        IIF(itog._RecordKind = 0, -itog._Fld24507, itog._Fld24507) -- тут неправильно, бо 0 це плюс (Андрій виправив мірою в pbi)
    ) AS Сума
FROM _AccumRg24504 AS itog
JOIN _Reference149 AS nom 
    ON nom._IDRRef = itog._Fld24505RRef
WHERE itog._Active = 1
GROUP BY 
    DATEADD(year, -2000, itog._Period),
    nom._Code,
    nom._Description
HAVING 
    SUM(
        IIF(itog._RecordKind = 0, -itog._Fld24507, itog._Fld24507)
    ) <> 0
ORDER BY 
    DATEADD(year, -2000, itog._Period),
    nom._Code;