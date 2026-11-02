-- Schema DDL
CREATE TABLE "singer" ("Singer_ID" INTEGER PRIMARY KEY, "Name" TEXT, "Birth_Year" REAL, "Net_Worth_Millions" REAL, "Citizenship" TEXT);

CREATE TABLE "song" ("Song_ID" INTEGER PRIMARY KEY, "Singer_ID" INTEGER, "Title" TEXT, "Sales" REAL, "Highest_Position" REAL, FOREIGN KEY ("Singer_ID") REFERENCES "singer" ("Singer_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (1035, 'Juan Calderon', 1036.5, 1037.5, 'present');
INSERT INTO "singer" ("singer_id", "name", "birth_year", "net_worth_millions", "citizenship") VALUES (1038, 'Darren Roberts', 1037.5, 1038.5, 'available');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT "name" FROM "singer" WHERE ("citizenship" <> 'France') ORDER BY name, singer.singer_id NULLS LAST;

/*
Gold Result:
('Darren Roberts',)
('Juan Calderon',)
*/

-- Prediction Query
SELECT Name FROM singer WHERE Citizenship <> 'France';

/*
Prediction Result:
('Juan Calderon',)
('Darren Roberts',)
*/