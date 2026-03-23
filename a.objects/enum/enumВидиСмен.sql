;WITH 

enumВидиСмен AS ( -- ../spr/enumВидиСмен.sql
    SELECT
        enumВидиСмен._IDRRef AS ID_ВидиСмен
        ,CASE enumВидиСмен._EnumOrder 
        WHEN 1 THEN 'Нічна'
        WHEN 0 THEN 'Денна'
        ELSE 'Невідомо' END AS Порядок_ВидиСмен
    FROM _Enum23693 AS enumВидиСмен
)

SELECT *
FROM enumВидиСмен