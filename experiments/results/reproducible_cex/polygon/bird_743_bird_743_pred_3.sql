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
INSERT INTO "alignment" ("id", "alignment") VALUES (32, NULL);
INSERT INTO "alignment" ("id", "alignment") VALUES (31, NULL);
INSERT INTO "attribute" ("id", "attribute_name") VALUES (27, 'Marvel Comics39');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (26, 'Marvel Comics39');
INSERT INTO "colour" ("id", "colour") VALUES (39, 'Marvel Comics39');
INSERT INTO "colour" ("id", "colour") VALUES (35, 'Marvel Comics39');
INSERT INTO "gender" ("id", "gender") VALUES (33, 'Marvel Comics39');
INSERT INTO "gender" ("id", "gender") VALUES (34, 'Marvel Comics39');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (36, NULL);
INSERT INTO "publisher" ("id", "publisher_name") VALUES (37, NULL);
INSERT INTO "race" ("id", "race") VALUES (28, 'Marvel Comics39');
INSERT INTO "race" ("id", "race") VALUES (38, 'Marvel Comics39');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (30, 31, 39, 33, 39, 36, 38, 39, 'Bad46', 'Marvel Comics47', 48, 49);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (29, 32, 35, 34, 35, 37, 38, 39, 'Bad52', 'Marvel Comics53', 54, 55);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (NULL, NULL, 39);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (26, 30, 39);
INSERT INTO "superpower" ("id", "power_name") VALUES (41, 'Marvel Comics39');
INSERT INTO "superpower" ("id", "power_name") VALUES (40, 'Marvel Comics39');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (30, 40);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (29, 40);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (CAST(COUNT(*) AS REAL) * 100 / (SELECT COUNT(*) FROM superhero)), CAST(SUM(CASE WHEN T2.publisher_name = 'Marvel Comics' THEN 1 ELSE 0 END) AS REAL) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN alignment AS T3 ON T3.id = T1.alignment_id WHERE T3.alignment = 'Bad';

/*
Gold Result:
(0.0, None)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T1.alignment = 'Bad' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id), COUNT(CASE WHEN T1.alignment = 'Bad' AND T3.publisher_name = 'Marvel Comics' THEN 1 ELSE NULL END) FROM alignment AS T1 JOIN superhero AS T2 ON T1.id = T2.alignment_id JOIN publisher AS T3 ON T2.publisher_id = T3.id;

/*
Prediction Result:
(0.0, 0)
*/