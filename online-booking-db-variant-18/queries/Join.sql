SELECT
    a.appointment_id AS 'ID записи',
    CONCAT(d.last_name, ' ', d.first_name) AS 'Донор',
    d.blood_group AS 'Группа крови',
    d.rhesus_factor AS 'Резус',
    CONCAT(ms.last_name, ' ', ms.first_name) AS 'Сотрудник',
    a.appointment_datetime AS 'Дата и время',
    a.donation_type AS 'Тип донации',
    a.status AS 'Статус',
    DATEDIFF(a.appointment_datetime, d.last_donation_date) AS 'Дней с последней сдачи'
FROM appointments a
INNER JOIN donors d ON a.donor_id = d.donor_id
LEFT JOIN medical_staff ms ON a.staff_id = ms.staff_id
ORDER BY a.appointment_datetime DESC;
