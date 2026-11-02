-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'Zugspitze', 2962.0, 1746.0, 'Alps', 'Germany');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'Everest', 8848.0, 8848.0, 'Himalayas', 'Nepal');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (3, 'Aconcagua', 6961.0, 6961.0, 'Andes', 'Argentina');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (4, 'Denali', 6190.0, 6144.0, 'Alaska Range', 'USA');
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (1, 2, 'Tenzing', 'Nepal', '11:30', 100.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (2, 2, 'Hillary', 'NZ', '11:30', 100.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (3, 4, 'Stuck', 'USA', '13:45', 85.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name FROM (SELECT * FROM mountain AS LHS WHERE NOT EXISTS(SELECT 1 FROM climber AS RHS WHERE (LHS.mountain_id = RHS.mountain_id))) ORDER BY name;

/*
Gold Result:
('Aconcagua',)
('Zugspitze',)
*/

-- Prediction Query
SELECT Name FROM mountain WHERE NOT Mountain_ID IN (SELECT Mountain_ID FROM climber);

/*
Prediction Result:
('Zugspitze',)
('Aconcagua',)
*/