-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 04, 2026 at 12:33 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tutor_platform`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_teacher_average_rating` (`teacher_identifier` INT) RETURNS DECIMAL(3,2) DETERMINISTIC READS SQL DATA BEGIN
  DECLARE average_rating_value DECIMAL(3,2);

  SELECT ROUND(AVG(reviews.rating), 2)
  INTO average_rating_value
  FROM reviews
  JOIN lessons
    ON lessons.lesson_id = reviews.lesson_id
  WHERE lessons.teacher_id = teacher_identifier;

  RETURN average_rating_value;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `document_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `verification_status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `uploaded_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `documents`
--

INSERT INTO `documents` (`document_id`, `teacher_id`, `file_path`, `verification_status`, `uploaded_at`) VALUES
(1, 4, '/uploads/docs/tarmo_diploma.pdf', 'approved', '2026-03-01 09:10:00'),
(2, 5, '/uploads/docs/liis_certificate.pdf', 'pending', '2026-03-02 11:00:00');

-- --------------------------------------------------------

--
-- Stand-in structure for view `future_lessons_schedule`
-- (See below for the actual view)
--
CREATE TABLE `future_lessons_schedule` (
`lesson_id` int(11)
,`lesson_datetime` datetime
,`duration_minutes` int(11)
,`status` enum('planned','confirmed','cancelled','completed')
,`price` decimal(8,2)
,`subject_name` varchar(100)
,`teacher_name` varchar(41)
,`student_name` varchar(41)
);

-- --------------------------------------------------------

--
-- Table structure for table `lessons`
--

CREATE TABLE `lessons` (
  `lesson_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `lesson_datetime` datetime NOT NULL,
  `duration_minutes` int(11) NOT NULL,
  `status` enum('planned','confirmed','cancelled','completed') NOT NULL DEFAULT 'planned',
  `price` decimal(8,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `lessons`
--

INSERT INTO `lessons` (`lesson_id`, `teacher_id`, `student_id`, `subject_id`, `lesson_datetime`, `duration_minutes`, `status`, `price`) VALUES
(1, 4, 7, 1, '2026-03-10 16:00:00', 60, 'planned', 18.00),
(2, 4, 8, 1, '2026-03-12 17:30:00', 60, 'confirmed', 18.00),
(3, 5, 7, 2, '2026-03-11 18:00:00', 90, 'completed', 24.00),
(4, 6, 9, 3, '2026-03-13 15:00:00', 60, 'cancelled', 20.00),
(5, 6, 8, 1, '2026-03-14 12:00:00', 60, 'completed', 20.00);

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `log_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` varchar(100) NOT NULL,
  `entity_type` varchar(100) DEFAULT NULL,
  `timestamp` datetime NOT NULL DEFAULT current_timestamp(),
  `ip_address` varchar(45) DEFAULT NULL,
  `details` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `logs`
--

INSERT INTO `logs` (`log_id`, `user_id`, `action`, `entity_type`, `timestamp`, `ip_address`, `details`) VALUES
(1, 7, 'create_lesson', 'lessons', '2026-03-01 12:00:00', '192.168.0.10', 'Student created lesson booking'),
(2, 4, 'confirm_lesson', 'lessons', '2026-03-05 14:00:00', '192.168.0.11', 'Teacher confirmed lesson_id=2'),
(3, 7, 'create_review', 'reviews', '2026-03-11 20:00:00', '192.168.0.10', 'Student left review for lesson_id=3');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `payment_date` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('pending','paid','refunded','failed') NOT NULL DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `lesson_id`, `amount`, `payment_date`, `status`) VALUES
(1, 2, 18.00, '2026-03-12 10:00:00', 'paid'),
(2, 3, 24.00, '2026-03-11 12:00:00', 'paid'),
(3, 5, 20.00, '2026-03-14 10:30:00', 'paid');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `lesson_id`, `rating`, `comment`, `created_at`) VALUES
(1, 3, 5, 'Väga selge selgitus ja hea tempo!', '2026-03-11 20:00:00'),
(2, 5, 4, 'Hea tund, aga natuke kiire.', '2026-03-14 13:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `role_type`
--

CREATE TABLE `role_type` (
  `role_id` int(11) NOT NULL,
  `role_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `role_type`
--

INSERT INTO `role_type` (`role_id`, `role_name`) VALUES
(5, 'Administraator'),
(2, 'Eraõpetaja'),
(4, 'Klienditugi'),
(3, 'Moderaator'),
(1, 'Õpilane');

-- --------------------------------------------------------

--
-- Stand-in structure for view `student_lessons_history`
-- (See below for the actual view)
--
CREATE TABLE `student_lessons_history` (
`lesson_id` int(11)
,`lesson_datetime` datetime
,`duration_minutes` int(11)
,`status` enum('planned','confirmed','cancelled','completed')
,`price` decimal(8,2)
,`subject_name` varchar(100)
,`student_id` int(11)
,`student_name` varchar(41)
,`teacher_id` int(11)
,`teacher_name` varchar(41)
);

-- --------------------------------------------------------

--
-- Table structure for table `student_profile`
--

CREATE TABLE `student_profile` (
  `student_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `student_profile`
--

INSERT INTO `student_profile` (`student_id`) VALUES
(7),
(8),
(9);

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject_name`, `description`) VALUES
(1, 'Matemaatika', 'Gümnaasium, eksam, algebrad ja geomeetria'),
(2, 'Inglise keel', 'Suhtlus, sõnavara, grammatika'),
(3, 'Füüsika', 'Mehaanika, elekter, optika');

-- --------------------------------------------------------

--
-- Stand-in structure for view `teachers_with_rating`
-- (See below for the actual view)
--
CREATE TABLE `teachers_with_rating` (
`teacher_id` int(11)
,`first_name` varchar(20)
,`last_name` varchar(20)
,`email` varchar(100)
,`price_per_hour` decimal(8,2)
,`experience_years` int(11)
,`average_rating` decimal(13,2)
,`review_count` bigint(21)
);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_profile`
--

CREATE TABLE `teacher_profile` (
  `teacher_id` int(11) NOT NULL,
  `bio` text DEFAULT NULL,
  `price_per_hour` decimal(8,2) NOT NULL,
  `experience_years` int(11) NOT NULL DEFAULT 0,
  `rating` decimal(3,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_profile`
--

INSERT INTO `teacher_profile` (`teacher_id`, `bio`, `price_per_hour`, `experience_years`, `rating`) VALUES
(4, 'Matemaatika ja eksami ettevalmistus.', 18.00, 4, NULL),
(5, 'Inglise keel: suhtlus ja grammatika.', 16.00, 2, NULL),
(6, 'Füüsika: põhiteemad ja ülesanded.', 20.00, 5, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `teacher_subjects`
--

CREATE TABLE `teacher_subjects` (
  `teacher_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teacher_subjects`
--

INSERT INTO `teacher_subjects` (`teacher_id`, `subject_id`) VALUES
(4, 1),
(5, 2),
(6, 1),
(6, 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `role_id` int(11) NOT NULL,
  `first_name` varchar(20) DEFAULT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `status` enum('active','blocked') NOT NULL DEFAULT 'active',
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `role_id`, `first_name`, `last_name`, `email`, `password_hash`, `phone`, `status`, `created_at`) VALUES
(1, 5, 'Admin', 'Kask', 'admin@demo.ee', 'hash_admin_123', '+3725000001', 'active', '2026-03-04 13:23:53'),
(2, 3, 'Maria', 'Moderaator', 'moderator@demo.ee', 'hash_moder_123', '+3725000002', 'active', '2026-03-04 13:23:53'),
(3, 4, 'Karl', 'Tugi', 'support@demo.ee', 'hash_support_123', '+3725000003', 'active', '2026-03-04 13:23:53'),
(4, 2, 'Tarmo', 'Õpetaja', 'tarmo.teacher@demo.ee', 'hash_teacher_001', '+3725111111', 'active', '2026-03-04 13:23:53'),
(5, 2, 'Liis', 'Õpetaja', 'liis.teacher@demo.ee', 'hash_teacher_002', '+3725222222', 'active', '2026-03-04 13:23:53'),
(6, 2, 'Andrei', 'Õpetaja', 'andrei.teacher@demo.ee', 'hash_teacher_003', '+3725333333', 'active', '2026-03-04 13:23:53'),
(7, 1, 'Marko', 'Õpilane', 'marko.student@demo.ee', 'hash_student_001', '+3725444444', 'active', '2026-03-04 13:23:53'),
(8, 1, 'Kati', 'Õpilane', 'kati.student@demo.ee', 'hash_student_002', '+3725555555', 'active', '2026-03-04 13:23:53'),
(9, 1, 'Sergei', 'Õpilane', 'sergei.student@demo.ee', 'hash_student_003', '+3725666666', 'active', '2026-03-04 13:23:53');

-- --------------------------------------------------------

--
-- Structure for view `future_lessons_schedule`
--
DROP TABLE IF EXISTS `future_lessons_schedule`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `future_lessons_schedule`  AS SELECT `lessons`.`lesson_id` AS `lesson_id`, `lessons`.`lesson_datetime` AS `lesson_datetime`, `lessons`.`duration_minutes` AS `duration_minutes`, `lessons`.`status` AS `status`, `lessons`.`price` AS `price`, `subjects`.`subject_name` AS `subject_name`, concat(`teacher_user`.`first_name`,' ',`teacher_user`.`last_name`) AS `teacher_name`, concat(`student_user`.`first_name`,' ',`student_user`.`last_name`) AS `student_name` FROM (((`lessons` join `subjects` on(`subjects`.`subject_id` = `lessons`.`subject_id`)) join `users` `teacher_user` on(`teacher_user`.`user_id` = `lessons`.`teacher_id`)) join `users` `student_user` on(`student_user`.`user_id` = `lessons`.`student_id`)) WHERE `lessons`.`lesson_datetime` >= current_timestamp() AND `lessons`.`status` in ('planned','confirmed') ;

-- --------------------------------------------------------

--
-- Structure for view `student_lessons_history`
--
DROP TABLE IF EXISTS `student_lessons_history`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `student_lessons_history`  AS SELECT `lessons`.`lesson_id` AS `lesson_id`, `lessons`.`lesson_datetime` AS `lesson_datetime`, `lessons`.`duration_minutes` AS `duration_minutes`, `lessons`.`status` AS `status`, `lessons`.`price` AS `price`, `subjects`.`subject_name` AS `subject_name`, `lessons`.`student_id` AS `student_id`, concat(`student_user`.`first_name`,' ',`student_user`.`last_name`) AS `student_name`, `lessons`.`teacher_id` AS `teacher_id`, concat(`teacher_user`.`first_name`,' ',`teacher_user`.`last_name`) AS `teacher_name` FROM (((`lessons` join `subjects` on(`subjects`.`subject_id` = `lessons`.`subject_id`)) join `users` `teacher_user` on(`teacher_user`.`user_id` = `lessons`.`teacher_id`)) join `users` `student_user` on(`student_user`.`user_id` = `lessons`.`student_id`)) ;

-- --------------------------------------------------------

--
-- Structure for view `teachers_with_rating`
--
DROP TABLE IF EXISTS `teachers_with_rating`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `teachers_with_rating`  AS SELECT `teacher_profile`.`teacher_id` AS `teacher_id`, `users`.`first_name` AS `first_name`, `users`.`last_name` AS `last_name`, `users`.`email` AS `email`, `teacher_profile`.`price_per_hour` AS `price_per_hour`, `teacher_profile`.`experience_years` AS `experience_years`, round(avg(`reviews`.`rating`),2) AS `average_rating`, count(`reviews`.`review_id`) AS `review_count` FROM (((`teacher_profile` join `users` on(`users`.`user_id` = `teacher_profile`.`teacher_id`)) left join `lessons` on(`lessons`.`teacher_id` = `teacher_profile`.`teacher_id`)) left join `reviews` on(`reviews`.`lesson_id` = `lessons`.`lesson_id`)) GROUP BY `teacher_profile`.`teacher_id`, `users`.`first_name`, `users`.`last_name`, `users`.`email`, `teacher_profile`.`price_per_hour`, `teacher_profile`.`experience_years` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`document_id`),
  ADD KEY `fk_documents_teacher` (`teacher_id`);

--
-- Indexes for table `lessons`
--
ALTER TABLE `lessons`
  ADD PRIMARY KEY (`lesson_id`),
  ADD KEY `fk_lessons_subject` (`subject_id`),
  ADD KEY `idx_lessons_teacher_time` (`teacher_id`,`lesson_datetime`),
  ADD KEY `idx_lessons_student_time` (`student_id`,`lesson_datetime`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `fk_logs_user` (`user_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `fk_payments_lesson` (`lesson_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD UNIQUE KEY `lesson_id` (`lesson_id`);

--
-- Indexes for table `role_type`
--
ALTER TABLE `role_type`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`);

--
-- Indexes for table `student_profile`
--
ALTER TABLE `student_profile`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`),
  ADD UNIQUE KEY `subject_name` (`subject_name`);

--
-- Indexes for table `teacher_profile`
--
ALTER TABLE `teacher_profile`
  ADD PRIMARY KEY (`teacher_id`);

--
-- Indexes for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD PRIMARY KEY (`teacher_id`,`subject_id`),
  ADD KEY `fk_ts_subject` (`subject_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_users_role` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `document_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `lessons`
--
ALTER TABLE `lessons`
  MODIFY `lesson_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `review_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `role_type`
--
ALTER TABLE `role_type`
  MODIFY `role_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `subjects`
--
ALTER TABLE `subjects`
  MODIFY `subject_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `fk_documents_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher_profile` (`teacher_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `lessons`
--
ALTER TABLE `lessons`
  ADD CONSTRAINT `fk_lessons_student` FOREIGN KEY (`student_id`) REFERENCES `student_profile` (`student_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_lessons_subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_lessons_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher_profile` (`teacher_id`) ON UPDATE CASCADE;

--
-- Constraints for table `logs`
--
ALTER TABLE `logs`
  ADD CONSTRAINT `fk_logs_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `fk_payments_lesson` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`lesson_id`) ON UPDATE CASCADE;

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `fk_reviews_lesson` FOREIGN KEY (`lesson_id`) REFERENCES `lessons` (`lesson_id`) ON UPDATE CASCADE;

--
-- Constraints for table `student_profile`
--
ALTER TABLE `student_profile`
  ADD CONSTRAINT `fk_student_user` FOREIGN KEY (`student_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teacher_profile`
--
ALTER TABLE `teacher_profile`
  ADD CONSTRAINT `fk_teacher_user` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `teacher_subjects`
--
ALTER TABLE `teacher_subjects`
  ADD CONSTRAINT `fk_ts_subject` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_ts_teacher` FOREIGN KEY (`teacher_id`) REFERENCES `teacher_profile` (`teacher_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_users_role` FOREIGN KEY (`role_id`) REFERENCES `role_type` (`role_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
