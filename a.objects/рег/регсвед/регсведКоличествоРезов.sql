;WITH 

регСвед_КоличествоРезов AS ( -- ../рег/регСвед/регСвед_КоличествоРезов.sql
    SELECT
        _RecorderRRef AS ID_КоличествоРезов
        ,SUM(_Fld25445) AS PropsSum_КоличествоРезов
    FROM 
        _InfoRg25440 AS регСвед_КоличествоРезов

    GROUP BY _RecorderRRef
)

SELECT *
FROM регСвед_КоличествоРезов