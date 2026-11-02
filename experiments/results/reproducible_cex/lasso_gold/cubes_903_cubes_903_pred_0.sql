-- Schema DDL
CREATE TABLE "flight" ("flno" REAL(4, 0) PRIMARY KEY, "aid" REAL(9, 0), "origin" TEXT(20), "destination" TEXT(20), "distance" REAL(6, 0), "departure_date" DATE, "arrival_date" DATE, "price" REAL(7, 2), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"));

CREATE TABLE "aircraft" ("aid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "distance" REAL(6, 0));

CREATE TABLE "employee" ("eid" REAL(9, 0) PRIMARY KEY, "name" TEXT(30), "salary" REAL(10, 2));

CREATE TABLE "certificate" ("eid" REAL(9, 0), "aid" REAL(9, 0), PRIMARY KEY ("eid", "aid"), FOREIGN KEY ("aid") REFERENCES "aircraft" ("aid"), FOREIGN KEY ("eid") REFERENCES "employee" ("eid"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1001.5, 'Allison Hill', 1014.5);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1002.5, 'Noah Rhodes', 1021.5);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1003.5, 'Angie Henderson', 1028.5);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1004.5, 'Daniel Wagner', 1035.5);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1005.5, 'Cristian Santos', 1042.5);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1006.5, 'Connie Lawrence', 1049.5);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1007.5, 'Abigail Shaffer', 1056.5);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1008.5, 'Gina Moore', 1063.5);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1009.5, 'Gabrielle Davis', 1070.5);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1010.5, 'Ryan Munoz', 1077.5);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1011.5, 'Monica Herrera', 1084.5);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1012.5, 'Jamie Arnold', 1091.5);
INSERT INTO "employee" ("eid", "name", "salary") VALUES (1013.5, 'Lisa Hensley', 1098.5);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM (SELECT * FROM (SELECT eid, name, salary, AVG(salary) OVER () AS meansalary FROM employee) ORDER BY salary DESC) LIMIT 13);

/*
Gold Result:
('Lisa Hensley',)
('Jamie Arnold',)
('Monica Herrera',)
('Ryan Munoz',)
('Gabrielle Davis',)
('Gina Moore',)
('Abigail Shaffer',)
('Connie Lawrence',)
('Cristian Santos',)
('Daniel Wagner',)
('Angie Henderson',)
('Noah Rhodes',)
('Allison Hill',)
*/

-- Prediction Query
SELECT name FROM Employee WHERE salary > (SELECT AVG(salary) FROM Employee);

/*
Prediction Result:
('Gina Moore',)
('Gabrielle Davis',)
('Ryan Munoz',)
('Monica Herrera',)
('Jamie Arnold',)
('Lisa Hensley',)
*/