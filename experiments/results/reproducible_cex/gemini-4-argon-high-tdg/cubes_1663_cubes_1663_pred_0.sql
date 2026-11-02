-- Schema DDL
CREATE TABLE "railway" ("Railway_ID" INTEGER PRIMARY KEY, "Railway" TEXT, "Builder" TEXT, "Built" TEXT, "Wheels" TEXT, "Location" TEXT, "ObjectNumber" TEXT);

CREATE TABLE "train" ("Train_ID" INTEGER PRIMARY KEY, "Railway_ID" INTEGER, "Train_Num" TEXT, "Name" TEXT, "From" TEXT, "Arrival" TEXT, FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"));

CREATE TABLE "manager" ("Manager_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Country" TEXT, "Working_year_starts" TEXT, "Age" INTEGER, "Level" INTEGER);

CREATE TABLE "railway_manage" ("Railway_ID" INTEGER, "Manager_ID" INTEGER, "From_Year" TEXT, PRIMARY KEY ("Railway_ID", "Manager_ID"), FOREIGN KEY ("Railway_ID") REFERENCES "railway" ("Railway_ID"), FOREIGN KEY ("Manager_ID") REFERENCES "manager" ("Manager_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (1, 'Central Line', 'Baldwin', '1920', '4-6-2', 'London', 'OBJ-01');
INSERT INTO railway (Railway_ID, Railway, Builder, Built, Wheels, Location, ObjectNumber) VALUES (2, 'Northern Line', 'Alco', '1935', '2-8-2', 'Manchester', 'OBJ-02');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (1, 1, 'T-100', 'Express', 'London', '10:00');
INSERT INTO train (Train_ID, Railway_ID, Train_Num, Name, "From", Arrival) VALUES (2, 2, 'T-200', 'Flyer', 'Manchester', '14:30');
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (100, 'Alice', 'Zimbabwe', '2010', 35, 60);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (101, 'Bob', 'Canada', '2005', 45, 55);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (102, 'Charlie', 'Argentina', '2015', 46, 80);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (103, 'David', 'Zimbabwe', '2012', 40, 70);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (1, 'Eve', 'Denmark', '2000', 47, 20);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (2, 'Frank', 'Egypt', '1999', 48, 25);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (3, 'Grace', 'Finland', '1998', 49, 30);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (4, 'Heidi', 'Germany', '1995', 50, 40);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (5, 'Ivan', 'Hungary', '1990', 51, 46);
INSERT INTO manager (Manager_ID, Name, Country, Working_year_starts, Age, Level) VALUES (6, 'Judy', 'Italy', '2018', NULL, 15);
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 100, '2015');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (2, 100, '2016');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (1, 1, '2010');
INSERT INTO railway_manage (Railway_ID, Manager_ID, From_Year) VALUES (2, 4, '2005');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT country FROM manager WHERE (age < 50 AND age <= 46) ORDER BY country;

/*
Gold Result:
('Argentina',)
('Canada',)
('Zimbabwe',)
*/

-- Prediction Query
SELECT Country FROM manager WHERE Age > 50 INTERSECT SELECT Country FROM manager WHERE Age < 46;

/*
Prediction Result:
*/