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
INSERT INTO "alignment" ("id", "alignment") VALUES (1055, 'prove');
INSERT INTO "alignment" ("id", "alignment") VALUES (1105, 'while');
INSERT INTO "colour" ("id", "colour") VALUES (1056, 'Congress');
INSERT INTO "colour" ("id", "colour") VALUES (1106, 'born');
INSERT INTO "colour" ("id", "colour") VALUES (1061, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1062, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1111, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1112, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1057, 'none');
INSERT INTO "gender" ("id", "gender") VALUES (1107, 'truth');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1058, 'Carla Gray');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1108, 'Sarah Romero');
INSERT INTO "race" ("id", "race") VALUES (1059, 'wish');
INSERT INTO "race" ("id", "race") VALUES (1109, 'decide');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1060, 'Kristin Cohen', 'Patty Perez', 1057, 1056, 1061, 1062, 1059, 1058, 1055, 1063, 1064);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1110, 'Phillip Ryan', 'Kerry Smith', 1107, 1106, 1111, 1112, 1109, 1108, 1105, NULL, 1114);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(height_cm) AS REAL) / COUNT(id) FROM superhero;

/*
Gold Result:
(531.5,)
*/

-- Prediction Query
SELECT AVG(height_cm) AS average_height FROM superhero;

/*
Prediction Result:
(1063.0,)
*/