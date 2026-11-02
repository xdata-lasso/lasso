-- Schema DDL
CREATE TABLE "mountain" ("Mountain_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "climber" ("Climber_ID" INTEGER PRIMARY KEY, "Mountain_ID" INTEGER, "Name" TEXT, "Country" TEXT, "Time" TEXT, "Points" REAL, FOREIGN KEY ("Mountain_ID") REFERENCES "mountain" ("Mountain_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Missing DISTINCT (duplicate Range values: 'Andes', 'Himalayas').
-- 2. Missing ORDER BY or DESC ordering (inserted out of alphabetical order).
-- 3. Ordering by other columns (e.g., Mountain_ID, Name, Height, Prominence, Country all yield non-alphabetical Range order).
-- 4. Unnecessary INNER JOIN with 'climber' (Mountain_ID 3 has no climbers).
-- 5. Incorrectly selecting Name or Country instead of Range.
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (1, 'Mount Everest', 8848.86, 8848.86, 'Himalayas', 'Nepal');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (2, 'Aconcagua', 6960.8, 6960.8, 'Andes', 'Argentina');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (3, 'Mont Blanc', 4808.7, 4695.0, 'Alps', 'France');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (4, 'K2', 8611.0, 4017.0, 'Karakoram', 'Pakistan');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (5, 'Kangchenjunga', 8586.0, 3922.0, 'Himalayas', 'India');
INSERT INTO mountain (Mountain_ID, Name, Height, Prominence, Range, Country) VALUES (6, 'Ojos del Salado', 6893.0, 3688.0, 'Andes', 'Chile');
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (1, 1, 'Tenzing Norgay', 'Nepal', '11:30', 100.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (2, 1, 'Edmund Hillary', 'New Zealand', '11:30', 100.0);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (3, 2, 'Matthias Zurbriggen', 'Switzerland', '14:20', 85.5);
INSERT INTO climber (Climber_ID, Mountain_ID, Name, Country, Time, Points) VALUES (4, 4, 'Achille Compagnoni', 'Italy', '18:00', 95.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT RANGE FROM mountain ORDER BY RANGE;

/*
Gold Result:
('Alps',)
('Andes',)
('Himalayas',)
('Karakoram',)
*/

-- Prediction Query
SELECT DISTINCT RANGE FROM mountain ORDER BY Prominence DESC, RANGE NULLS LAST LIMIT 3;

/*
Prediction Result:
('Himalayas',)
('Andes',)
('Alps',)
*/