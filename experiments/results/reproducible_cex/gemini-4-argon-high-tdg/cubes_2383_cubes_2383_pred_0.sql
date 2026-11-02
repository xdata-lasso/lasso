-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'Matterhorn', 4478.0, 1042.0, 'Alps', 'Switzerland');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'Mont Blanc', 4808.0, 4695.0, 'Alps', 'France');
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (1, 1, 'Zara', 'USA', '12:30', 85.5);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (2, 2, 'Beat', 'Switzerland', '10:15', 92.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (3, 1, 'Adam', 'Austria', '14:00', 78.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (4, 2, 'Clara', 'United Kingdom', '11:45', 88.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "climber" WHERE ("country" <> 'Switzerland') ORDER BY name, climber.climber_id NULLS LAST;

/*
Gold Result:
('Adam',)
('Clara',)
('Zara',)
*/

-- Prediction Query
SELECT Name FROM climber WHERE Country <> 'Switzerland';

/*
Prediction Result:
('Zara',)
('Adam',)
('Clara',)
*/