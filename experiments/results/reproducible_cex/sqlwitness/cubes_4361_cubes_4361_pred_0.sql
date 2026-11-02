-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO performance (performance_id, date, host, location, attendance) VALUES (1.0, 'default1', 'default1', 'default1', 2), (0.0, 'default1', NULL, NULL, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM (SELECT LHS.performance_id AS performance_id, LHS.date AS date, LHS.host AS HOST, LHS.location AS LOCATION, LHS.attendance AS attendance, LHS.maxattendance AS maxattendance, RHS.performance_id AS performance_id_other, RHS.host AS host_other, RHS.location AS location_other, RHS.maxattendance AS maxattendance_other FROM (SELECT performance_id, date, HOST, LOCATION, attendance, MAX(attendance) OVER () AS maxattendance FROM performance) AS LHS INNER JOIN (SELECT performance_id, date, HOST, LOCATION, attendance, MAX(attendance) OVER () AS maxattendance FROM performance) AS RHS ON (LHS.maxattendance = RHS.attendance AND LHS.date = RHS.date)) ORDER BY date;

/*
Gold Result:
('default1',)
('default1',)
*/

-- Prediction Query
SELECT Date FROM performance ORDER BY Attendance DESC, performance.performance_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('default1',)
*/