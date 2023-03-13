CREATE TABLE altschool.user_info (
  `ID` int(6) UNSIGNED NOT NULL,
  `First_name` varchar(30) DEFAULT NULL,
  `Last_name` varchar(30) DEFAULT NULL,
  `Username` varchar(30) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE altschool.user_info
  ADD PRIMARY KEY (`ID`);

CREATE TABLE altschool.courses (
  `id` int(6) NOT NULL,
  `user_id` int(6) NOT NULL,
  `course_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE altschool.courses
  ADD PRIMARY KEY (`id`);

ALTER TABLE altschool.courses
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

ALTER TABLE altschool.user_info
  MODIFY `ID` int(6) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;