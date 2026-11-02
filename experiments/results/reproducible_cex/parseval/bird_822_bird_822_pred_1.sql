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
-- Inserting into table: colour --
INSERT INTO "colour" ("id", "colour") VALUES (1, 'Green');

INSERT INTO "colour" ("id", "colour") VALUES (2, 'Green');

INSERT INTO "colour" ("id", "colour") VALUES (3, 'Green');

INSERT INTO "colour" ("id", "colour") VALUES (4, 'Green');

INSERT INTO "colour" ("id", "colour") VALUES (5, 'Green');

INSERT INTO "colour" ("id", "colour") VALUES (6, 'Green');

INSERT INTO "colour" ("id", "colour") VALUES (7, 'Green');

INSERT INTO "colour" ("id", "colour") VALUES (8, 'Green');

INSERT INTO "colour" ("id", "colour") VALUES (9, 'Green');

INSERT INTO "colour" ("id", "colour") VALUES (10, 'Green');

INSERT INTO "colour" ("id", "colour") VALUES (11, 'Green');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'hsrwbbp', 'luhvdltti', -2147483648, 1, 1, 2, -2147483648, -2147483648, 1, -1364429300, -1257178728);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'siie5unw6k', 'fa9', -2147483648, 1, 3, 3, -2147483648, -2147483648, 1, 1620389964, 546571701);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'cigce376nium', '52zbuo4nrq', -2147483648, 3, 1, 4, -2147483648, -2147483648, 1, 418417917, -1031969798);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, '02eu', 'liqa1', -2147483648, 4, 4, 5, -2147483648, -2147483648, 1, 2074205376, 274769912);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, '9hl7', 'klex14ji', -2147483648, 6, 6, 6, -2147483648, -2147483648, 1, -453362185, 481163439);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'yrq13pyu78d9', 'rljsl0b4y', -2147483648, 6, 6, 7, -2147483648, -2147483648, 1, -1116181514, 1255852738);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'x58pz', 'f8jegd2', -2147483648, 8, 3, 8, -2147483648, -2147483648, 1, 1675430660, -688509700);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'd', 'lph2gn', -2147483648, 6, 8, 9, -2147483648, -2147483648, 1, 1968874827, -664193365);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'p', 'jtu0d', -2147483648, 1, 8, 10, -2147483648, -2147483648, 1, 401805964, -1485777725);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, 'dqv0gcb98ozk', 'zbilyrkn', -2147483648, 9, 8, 11, -2147483648, -2147483648, 1, -688098735, 1784916884);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (1, 'Bad');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, 'swwqcgsk');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, '8c4pgu7vfe');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'hria2ypu');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN colour AS T3 ON T1.skin_colour_id = T3.id WHERE T2.alignment = 'Bad' AND T3.colour = 'Green';

/*
Gold Result:
(10,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero WHERE skin_colour_id = (SELECT id FROM colour WHERE colour = 'Green') AND alignment_id = (SELECT id FROM alignment WHERE alignment = 'Bad');

/*
Prediction Result:
(0,)
*/