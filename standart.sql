;WITH 





-- BASE





-- type__name__dependency_dpnd
example AS ( -- .../.../example.sql
    SELECT
        -- example._IDRRef ID__Ссылка__example
        *
        -- FK
        -- imp (important)
        -- own
        -- ,example._Description own__Наименование__example
        -- oth (other)
        -- sys (system)
        -- calc (calculated)
    FROM 
        _Acc23 AS example

    -- WHERE
    --     example._Posted = 1 -- проведений
    --     AND
    --     example._Marked = 0 -- не помічений на видалення
    --     AND
    --     example._Active = 1 -- активний
)





-- BASE





-- TABLEPARTS START





-- ,Tbpt__
-- ParentID__





-- TABLEPARTS END





-- VIEWS START





-- ,док...





-- VIEWS END





-- BaseView Joins 1:1 START





-- ,Join__





-- BaseView Joins 1:1 END





-- PRJCT





-- ,Join__
-- ,Props__
-- ProjectJoin
-- ,Join__





-- PRJCT





-- Projects Vizes





-- ,Viz__





-- Projects Vizes





-- Working Vizes





-- ,working__
SELECT * FROM example





-- Working Vizes