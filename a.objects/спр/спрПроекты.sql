;WITH 

спр_Проекти AS ( -- ../spr/спр_Проекти.sql
    SELECT
        спр_Проекти._IDRRef AS ID_Проекти
        ,спр_Проекти._Code AS Code_Проекти
        ,спр_Проекти._Description AS Назва_Проекти
        ,спр_Проекти._Marked AS ПоміткаВидалення_Проекти
    FROM _Reference181 AS спр_Проекти

    WHERE 
        спр_Проекти._Marked = 0 -- ПоміткаВидалення
)

SELECT *
FROM спр_Проекти