-- Schema DDL
CREATE TABLE "Person" ("name" TEXT(20) PRIMARY KEY, "age" INTEGER, "city" TEXT, "gender" TEXT, "job" TEXT);

CREATE TABLE "PersonFriend" ("friend" TEXT(20), "name" TEXT(20), "year" INTEGER, FOREIGN KEY ("friend") REFERENCES "Person" ("name"), FOREIGN KEY ("name") REFERENCES "Person" ("name"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO Person (name, age, city, gender, job) VALUES ('F_A', 50, 'New York', 'F', 'Doctor');
INSERT INTO Person (name, age, city, gender, job) VALUES ('F_B', 50, 'Boston', 'M', 'Lawyer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('F_C', 50, 'Chicago', 'F', 'Artist');
INSERT INTO Person (name, age, city, gender, job) VALUES ('F_D', 50, 'Seattle', 'M', 'Pilot');
INSERT INTO Person (name, age, city, gender, job) VALUES ('F_E', 50, 'Austin', 'F', 'Chef');
INSERT INTO Person (name, age, city, gender, job) VALUES ('F_F', 50, 'Denver', 'M', 'Writer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('F_G', 50, 'Miami', 'F', 'Nurse');
INSERT INTO Person (name, age, city, gender, job) VALUES ('P_25', 25, 'New York', 'M', 'Engineer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('P_30', 30, 'Boston', 'F', 'Teacher');
INSERT INTO Person (name, age, city, gender, job) VALUES ('P_31', 31, 'Chicago', 'M', 'Designer');
INSERT INTO Person (name, age, city, gender, job) VALUES ('P_35', 35, 'Seattle', 'F', 'Manager');
INSERT INTO Person (name, age, city, gender, job) VALUES ('P_40', 40, 'Austin', 'M', 'Analyst');
INSERT INTO Person (name, age, city, gender, job) VALUES ('P_45', 45, 'Denver', 'F', 'Director');
INSERT INTO Person (name, age, city, gender, job) VALUES ('P_NULL', NULL, 'Miami', 'M', 'Student');
INSERT INTO PersonFriend (friend, name, year) VALUES ('F_A', 'P_25', 2018);
INSERT INTO PersonFriend (friend, name, year) VALUES ('F_B', 'P_30', 2019);
INSERT INTO PersonFriend (friend, name, year) VALUES ('F_C', 'P_31', 2020);
INSERT INTO PersonFriend (friend, name, year) VALUES ('F_D', 'P_35', 2021);
INSERT INTO PersonFriend (friend, name, year) VALUES ('F_E', 'P_40', 2022);
INSERT INTO PersonFriend (friend, name, year) VALUES ('F_F', 'P_45', 2023);
INSERT INTO PersonFriend (friend, name, year) VALUES ('F_G', 'P_NULL', 2024);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT friend AS name FROM (SELECT LHS.name AS name, LHS.age AS age, LHS.city AS city, LHS.gender AS gender, LHS.job AS job, RHS.friend AS friend, RHS.year AS YEAR FROM (SELECT * FROM person WHERE (age < 40 AND age <= 30)) AS LHS INNER JOIN personfriend AS RHS ON (LHS.name = RHS.name)) ORDER BY name;

/*
Gold Result:
('F_A',)
('F_B',)
*/

-- Prediction Query
SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age > 40) EXCEPT SELECT T1.name FROM Person AS T1 JOIN PersonFriend AS T2 ON T1.name = T2.name WHERE T2.friend IN (SELECT name FROM Person WHERE age < 30);

/*
Prediction Result:
('P_25',)
('P_30',)
('P_31',)
('P_35',)
('P_40',)
('P_45',)
('P_NULL',)
*/