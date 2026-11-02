-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'K2', 5000.0, 2500.0, 'Karakoram', 'Pakistan');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'Mont Blanc', 4000.0, 3500.0, 'Alps', 'France');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (3, 'Everest', 8000.0, 8000.0, 'Himalayas', 'Nepal');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (4, 'Matterhorn', 7000.0, 1000.0, 'Alps', 'Switzerland');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (5, 'Lhotse', 3000.0, 600.0, 'Himalayas', 'Nepal');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (6, 'Kanchenjunga', 7000.0, 3900.0, 'Himalayas', 'India');
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (1, 1, 'John Doe', 'USA', '12:30', 100.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (2, 2, 'Jane Smith', 'UK', '08:15', 85.5);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (3, 2, 'Pierre Dupont', 'France', '07:45', 92.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT RANGE FROM mountain ORDER BY RANGE;

/*
Gold Result:
('Alps',)
('Himalayas',)
('Karakoram',)
*/

-- Prediction Query
SELECT DISTINCT RANGE FROM mountain ORDER BY Prominence DESC, RANGE NULLS LAST LIMIT 3;

/*
Prediction Result:
('Himalayas',)
('Alps',)
('Karakoram',)
*/