-- Schema DDL
CREATE TABLE "festival_detail" ("Festival_ID" INTEGER PRIMARY KEY, "Festival_Name" TEXT, "Chair_Name" TEXT, "Location" TEXT, "Year" INTEGER, "Num_of_Audience" INTEGER);

CREATE TABLE "artwork" ("Artwork_ID" INTEGER PRIMARY KEY, "Type" TEXT, "Name" TEXT);

CREATE TABLE "nomination" ("Artwork_ID" INTEGER, "Festival_ID" INTEGER, "Result" TEXT, PRIMARY KEY ("Artwork_ID", "Festival_ID"), FOREIGN KEY ("Festival_ID") REFERENCES "festival_detail" ("Festival_ID"), FOREIGN KEY ("Artwork_ID") REFERENCES "artwork" ("Artwork_ID"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1017, 'Sonya Johnston', 'Kevin Mills', '80132 Tucker Forest
Barreraburgh, MS 00783', 1033, 1037);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1018, 'David Tran', 'Christina Moran', '71822 Arroyo Expressway
Allisonchester, IL 71187', 1032.0, 1038.0);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1019, 'Melanie Wilson', 'Christina Moran', '465 Lam Mission
East Jeffreymouth, AK 77611', 1043.0, 1051.0);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1020, 'Nicole Mack', 'Christina Moran', '10310 Jones Freeway
Elizabethborough, ND 17843', 1054.0, 1064.0);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1029, 'Janice Carlson', 'Kevin Mills', '52880 Burns Creek
Natashaport, IA 08093', 1021, 1025);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1030, 'John Russell', 'Christina Moran', 'Unit 4746 Box 8723
DPO AA 29035', 1044.0, 1050.0);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1031, 'Matthew Gomez', 'Christina Moran', 'Unit 9805 Box 0097
DPO AP 70116', 1055.0, 1063.0);
INSERT INTO "festival_detail" ("festival_id", "festival_name", "chair_name", "location", "year", "num_of_audience") VALUES (1032, 'Scott Brown', 'Christina Moran', '19136 Shelly Port
New Brooke, RI 11246', 1066.0, 1076.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT LOCATION FROM (SELECT * FROM (SELECT * FROM festival_detail ORDER BY chair_name DESC, festival_detail.festival_id NULLS LAST) LIMIT 1);

/*
Gold Result:
('80132 Tucker Forest\nBarreraburgh, MS 00783',)
*/

-- Prediction Query
SELECT LOCATION FROM festival_detail ORDER BY Num_of_Audience DESC, festival_detail.festival_id NULLS LAST LIMIT 1;

/*
Prediction Result:
('19136 Shelly Port\nNew Brooke, RI 11246',)
*/