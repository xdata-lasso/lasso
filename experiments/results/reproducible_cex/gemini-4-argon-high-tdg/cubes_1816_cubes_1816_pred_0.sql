-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (10.0, '2023-05-01', 'Host C', 'Auditorium B', 500);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (2.0, '2023-05-01', 'Host A', 'Auditorium A', 800);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (1.5, '2023-04-10', 'Host D', 'Theater Y', 300);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (1.2, '2023-04-10', 'Host B', 'Theater X', 450);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (5.0, '2023-05-01', 'Host E', 'Auditorium A', 250);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT date, LOCATION FROM performance ORDER BY date, performance.performance_id NULLS LAST;

/*
Gold Result:
('2023-04-10', 'Theater X')
('2023-04-10', 'Theater Y')
('2023-05-01', 'Auditorium A')
('2023-05-01', 'Auditorium A')
('2023-05-01', 'Auditorium B')
*/

-- Prediction Query
SELECT Date, LOCATION FROM performance;

/*
Prediction Result:
('2023-05-01', 'Auditorium B')
('2023-05-01', 'Auditorium A')
('2023-04-10', 'Theater Y')
('2023-04-10', 'Theater X')
('2023-05-01', 'Auditorium A')
*/