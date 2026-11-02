-- Schema DDL
CREATE TABLE alignment (id INTEGER NOT NULL PRIMARY KEY, alignment TEXT DEFAULT NULL);

CREATE TABLE attribute (id INTEGER NOT NULL PRIMARY KEY, attribute_name TEXT DEFAULT NULL);

CREATE TABLE colour (id INTEGER NOT NULL PRIMARY KEY, colour TEXT DEFAULT NULL);

CREATE TABLE gender (id INTEGER NOT NULL PRIMARY KEY, gender TEXT DEFAULT NULL);

CREATE TABLE publisher (id INTEGER NOT NULL PRIMARY KEY, publisher_name TEXT DEFAULT NULL);

CREATE TABLE race (id INTEGER NOT NULL PRIMARY KEY, race TEXT DEFAULT NULL);

CREATE TABLE superhero (id INTEGER NOT NULL PRIMARY KEY, superhero_name TEXT DEFAULT NULL, full_name TEXT DEFAULT NULL, gender_id INTEGER DEFAULT NULL, eye_colour_id INTEGER DEFAULT NULL, hair_colour_id INTEGER DEFAULT NULL, skin_colour_id INTEGER DEFAULT NULL, race_id INTEGER DEFAULT NULL, publisher_id INTEGER DEFAULT NULL, alignment_id INTEGER DEFAULT NULL, height_cm INTEGER DEFAULT NULL, weight_kg INTEGER DEFAULT NULL, FOREIGN KEY (alignment_id) REFERENCES alignment (id), FOREIGN KEY (eye_colour_id) REFERENCES colour (id), FOREIGN KEY (gender_id) REFERENCES gender (id), FOREIGN KEY (hair_colour_id) REFERENCES colour (id), FOREIGN KEY (publisher_id) REFERENCES publisher (id), FOREIGN KEY (race_id) REFERENCES race (id), FOREIGN KEY (skin_colour_id) REFERENCES colour (id));

CREATE TABLE hero_attribute (hero_id INTEGER DEFAULT NULL, attribute_id INTEGER DEFAULT NULL, attribute_value INTEGER DEFAULT NULL, FOREIGN KEY (attribute_id) REFERENCES attribute (id), FOREIGN KEY (hero_id) REFERENCES superhero (id));

CREATE TABLE superpower (id INTEGER NOT NULL PRIMARY KEY, power_name TEXT DEFAULT NULL);

CREATE TABLE hero_power (hero_id INTEGER DEFAULT NULL, power_id INTEGER DEFAULT NULL, FOREIGN KEY (hero_id) REFERENCES superhero (id), FOREIGN KEY (power_id) REFERENCES superpower (id));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "alignment" ("id", "alignment") VALUES (1021, 'discussion');
INSERT INTO "alignment" ("id", "alignment") VALUES (1022, 'list');
INSERT INTO "colour" ("id", "colour") VALUES (1023, 'perform');
INSERT INTO "colour" ("id", "colour") VALUES (1024, 'fall');
INSERT INTO "colour" ("id", "colour") VALUES (1033, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1035, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1025, 'table');
INSERT INTO "gender" ("id", "gender") VALUES (1026, 'true');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1027, 'Valerie Gray');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1041, 'Sandra Montgomery');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1028, NULL);
INSERT INTO "race" ("id", "race") VALUES (1029, 'according');
INSERT INTO "race" ("id", "race") VALUES (1030, 'song');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1031, 'Melissa Peterson', 'Brent Abbott', 1025, 1023, 1033, 1035, 1029, 1027, 1021, 1037, 1039);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1032, 'Tyler Rogers', 'Renee Blair', 1025, 1023, 1033, 1035, 1029, 1028, 1021, 1060.0, 1064.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1042, 'Melissa Peterson', 'Brent Abbott', 1025, 1023, 1033, 1035, 1029, 1041, 1021, 1037, 1039);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT SUM(CASE WHEN T2.publisher_name = 'Marvel Comics' THEN 1 ELSE 0 END) - SUM(CASE WHEN T2.publisher_name = 'DC Comics' THEN 1 ELSE 0 END) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id;

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT ABS(CAST(SUM(publisher_name = 'Marvel Comics') AS REAL) - CAST(SUM(publisher_name = 'DC Comics') AS REAL)) AS difference FROM superhero JOIN publisher ON superhero.publisher_id = publisher.id WHERE publisher_name IN ('DC Comics', 'Marvel Comics');

/*
Prediction Result:
(None,)
*/