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
INSERT INTO "alignment" ("id", "alignment") VALUES (1043, 'hear');
INSERT INTO "alignment" ("id", "alignment") VALUES (1044, 'determine');
INSERT INTO "alignment" ("id", "alignment") VALUES (1045, 'religious');
INSERT INTO "colour" ("id", "colour") VALUES (1046, 'example');
INSERT INTO "colour" ("id", "colour") VALUES (1047, 'science');
INSERT INTO "colour" ("id", "colour") VALUES (1048, 'write');
INSERT INTO "colour" ("id", "colour") VALUES (1061, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1064, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1049, 'Male');
INSERT INTO "gender" ("id", "gender") VALUES (1050, 'Male');
INSERT INTO "gender" ("id", "gender") VALUES (1051, 'Male');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1052, 'Andrea Reid');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1053, 'Danielle Ford');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1054, 'Timothy Watts');
INSERT INTO "race" ("id", "race") VALUES (1055, 'discuss');
INSERT INTO "race" ("id", "race") VALUES (1056, 'reveal');
INSERT INTO "race" ("id", "race") VALUES (1057, 'garden');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1058, 'Patty Perez', 'Matthew Foster', 1049, 1046, 1061, 1064, 1055, 1052, 1043, 1067, 1389782697508469);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1090, 'Patty Perez', 'Matthew Foster', 1049, 1046, 1061, 1064, 1055, 1052, 1043, 1067, 2128654511373731);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Male' AND T1.weight_kg * 100 > (SELECT AVG(weight_kg) FROM superhero) * 79;

/*
Gold Result:
('Matthew Foster',)
('Matthew Foster',)
*/

-- Prediction Query
SELECT T1.full_name FROM superhero AS T1 INNER JOIN gender AS T2 ON T1.gender_id = T2.id WHERE T2.gender = 'Male' AND T1.weight_kg > (SELECT AVG(weight_kg) * 0.79 FROM superhero WHERE NOT weight_kg IS NULL);

/*
Prediction Result:
('Matthew Foster',)
*/