-- Schema DDL
CREATE TABLE "entrepreneur" ("Entrepreneur_ID" INTEGER PRIMARY KEY, "People_ID" INTEGER, "Company" TEXT, "Money_Requested" REAL, "Investor" TEXT, FOREIGN KEY ("People_ID") REFERENCES "people" ("People_ID"));

CREATE TABLE "people" ("People_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Weight" REAL, "Date_of_Birth" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 4
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (1, 'Alicia', 168.0, 60.0, '1991-04-10');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (2, 'Al', 172.0, 68.0, '1989-08-22');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (3, '', 155.0, 50.0, '2000-02-29');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (4, 'Alice', 162.0, 54.0, '1993-09-14');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (5, NULL, 177.0, 73.0, '1987-11-05');
INSERT INTO people (People_ID, Name, Height, Weight, Date_of_Birth) VALUES (6, 'Al', 181.0, 85.0, '1982-01-19');
INSERT INTO entrepreneur (Entrepreneur_ID, People_ID, Company, Money_Requested, Investor) VALUES (1, 4, 'Wonderland', 0.0, '');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM people ORDER BY name, people.people_id NULLS LAST;

/*
Gold Result:
(None,)
('',)
('Al',)
('Al',)
('Alice',)
('Alicia',)
*/

-- Prediction Query
SELECT Name FROM People ORDER BY Weight ASC, People.people_id NULLS LAST;

/*
Prediction Result:
('',)
('Alice',)
('Alicia',)
('Al',)
(None,)
('Al',)
*/