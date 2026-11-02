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
INSERT INTO "alignment" ("id", "alignment") VALUES (47, 'Gold65');
INSERT INTO "alignment" ("id", "alignment") VALUES (26, 'Gold65');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (28, 'Gold65');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (27, 'Gold65');
INSERT INTO "colour" ("id", "colour") VALUES (54, 'Gold');
INSERT INTO "colour" ("id", "colour") VALUES (65, 'Marvel Comics66');
INSERT INTO "gender" ("id", "gender") VALUES (29, 'Gold65');
INSERT INTO "gender" ("id", "gender") VALUES (48, 'Gold65');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (31, 'Marvel Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (30, NULL);
INSERT INTO "race" ("id", "race") VALUES (49, 'Gold65');
INSERT INTO "race" ("id", "race") VALUES (32, 'Gold65');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (46, 47, 54, 48, 65, 31, 49, 65, 'Marvel Comics50', 'Gold51', 52, 53);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (55, NULL, 65, NULL, NULL, 30, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (27, 55, 65);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (28, 46, 65);
INSERT INTO "superpower" ("id", "power_name") VALUES (34, 'Gold65');
INSERT INTO "superpower" ("id", "power_name") VALUES (33, 'Gold65');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (55, 33);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (55, 33);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN colour AS T3 ON T1.eye_colour_id = T3.id WHERE T2.publisher_name = 'Marvel Comics' AND T3.colour = 'Gold';

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(*) FROM superhero AS T1 INNER JOIN colour AS T2 ON T1.eye_colour_id = T2.id INNER JOIN publisher AS T3 ON T1.publisher_id = T3.id WHERE T2.colour = 'Gold' AND T3.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(1,)
*/