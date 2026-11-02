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
INSERT INTO "alignment" ("id", "alignment") VALUES (27, 'No Colour20');
INSERT INTO "alignment" ("id", "alignment") VALUES (26, 'No Colour20');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (18, 'No Colour20');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (17, 'No Colour20');
INSERT INTO "colour" ("id", "colour") VALUES (20, 'No Colour');
INSERT INTO "colour" ("id", "colour") VALUES (19, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (29, 'No Colour20');
INSERT INTO "gender" ("id", "gender") VALUES (21, 'No Colour20');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (32, 'No Colour20');
INSERT INTO "race" ("id", "race") VALUES (23, 'No Colour20');
INSERT INTO "race" ("id", "race") VALUES (22, 'No Colour20');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (25, 26, 20, 29, 19, 32, NULL, 20, NULL, NULL, NULL, NULL);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (24, 27, NULL, NULL, NULL, NULL, NULL, 19, 'No Colour47', 'No Colour48', 49, 50);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (18, 25, 20);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (17, 24, 20);
INSERT INTO "superpower" ("id", "power_name") VALUES (37, 'No Colour20');
INSERT INTO "superpower" ("id", "power_name") VALUES (36, 'No Colour20');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (24, 36);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (24, 36);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(*) AS REAL) / SUM(CASE WHEN T2.id = 1 THEN 1 ELSE 0 END) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.skin_colour_id = T2.id;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CAST(COUNT(superhero.id) AS REAL) / SUM(CASE WHEN colour.colour = 'No Colour' THEN 1 ELSE 0 END) AS average FROM superhero LEFT JOIN colour ON superhero.skin_colour_id = colour.id;

/*
Prediction Result:
(2.0,)
*/