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
INSERT INTO "alignment" ("id", "alignment") VALUES (27, 'Good39');
INSERT INTO "alignment" ("id", "alignment") VALUES (26, 'Marvel Comics40');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (29, 'Marvel Comics70');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (28, 'Marvel Comics70');
INSERT INTO "colour" ("id", "colour") VALUES (63, 'Marvel Comics70');
INSERT INTO "colour" ("id", "colour") VALUES (55, 'Marvel Comics70');
INSERT INTO "gender" ("id", "gender") VALUES (56, 'Marvel Comics70');
INSERT INTO "gender" ("id", "gender") VALUES (64, 'Marvel Comics70');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (30, 'Marvel Comics70');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (70, 'Marvel Comics');
INSERT INTO "race" ("id", "race") VALUES (65, 'Marvel Comics70');
INSERT INTO "race" ("id", "race") VALUES (57, 'Marvel Comics70');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (54, 26, 55, 56, 63, 70, 57, 63, 'Marvel Comics58', 'Good59', 60, 61);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (62, 27, 63, 64, 55, 70, 65, 55, 'Marvel Comics66', 'Good67', 68, 69);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (28, 54, 70);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (28, 62, 70);
INSERT INTO "superpower" ("id", "power_name") VALUES (32, 'Marvel Comics70');
INSERT INTO "superpower" ("id", "power_name") VALUES (31, 'Marvel Comics70');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (62, 31);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(CASE WHEN T3.alignment = 'Good' THEN T1.id ELSE NULL END) AS REAL) * 100 / COUNT(T1.id) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN alignment AS T3 ON T1.alignment_id = T3.id WHERE T2.publisher_name = 'Marvel Comics';

/*
Gold Result:
(0.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN t3.alignment = 'Good' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) AS percentage_of_good_superheroes FROM superhero AS t1 INNER JOIN publisher AS t2 ON t1.publisher_id = t2.id INNER JOIN alignment AS t3 ON t1.alignment_id = t3.id WHERE t2.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(0.0,)
*/