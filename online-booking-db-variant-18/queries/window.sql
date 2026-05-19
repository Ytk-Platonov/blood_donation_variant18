SELECT
    CONCAT(last_name, ' ', first_name) AS 'Донор',
    blood_group AS 'Группа крови',
    rhesus_factor AS 'Резус',
    last_donation_date AS 'Дата последней сдачи',
    DATEDIFF(CURDATE(), last_donation_date) AS 'Прошло дней',
    DATE_ADD(last_donation_date, INTERVAL 60 DAY) AS 'Следующая разрешённая дата',
    DATEDIFF(DATE_ADD(last_donation_date, INTERVAL 60 DAY), CURDATE()) AS 'Осталось дней до сдачи',
    ROW_NUMBER() OVER (ORDER BY DATEDIFF(CURDATE(), last_donation_date) DESC) AS 'Приоритет'
FROM donors
WHERE last_donation_date IS NOT NULL
  AND DATEDIFF(CURDATE(), last_donation_date) BETWEEN 50 AND 59
ORDER BY DATEDIFF(CURDATE(), last_donation_date) DESC;
