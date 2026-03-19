SELECT * FROM _InfoRg17986
LEFT JOIN _Reference35 AS док_ЗаказПокупателя
    ON _InfoRg17986._Fld17987RRef = док_ЗаказПокупателя._IDRRef
ORDER BY _Period DESC