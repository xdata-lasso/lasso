-- Schema DDL
CREATE TABLE "department" ("Department_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Creation" TEXT, "Ranking" INTEGER, "Budget_in_Billions" REAL, "Num_Employees" REAL);

CREATE TABLE "head" ("head_ID" INTEGER PRIMARY KEY, "name" TEXT, "born_state" TEXT, "age" REAL);

CREATE TABLE "management" ("department_ID" INTEGER, "head_ID" INTEGER, "temporary_acting" TEXT, PRIMARY KEY ("department_ID", "head_ID"), FOREIGN KEY ("head_ID") REFERENCES "head" ("head_ID"), FOREIGN KEY ("department_ID") REFERENCES "department" ("Department_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (1, 'State', '1990', 1, 10.5, 500.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (2, 'Treasury', '1990', 2, 20.0, 1200.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (3, 'Defense', '1990', 3, 50.0, 3000.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (4, 'Justice', '2000', 4, 15.0, 800.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (5, 'Interior', '2000', 5, 12.0, 600.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (6, 'Agriculture', '2000', 6, 18.0, 900.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (7, 'Commerce', '2000', 7, 14.0, 700.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (8, 'Labor', '1980', 8, 11.0, 400.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (9, 'Health', '1980', 9, 30.0, 1500.0);
INSERT INTO department (Department_ID, Name, Creation, Ranking, Budget_in_Billions, Num_Employees) VALUES (10, 'Energy', '1970', 10, 25.0, 1000.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (101, 'Alice Smith', 'CA', 55.0);
INSERT INTO head (head_ID, name, born_state, age) VALUES (102, 'Bob Jones', 'NY', 60.0);
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (10, 101, 'No');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (10, 102, 'Yes');
INSERT INTO management (department_ID, head_ID, temporary_acting) VALUES (1, 101, 'No');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT creation FROM (SELECT creation, COUNT(*) AS n FROM department GROUP BY creation) WHERE (n <> 1) ORDER BY creation;

/*
Gold Result:
('1980',)
('1990',)
('2000',)
*/

-- Prediction Query
SELECT creation FROM department GROUP BY creation ORDER BY COUNT(*) DESC, creation NULLS LAST LIMIT 1;

/*
Prediction Result:
('2000',)
*/