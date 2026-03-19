;WITH 

planVidHar_TechSvoistvaOb AS (
    SELECT
        planVidHar_TechSvoistvaOb._IDRRef AS ID,
        planVidHar_TechSvoistvaOb._Code AS Code,
        planVidHar_TechSvoistvaOb._Description AS NameN,
        planVidHar_TechSvoistvaOb._Marked AS ПоміткаВидалення,

        planVidHar_TechSvoistvaOb._Fld24417RRef AS ТипВластивості,
        planVidHar_TechSvoistvaOb._Type AS Тип,
        planVidHar_TechSvoistvaOb._Fld24398RRef AS ВаріантРозрахунку,

        planVidHar_TechSvoistvaOb._Fld24399_TYPE AS ТипДанихДляРозрахунку,
        planVidHar_TechSvoistvaOb._Fld24399_RRRef AS РозрахунокПосилання,
        planVidHar_TechSvoistvaOb._Fld24399_N AS РозрахунокЧисло
    FROM _Chrc24297 AS planVidHar_TechSvoistvaOb
)

SELECT *
FROM planVidHar_TechSvoistvaOb