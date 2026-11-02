-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 2
INSERT INTO member (Member_ID, Name, Nationality, Role) VALUES ('1', 'Clara', 'Germany', 'Cellist');
INSERT INTO member (Member_ID, Name, Nationality, Role) VALUES ('2', 'David', 'France', 'Conductor');
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (1.0, '2023-12-01', 'Philharmonie', 'Berlin', 1200);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (2.0, '2023-06-15', 'Opera Garnier', 'Paris', 800);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (3.0, '2023-01-10', 'Musikverein', 'Vienna', 1200);
INSERT INTO member_attendance (Member_ID, Performance_ID, Num_of_Pieces) VALUES (1, 1, 4);
INSERT INTO member_attendance (Member_ID, Performance_ID, Num_of_Pieces) VALUES (2, 1, 4);
INSERT INTO member_attendance (Member_ID, Performance_ID, Num_of_Pieces) VALUES (1, 3, 2);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date FROM (SELECT LHS.performance_id AS performance_id, LHS.date AS date, LHS.host AS HOST, LHS.location AS LOCATION, LHS.attendance AS attendance, LHS.maxattendance AS maxattendance, RHS.performance_id AS performance_id_other, RHS.host AS host_other, RHS.location AS location_other, RHS.maxattendance AS maxattendance_other FROM (SELECT performance_id, date, HOST, LOCATION, attendance, MAX(attendance) OVER () AS maxattendance FROM performance) AS LHS INNER JOIN (SELECT performance_id, date, HOST, LOCATION, attendance, MAX(attendance) OVER () AS maxattendance FROM performance) AS RHS ON (LHS.maxattendance = RHS.attendance AND LHS.date = RHS.date)) ORDER BY date;

/*
Gold Result:
('2023-01-10',)
('2023-12-01',)
*/

-- Prediction Query
SELECT Date FROM performance ORDER BY Attendance DESC, performance.performance_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('2023-12-01',)
*/