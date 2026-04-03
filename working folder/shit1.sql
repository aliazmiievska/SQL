;WITH

ІєрархіяСтатей AS (
    SELECT
        Корінь._IDRRef ID__Ссылка__спрСтатті
        ,Корінь._ParentIDRRef FK__БатьківськаСтаття__спрСтатті
        ,Корінь._Code own__Код__спрСтатті
        ,Корінь._Description own__Назва__спрСтатті
        ,Корінь._Folder own__ЦеГрупа__спрСтатті
        ,Корінь._Fld23154
        ,Корінь._Fld23173
        ,Корінь._Fld23176RRef

        ,CAST(Корінь._Description AS NVARCHAR(MAX)) own__ПовнийШлях__спрСтатті
        ,CAST(Корінь._Description AS NVARCHAR(255)) lvl1__Назва__спрСтатті
        ,CAST(NULL AS NVARCHAR(255)) lvl2__Назва__спрСтатті
        ,CAST(NULL AS NVARCHAR(255)) lvl3__Назва__спрСтатті
        ,CAST(NULL AS NVARCHAR(255)) lvl4__Назва__спрСтатті

        ,1 lvl__РівеньІєрархії__спрСтатті
    FROM
        _Reference23089 AS Корінь
    WHERE
        Корінь._ParentIDRRef = 0x00000000000000000000000000000000
        OR Корінь._ParentIDRRef IS NULL

    UNION ALL

    SELECT
        ДочірняСтаття._IDRRef
        ,ДочірняСтаття._ParentIDRRef
        ,ДочірняСтаття._Code
        ,ДочірняСтаття._Description
        ,ДочірняСтаття._Folder
        ,ДочірняСтаття._Fld23154
        ,ДочірняСтаття._Fld23173
        ,ДочірняСтаття._Fld23176RRef

        ,CAST(
            ІєрархіяСтатей.own__ПовнийШлях__спрСтатті
            + N' / '
            + ДочірняСтаття._Description
            AS NVARCHAR(MAX)
        ) own__ПовнийШлях__спрСтатті

        ,ІєрархіяСтатей.lvl1__Назва__спрСтатті

        ,CASE
            WHEN ІєрархіяСтатей.lvl__РівеньІєрархії__спрСтатті = 1
                THEN ДочірняСтаття._Description
            ELSE ІєрархіяСтатей.lvl2__Назва__спрСтатті
        END lvl2__Назва__спрСтатті

        ,CASE
            WHEN ІєрархіяСтатей.lvl__РівеньІєрархії__спрСтатті = 2
                THEN ДочірняСтаття._Description
            ELSE ІєрархіяСтатей.lvl3__Назва__спрСтатті
        END lvl3__Назва__спрСтатті

        ,CASE
            WHEN ІєрархіяСтатей.lvl__РівеньІєрархії__спрСтатті = 3
                THEN ДочірняСтаття._Description
            ELSE ІєрархіяСтатей.lvl4__Назва__спрСтатті
        END lvl4__Назва__спрСтатті

        ,ІєрархіяСтатей.lvl__РівеньІєрархії__спрСтатті + 1
    FROM
        _Reference23089 AS ДочірняСтаття
        INNER JOIN ІєрархіяСтатей
            ON ІєрархіяСтатей.ID__Ссылка__спрСтатті
                = ДочірняСтаття._ParentIDRRef
)

SELECT
    *
FROM
    ІєрархіяСтатей
ORDER BY
    own__ПовнийШлях__спрСтатті