;WITH 

enum_ВидиСмен AS ( -- ../spr/enum_ВидиСмен.sql
    SELECT
        enum_ВидиСмен._IDRRef AS ID_ВидиСмен
        ,CASE enum_ВидиСмен._EnumOrder 
        WHEN 1 THEN 'Нічна'
        WHEN 0 THEN 'Денна'
        ELSE 'Невідомо' END AS Порядок_ВидиСмен
    FROM _Enum23693 AS enum_ВидиСмен
)

SELECT *
FROM enum_ВидиСмен