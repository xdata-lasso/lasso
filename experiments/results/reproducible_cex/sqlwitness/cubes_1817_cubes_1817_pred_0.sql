-- Schema DDL
CREATE TABLE "member" ("Member_ID" TEXT PRIMARY KEY, "Name" TEXT, "Nationality" TEXT, "Role" TEXT);

CREATE TABLE "performance" ("Performance_ID" REAL PRIMARY KEY, "Date" TEXT, "Host" TEXT, "Location" TEXT, "Attendance" INTEGER);

CREATE TABLE "member_attendance" ("Member_ID" INTEGER, "Performance_ID" INTEGER, "Num_of_Pieces" INTEGER, PRIMARY KEY ("Member_ID", "Performance_ID"), FOREIGN KEY ("Performance_ID") REFERENCES "performance" ("Performance_ID"), FOREIGN KEY ("Member_ID") REFERENCES "member" ("Member_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO performance (performance_id, date, host, location, attendance) VALUES (0.0, 'default2', 'default1', 'default2', NULL), (1.0, 'default1', 'default1', 'default1', 0), (50000.0, 'default1', NULL, 'default1', 1), (100000.0, 'default2', 'default2', 'default1', 0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT HOST FROM performance ORDER BY HOST, performance.performance_id NULLS LAST;

/*
Gold Result:
(None,)
('default1',)
('default1',)
('default2',)
*/

-- Prediction Query
SELECT HOST FROM performance ORDER BY Attendance ASC, performance.performance_id NULLS LAST;

/*
Prediction Result:
('default1',)
('default1',)
('default2',)
(None,)
*/