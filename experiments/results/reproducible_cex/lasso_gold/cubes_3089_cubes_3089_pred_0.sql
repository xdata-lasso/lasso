-- Schema DDL
CREATE TABLE "mountain" ("id" INTEGER PRIMARY KEY, "name" TEXT, "Height" REAL, "Prominence" REAL, "Range" TEXT, "Country" TEXT);

CREATE TABLE "camera_lens" ("id" INTEGER PRIMARY KEY, "brand" TEXT, "name" TEXT, "focal_length_mm" REAL, "max_aperture" REAL);

CREATE TABLE "photos" ("id" INTEGER PRIMARY KEY, "mountain_id" INTEGER, "camera_lens_id" INTEGER, "color" TEXT, "name" TEXT, FOREIGN KEY ("mountain_id") REFERENCES "mountain" ("id"), FOREIGN KEY ("camera_lens_id") REFERENCES "camera_lens" ("id"));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1001, 'Allison Hill', 1014.5, 1027.5, 'participant', 'Bolivia');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1002, 'Noah Rhodes', 1021.5, 1036.5, 'dark', 'Hong Kong');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1003, 'Angie Henderson', 1028.5, 1045.5, 'sea', 'Fiji');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1004, 'Daniel Wagner', 1035.5, 1054.5, 'available', 'Korea');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1005, 'Cristian Santos', 1042.5, 1063.5, 'answer', 'North Macedonia');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1006, 'Connie Lawrence', 1049.5, 1072.5, 'recently', 'Syrian Arab Republic');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1007, 'Abigail Shaffer', 1056.5, 1081.5, 'drive', 'Haiti');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1008, 'Gina Moore', 1063.5, 1090.5, 'spring', 'Central African Republic');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1009, 'Gabrielle Davis', 1070.5, 1099.5, 'figure', 'Heard Island and McDonald Islands');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1010, 'Ryan Munoz', 1077.5, 1108.5, 'base', 'Guinea');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1011, 'Monica Herrera', 1084.5, 1117.5, 'top', 'Cote d''Ivoire');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1012, 'Jamie Arnold', 1091.5, 1126.5, 'early', 'Paraguay');
INSERT INTO "mountain" ("id", "name", "height", "prominence", "range", "country") VALUES (1013, 'Lisa Hensley', 1098.5, 1135.5, 'trial', 'Ethiopia');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT name, height, prominence FROM (SELECT * FROM (SELECT * FROM mountain ORDER BY RANGE DESC, mountain.id NULLS LAST) LIMIT 21);

/*
Gold Result:
('Lisa Hensley', 1098.5, 1135.5)
('Monica Herrera', 1084.5, 1117.5)
('Gina Moore', 1063.5, 1090.5)
('Angie Henderson', 1028.5, 1045.5)
('Connie Lawrence', 1049.5, 1072.5)
('Allison Hill', 1014.5, 1027.5)
('Gabrielle Davis', 1070.5, 1099.5)
('Jamie Arnold', 1091.5, 1126.5)
('Abigail Shaffer', 1056.5, 1081.5)
('Noah Rhodes', 1021.5, 1036.5)
('Ryan Munoz', 1077.5, 1108.5)
('Daniel Wagner', 1035.5, 1054.5)
('Cristian Santos', 1042.5, 1063.5)
*/

-- Prediction Query
SELECT name, height, prominence FROM mountain WHERE RANGE <> 'Aberdare Range';

/*
Prediction Result:
('Allison Hill', 1014.5, 1027.5)
('Noah Rhodes', 1021.5, 1036.5)
('Angie Henderson', 1028.5, 1045.5)
('Daniel Wagner', 1035.5, 1054.5)
('Cristian Santos', 1042.5, 1063.5)
('Connie Lawrence', 1049.5, 1072.5)
('Abigail Shaffer', 1056.5, 1081.5)
('Gina Moore', 1063.5, 1090.5)
('Gabrielle Davis', 1070.5, 1099.5)
('Ryan Munoz', 1077.5, 1108.5)
('Monica Herrera', 1084.5, 1117.5)
('Jamie Arnold', 1091.5, 1126.5)
('Lisa Hensley', 1098.5, 1135.5)
*/