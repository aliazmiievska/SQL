;WITH 

enumВидиСмен AS ( -- ../spr/enumВидиСмен.sql
    SELECT
        enumВидиСмен._IDRRef ID__Ссылка__enumВидиСмен
        ,CASE enumВидиСмен._EnumOrder 
            WHEN 1 THEN 'Нічна'
            WHEN 0 THEN 'Денна'
            ELSE 'Невідомо' 
        END calc__Порядок__enumВидиСмен
    FROM _Enum23693 AS enumВидиСмен
)

SELECT *
FROM enumВидиСмен