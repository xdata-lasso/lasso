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
INSERT INTO "alignment" ("id", "alignment") VALUES (55, 'Bad56');
INSERT INTO "alignment" ("id", "alignment") VALUES (49, 'Bad');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (24, 'Green25');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (23, 'Green25');
INSERT INTO "colour" ("id", "colour") VALUES (25, 'Green');
INSERT INTO "gender" ("id", "gender") VALUES (42, 'Green25');
INSERT INTO "gender" ("id", "gender") VALUES (26, 'Green25');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (43, 'Green25');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (27, 'Green25');
INSERT INTO "race" ("id", "race") VALUES (28, 'Green25');
INSERT INTO "race" ("id", "race") VALUES (44, 'Green25');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (41, 49, 25, 42, 25, 43, 44, 25, 'Green45', 'Bad46', 47, 48);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (50, 55, 25, 42, 25, 43, 44, 25, 'Green51', 'Bad52', 53, 54);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (NULL, 50, 25);
INSERT INTO "superpower" ("id", "power_name") VALUES (30, 'Green25');
INSERT INTO "superpower" ("id", "power_name") VALUES (29, 'Green25');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (50, 29);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (50, 29);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN alignment AS T2 ON T1.alignment_id = T2.id INNER JOIN colour AS T3 ON T1.skin_colour_id = T3.id WHERE T2.alignment = 'Bad' AND T3.colour = 'Green';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero INNER JOIN alignment ON superhero.alignment_id = alignment.id INNER JOIN colour ON superhero.skin_colour_id = colour.id WHERE colour.colour = 'Green' AND alignment.alignment = 'Bad';

/*
Prediction Result:
(1,)
*/