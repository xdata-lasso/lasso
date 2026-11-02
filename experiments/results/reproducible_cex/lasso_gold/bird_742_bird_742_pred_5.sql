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
INSERT INTO "alignment" ("id", "alignment") VALUES (1033, 'value');
INSERT INTO "alignment" ("id", "alignment") VALUES (1043, 'prove');
INSERT INTO "colour" ("id", "colour") VALUES (1034, 'training');
INSERT INTO "colour" ("id", "colour") VALUES (1044, 'they');
INSERT INTO "colour" ("id", "colour") VALUES (1039, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1040, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1049, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1050, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1035, 'high');
INSERT INTO "gender" ("id", "gender") VALUES (1045, 'his');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1036, 'Michele Williams');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1046, 'Henry Santiago');
INSERT INTO "race" ("id", "race") VALUES (1037, 'Vampire');
INSERT INTO "race" ("id", "race") VALUES (1047, 'Vampire');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1038, 'Dylan Miller', 'Brian Ramirez', 1035, 1034, 1039, 1040, 1037, 1036, 1033, 1041, 1042);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1048, NULL, 'Kimberly Sanchez', 1045, 1044, 1049, 1050, 1047, 1046, 1043, 1051, 1052);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.superhero_name) FROM superhero AS T1 INNER JOIN race AS T2 ON T1.race_id = T2.id WHERE T2.race = 'Vampire';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(superhero.id) AS count FROM superhero JOIN race ON superhero.race_id = race.id WHERE race.race = 'Vampire';

/*
Prediction Result:
(2,)
*/