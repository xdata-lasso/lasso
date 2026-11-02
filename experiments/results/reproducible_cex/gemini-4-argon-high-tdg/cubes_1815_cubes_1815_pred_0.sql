-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (1.0, '2023-01-10', 'Host A', 'Alpha', 100);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (2.0, '2023-02-15', 'Host B', 'Beta', 500);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (3.0, '2023-02-16', 'Host B', 'Beta', 500);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (4.0, '2023-02-17', 'Host B', 'Beta', 500);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (5.0, '2023-03-20', 'Host C', 'Omega', 200);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (6.0, '2023-03-21', 'Host C', 'Omega', 200);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (7.0, '2023-12-30', 'Host Z', 'Gamma', 50);
INSERT INTO performance (Performance_ID, Date, Host, Location, Attendance) VALUES (8.0, '2023-12-31', 'Host Z', 'Gamma', 50);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT * FROM (SELECT * FROM (SELECT attendance, LOCATION, COUNT(*) AS n FROM performance GROUP BY attendance, LOCATION) ORDER BY LOCATION DESC) LIMIT 1);

/*
Gold Result:
('Omega',)
*/

-- Prediction Query
SELECT LOCATION FROM performance GROUP BY LOCATION ORDER BY COUNT(*) DESC, LOCATION NULLS LAST LIMIT 1;

/*
Prediction Result:
('Beta',)
*/