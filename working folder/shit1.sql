SELECT name
FROM sys.tables
WHERE name LIKE '_Document%'
AND NOT name LIKE '%_VT%'
ORDER BY name