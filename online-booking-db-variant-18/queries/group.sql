SELECT
    d.blood_group AS 'Группа крови',
    d.rhesus_factor AS 'Резус',
    COUNT(a.appointment_id) AS 'Всего записей',
    SUM(CASE WHEN a.status = 'запланировано' THEN 1 ELSE 0 END) AS 'Запланировано',
    SUM(CASE WHEN a.status = 'выполнено' THEN 1 ELSE 0 END) AS 'Выполнено'
FROM donors d
LEFT JOIN appointments a ON d.donor_id = a.donor_id
GROUP BY d.blood_group, d.rhesus_factor
HAVING SUM(CASE WHEN a.status = 'запланировано' THEN 1 ELSE 0 END) > 0
ORDER BY SUM(CASE WHEN a.status = 'запланировано' THEN 1 ELSE 0 END) DESC;
