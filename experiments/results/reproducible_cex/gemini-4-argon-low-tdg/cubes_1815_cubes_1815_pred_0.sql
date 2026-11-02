-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (1.0, '2023-01-01', 'Host A', 'Alpha', 500);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (2.0, '2023-01-02', 'Host A', 'Alpha', 500);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (3.0, '2023-01-03', 'Host A', 'Alpha', 500);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (4.0, '2023-01-04', 'Host B', 'Mega', 100);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (5.0, '2023-01-05', 'Host B', 'Mega', 100);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (6.0, '2023-01-06', 'Host C', 'Zeta', 10);
INSERT INTO member (Member_ID, Name, Nationality, Role) VALUES ('1', 'John Doe', 'USA', 'Violin');
INSERT INTO member_attendance (Member_ID, Performance_ID, Num_of_Pieces) VALUES (1, 1.0, 5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT * FROM (SELECT * FROM (SELECT attendance, LOCATION, COUNT(*) AS n FROM performance GROUP BY attendance, LOCATION) ORDER BY LOCATION DESC) LIMIT 1);

/*
Gold Result:
('Zeta',)
*/

-- Prediction Query
SELECT LOCATION FROM performance GROUP BY LOCATION ORDER BY COUNT(*) DESC, LOCATION NULLS LAST LIMIT 1;

/*
Prediction Result:
('Alpha',)
*/