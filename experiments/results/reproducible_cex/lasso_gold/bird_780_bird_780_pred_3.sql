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
INSERT INTO "alignment" ("id", "alignment") VALUES (1067, 'executive');
INSERT INTO "colour" ("id", "colour") VALUES (1068, 'attorney');
INSERT INTO "colour" ("id", "colour") VALUES (1074, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1075, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1069, 'development');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1070, 'Latoya Robbins');
INSERT INTO "race" ("id", "race") VALUES (1071, 'difference');
INSERT INTO "superpower" ("id", "power_name") VALUES (1072, 'Jennifer Rocha');
INSERT INTO "superpower" ("id", "power_name") VALUES (1079, 'Jennifer Rocha');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1073, 'Derek Wright', 'Hunter Zolomon', 1069, 1068, 1074, 1075, 1071, 1070, 1067, 1076, 1077);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1078, 'Derek Wright', 'Hunter Zolomon', 1069, 1068, 1074, 1075, 1071, 1070, 1067, 1076, 1077);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1073, 1072);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (1078, 1079);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.power_name FROM superhero AS T1 INNER JOIN hero_power AS T2 ON T1.id = T2.hero_id INNER JOIN superpower AS T3 ON T2.power_id = T3.id WHERE T1.full_name = 'Hunter Zolomon';

/*
Gold Result:
('Jennifer Rocha',)
('Jennifer Rocha',)
*/

-- Prediction Query
SELECT DISTINCT superpower.power_name FROM superhero INNER JOIN hero_power ON superhero.id = hero_power.hero_id INNER JOIN superpower ON hero_power.power_id = superpower.id WHERE superhero.full_name = 'Hunter Zolomon';

/*
Prediction Result:
('Jennifer Rocha',)
*/