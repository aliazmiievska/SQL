;WITH 

спрСмена AS ( -- ../spr/спрСмена.sql
    SELECT
        спрСмена._IDRRef AS PK__Ссылка__спрСмена
        ,спрСмена._Code AS imp__Код__спрСмена
        ,спрСмена._Description AS imp__Наименование__спрСмена
        ,спрСмена._Marked AS sys__ПомечеткаНаУдаление__спрСмена
    FROM 
        _Reference200 AS спрСмена

    WHERE 
        спрСмена._Marked = 0 -- не помічений на видалення
)

SELECT *
FROM спрСмена