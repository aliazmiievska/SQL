SELECT
    DATEFROMPARTS(
        own__Рік__КалендарРікМісяцьДо40.own__Рік__КалендарРікМісяцьДо40,
        own__Місяць__КалендарРікМісяцьДо40.own__Місяць__КалендарРікМісяцьДо40,
        1
    ) own__ДатаРікМісяць__КалендарРікМісяцьДо40
FROM (
    SELECT 
        2025 + systemTable.number own__Рік__КалендарРікМісяцьДо40
    FROM 
        master..spt_values systemTable
    WHERE 
        systemTable.type = 'P'
        AND 
        systemTable.number <= 15
) own__Рік__КалендарРікМісяцьДо40
CROSS JOIN (
    SELECT 
        systemTable.number + 1 own__Місяць__КалендарРікМісяцьДо40
    FROM 
        master..spt_values systemTable
    WHERE 
        systemTable.type = 'P'
        AND 
        systemTable.number < 12
) own__Місяць__КалендарРікМісяцьДо40