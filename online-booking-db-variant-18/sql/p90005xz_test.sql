-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Май 19 2026 г., 10:00
-- Версия сервера: 8.0.34-26-beget-1-1
-- Версия PHP: 5.6.40

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `p90005xz_test`
--

-- --------------------------------------------------------

--
-- Структура таблицы `appointments`
--
-- Создание: Май 19 2026 г., 06:22
-- Последнее обновление: Май 19 2026 г., 06:22
--

DROP TABLE IF EXISTS `appointments`;
CREATE TABLE `appointments` (
  `appointment_id` int NOT NULL,
  `donor_id` int NOT NULL,
  `staff_id` int DEFAULT NULL,
  `appointment_datetime` datetime NOT NULL,
  `donation_type` enum('цельная кровь','плазма','тромбоциты','эритроциты') NOT NULL DEFAULT 'цельная кровь',
  `status` enum('запланировано','принят','выполнено','отменено','неявка') DEFAULT 'запланировано',
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `appointments`
--

INSERT INTO `appointments` (`appointment_id`, `donor_id`, `staff_id`, `appointment_datetime`, `donation_type`, `status`, `notes`, `created_at`) VALUES
(1, 1, 1, '2026-05-22 09:00:00', 'цельная кровь', 'выполнено', NULL, '2026-05-19 06:22:37'),
(2, 2, 1, '2026-05-22 10:00:00', 'плазма', 'запланировано', NULL, '2026-05-19 06:22:37'),
(3, 3, 2, '2026-05-23 09:30:00', 'цельная кровь', 'запланировано', NULL, '2026-05-19 06:22:37'),
(4, 5, 1, '2026-05-23 11:00:00', 'тромбоциты', 'запланировано', NULL, '2026-05-19 06:22:37'),
(5, 6, 3, '2026-05-25 14:00:00', 'цельная кровь', 'запланировано', NULL, '2026-05-19 06:22:37'),
(6, 7, 1, '2026-05-26 10:30:00', 'плазма', 'запланировано', NULL, '2026-05-19 06:22:37');

-- --------------------------------------------------------

--
-- Структура таблицы `blood_tests`
--
-- Создание: Май 19 2026 г., 06:22
-- Последнее обновление: Май 19 2026 г., 06:22
--

DROP TABLE IF EXISTS `blood_tests`;
CREATE TABLE `blood_tests` (
  `test_id` int NOT NULL,
  `appointment_id` int NOT NULL,
  `hemoglobin` decimal(4,1) DEFAULT NULL,
  `hematocrit` decimal(4,1) DEFAULT NULL,
  `blood_group_confirmed` enum('I','II','III','IV') DEFAULT NULL,
  `rhesus_confirmed` enum('+','-') DEFAULT NULL,
  `hiv_test` tinyint(1) DEFAULT NULL,
  `hepatitis_b_test` tinyint(1) DEFAULT NULL,
  `hepatitis_c_test` tinyint(1) DEFAULT NULL,
  `syphilis_test` tinyint(1) DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT '0',
  `test_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `blood_tests`
--

INSERT INTO `blood_tests` (`test_id`, `appointment_id`, `hemoglobin`, `hematocrit`, `blood_group_confirmed`, `rhesus_confirmed`, `hiv_test`, `hepatitis_b_test`, `hepatitis_c_test`, `syphilis_test`, `is_approved`, `test_date`) VALUES
(1, 1, '145.0', '42.0', 'II', '+', 0, 0, 0, 0, 1, '2026-05-22');

-- --------------------------------------------------------

--
-- Структура таблицы `contraindications`
--
-- Создание: Май 19 2026 г., 06:22
-- Последнее обновление: Май 19 2026 г., 06:22
--

DROP TABLE IF EXISTS `contraindications`;
CREATE TABLE `contraindications` (
  `contra_id` int NOT NULL,
  `donor_id` int NOT NULL,
  `contra_type` varchar(100) NOT NULL,
  `description` text,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_permanent` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `contraindications`
--

INSERT INTO `contraindications` (`contra_id`, `donor_id`, `contra_type`, `description`, `start_date`, `end_date`, `is_permanent`) VALUES
(1, 3, 'временный', 'Приём антибиотиков', '2026-05-10', '2026-05-24', 0),
(2, 4, 'временный', 'Беременность', '2025-12-01', '2026-09-01', 0),
(3, 7, 'постоянный', 'Хроническое заболевание печени', '2020-01-01', NULL, 1);

-- --------------------------------------------------------

--
-- Структура таблицы `donors`
--
-- Создание: Май 19 2026 г., 06:22
-- Последнее обновление: Май 19 2026 г., 06:22
--

DROP TABLE IF EXISTS `donors`;
CREATE TABLE `donors` (
  `donor_id` int NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `patronymic` varchar(50) DEFAULT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `birth_date` date NOT NULL,
  `blood_group` enum('I','II','III','IV') NOT NULL,
  `rhesus_factor` enum('+','-') NOT NULL,
  `last_donation_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `donors`
--

INSERT INTO `donors` (`donor_id`, `last_name`, `first_name`, `patronymic`, `phone`, `email`, `birth_date`, `blood_group`, `rhesus_factor`, `last_donation_date`, `is_active`, `created_at`) VALUES
(1, 'Иванов', 'Сергей', 'Петрович', '+79161111111', 'ivanov@mail.ru', '1990-03-15', 'II', '+', '2026-03-20', 1, '2026-05-19 06:22:37'),
(2, 'Петрова', 'Анна', 'Игоревна', '+79162222222', 'petrova@mail.ru', '1988-07-22', 'I', '-', '2026-04-10', 1, '2026-05-19 06:22:37'),
(3, 'Сидоров', 'Алексей', 'Владимирович', '+79163333333', 'sidorov@mail.ru', '1995-11-08', 'III', '+', '2026-02-15', 1, '2026-05-19 06:22:37'),
(4, 'Козлова', 'Мария', 'Андреевна', '+79164444444', 'kozlova@mail.ru', '1992-01-30', 'IV', '-', NULL, 1, '2026-05-19 06:22:37'),
(5, 'Морозов', 'Дмитрий', 'Николаевич', '+79165555555', 'morozov@mail.ru', '1985-09-12', 'II', '-', '2026-05-01', 1, '2026-05-19 06:22:37'),
(6, 'Волкова', 'Елена', 'Сергеевна', '+79166666666', 'volkova@mail.ru', '1998-06-18', 'I', '+', '2026-04-25', 1, '2026-05-19 06:22:37'),
(7, 'Соколов', 'Павел', 'Александрович', '+79167777777', 'sokolov@mail.ru', '1983-12-05', 'III', '-', '2026-03-28', 1, '2026-05-19 06:22:37'),
(8, 'Тестов', 'Тест', NULL, '+79000000000', 'test@mail.ru', '0000-00-00', 'I', '+', NULL, 1, '2026-05-19 06:57:03');

-- --------------------------------------------------------

--
-- Структура таблицы `donor_certificates`
--
-- Создание: Май 19 2026 г., 06:22
-- Последнее обновление: Май 19 2026 г., 06:22
--

DROP TABLE IF EXISTS `donor_certificates`;
CREATE TABLE `donor_certificates` (
  `certificate_id` int NOT NULL,
  `donor_id` int NOT NULL,
  `certificate_number` varchar(50) NOT NULL,
  `issue_date` date NOT NULL,
  `valid_until` date NOT NULL,
  `certificate_type` enum('почётный донор','плазма','цельная кровь','тромбоциты') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `donor_certificates`
--

INSERT INTO `donor_certificates` (`certificate_id`, `donor_id`, `certificate_number`, `issue_date`, `valid_until`, `certificate_type`) VALUES
(1, 1, 'PD-2024-0001', '2024-01-15', '2027-01-15', 'почётный донор'),
(2, 2, 'CK-2024-0015', '2024-03-20', '2025-03-20', 'цельная кровь'),
(3, 3, 'PL-2023-0089', '2023-06-10', '2026-06-10', 'плазма'),
(4, 5, 'CK-2025-0042', '2025-02-28', '2026-02-28', 'цельная кровь'),
(5, 6, 'TR-2024-0077', '2024-11-05', '2025-11-05', 'тромбоциты');

-- --------------------------------------------------------

--
-- Дублирующая структура для представления `eligible_donors`
-- (См. Ниже фактическое представление)
--
DROP VIEW IF EXISTS `eligible_donors`;
CREATE TABLE `eligible_donors` (
`donor_id` int
,`full_name` varchar(152)
,`blood_group` enum('I','II','III','IV')
,`rhesus_factor` enum('+','-')
,`phone` varchar(20)
,`email` varchar(100)
,`last_donation_date` date
,`days_since_last_donation` int
,`is_eligible` int
);

-- --------------------------------------------------------

--
-- Структура таблицы `medical_staff`
--
-- Создание: Май 19 2026 г., 06:22
-- Последнее обновление: Май 19 2026 г., 06:22
--

DROP TABLE IF EXISTS `medical_staff`;
CREATE TABLE `medical_staff` (
  `staff_id` int NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `patronymic` varchar(50) DEFAULT NULL,
  `specialization` enum('врач-трансфузиолог','медсестра','лаборант','регистратор') NOT NULL,
  `phone` varchar(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `is_available` tinyint(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Дамп данных таблицы `medical_staff`
--

INSERT INTO `medical_staff` (`staff_id`, `last_name`, `first_name`, `patronymic`, `specialization`, `phone`, `email`, `is_available`) VALUES
(1, 'Кузнецова', 'Ольга', 'Викторовна', 'врач-трансфузиолог', '+79031111111', 'kuznetsova@clinic.ru', 1),
(2, 'Смирнов', 'Андрей', 'Петрович', 'медсестра', '+79032222222', 'smirnov@clinic.ru', 1),
(3, 'Васильева', 'Татьяна', 'Игоревна', 'лаборант', '+79033333333', 'vasileva@clinic.ru', 1),
(4, 'Николаев', 'Денис', 'Романович', 'регистратор', '+79034444444', 'nikolaev@clinic.ru', 1);

-- --------------------------------------------------------

--
-- Структура для представления `eligible_donors`
--
DROP TABLE IF EXISTS `eligible_donors`;
-- Создание: Май 19 2026 г., 06:22
--

CREATE ALGORITHM=UNDEFINED DEFINER=`p90005xz_test`@`localhost` SQL SECURITY DEFINER VIEW `eligible_donors`  AS SELECT `donors`.`donor_id` AS `donor_id`, concat(`donors`.`last_name`,' ',`donors`.`first_name`,' ',coalesce(`donors`.`patronymic`,'')) AS `full_name`, `donors`.`blood_group` AS `blood_group`, `donors`.`rhesus_factor` AS `rhesus_factor`, `donors`.`phone` AS `phone`, `donors`.`email` AS `email`, `donors`.`last_donation_date` AS `last_donation_date`, (to_days(curdate()) - to_days(`donors`.`last_donation_date`)) AS `days_since_last_donation`, (case when (`donors`.`last_donation_date` is null) then true when ((to_days(curdate()) - to_days(`donors`.`last_donation_date`)) >= 60) then true else false end) AS `is_eligible` FROM `donors` WHERE ((`donors`.`is_active` = true) AND `donors`.`donor_id` in (select `contraindications`.`donor_id` from `contraindications` where ((`contraindications`.`is_permanent` = true) OR (`contraindications`.`end_date` is null) OR (`contraindications`.`end_date` >= curdate()))) is false)) ;

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`appointment_id`),
  ADD UNIQUE KEY `unique_donor_datetime` (`donor_id`,`appointment_datetime`),
  ADD UNIQUE KEY `unique_staff_datetime` (`staff_id`,`appointment_datetime`),
  ADD KEY `idx_appointments_datetime` (`appointment_datetime`),
  ADD KEY `idx_appointments_status` (`status`),
  ADD KEY `idx_appointments_donor` (`donor_id`);

--
-- Индексы таблицы `blood_tests`
--
ALTER TABLE `blood_tests`
  ADD PRIMARY KEY (`test_id`),
  ADD UNIQUE KEY `appointment_id` (`appointment_id`);

--
-- Индексы таблицы `contraindications`
--
ALTER TABLE `contraindications`
  ADD PRIMARY KEY (`contra_id`),
  ADD KEY `idx_contraindications_donor` (`donor_id`);

--
-- Индексы таблицы `donors`
--
ALTER TABLE `donors`
  ADD PRIMARY KEY (`donor_id`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_donors_blood` (`blood_group`,`rhesus_factor`),
  ADD KEY `idx_donors_last_date` (`last_donation_date`);

--
-- Индексы таблицы `donor_certificates`
--
ALTER TABLE `donor_certificates`
  ADD PRIMARY KEY (`certificate_id`),
  ADD UNIQUE KEY `certificate_number` (`certificate_number`),
  ADD KEY `idx_certificates_donor` (`donor_id`);

--
-- Индексы таблицы `medical_staff`
--
ALTER TABLE `medical_staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `appointments`
--
ALTER TABLE `appointments`
  MODIFY `appointment_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT для таблицы `blood_tests`
--
ALTER TABLE `blood_tests`
  MODIFY `test_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `contraindications`
--
ALTER TABLE `contraindications`
  MODIFY `contra_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `donors`
--
ALTER TABLE `donors`
  MODIFY `donor_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT для таблицы `donor_certificates`
--
ALTER TABLE `donor_certificates`
  MODIFY `certificate_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `medical_staff`
--
ALTER TABLE `medical_staff`
  MODIFY `staff_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`donor_id`) REFERENCES `donors` (`donor_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `medical_staff` (`staff_id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `blood_tests`
--
ALTER TABLE `blood_tests`
  ADD CONSTRAINT `blood_tests_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`appointment_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `contraindications`
--
ALTER TABLE `contraindications`
  ADD CONSTRAINT `contraindications_ibfk_1` FOREIGN KEY (`donor_id`) REFERENCES `donors` (`donor_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `donor_certificates`
--
ALTER TABLE `donor_certificates`
  ADD CONSTRAINT `donor_certificates_ibfk_1` FOREIGN KEY (`donor_id`) REFERENCES `donors` (`donor_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
