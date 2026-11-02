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
INSERT INTO "alignment" ("id", "alignment") VALUES (28, 'Marvel Comics53');
INSERT INTO "alignment" ("id", "alignment") VALUES (27, NULL);
INSERT INTO "attribute" ("id", "attribute_name") VALUES (30, 'Marvel Comics53');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (29, 'Marvel Comics53');
INSERT INTO "colour" ("id", "colour") VALUES (53, 'Marvel Comics53');
INSERT INTO "colour" ("id", "colour") VALUES (31, 'Marvel Comics53');
INSERT INTO "gender" ("id", "gender") VALUES (52, 'Marvel Comics53');
INSERT INTO "gender" ("id", "gender") VALUES (32, 'Marvel Comics53');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (54, 'Marvel Comics');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (65, 'Bad60');
INSERT INTO "race" ("id", "race") VALUES (55, 'Marvel Comics53');
INSERT INTO "race" ("id", "race") VALUES (33, 'Marvel Comics53');
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (61, 27, NULL, NULL, NULL, 65, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO "superhero" ("id", "alignment_id", "eye_colour_id", "gender_id", "hair_colour_id", "publisher_id", "race_id", "skin_colour_id", "superhero_name", "full_name", "height_cm", "weight_kg") VALUES (51, 27, 53, 52, 53, 54, 55, 53, 'Bad56', 'Marvel Comics57', 58, 59);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (30, 51, 53);
INSERT INTO "hero_attribute" ("attribute_id", "hero_id", "attribute_value") VALUES (29, 51, 53);
INSERT INTO "superpower" ("id", "power_name") VALUES (35, 'Marvel Comics53');
INSERT INTO "superpower" ("id", "power_name") VALUES (34, 'Marvel Comics53');
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (51, 34);
INSERT INTO "hero_power" ("hero_id", "power_id") VALUES (61, 35);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (CAST(COUNT(*) AS REAL) * 100 / (SELECT COUNT(*) FROM superhero)), CAST(SUM(CASE WHEN T2.publisher_name = 'Marvel Comics' THEN 1 ELSE 0 END) AS REAL) FROM superhero AS T1 INNER JOIN publisher AS T2 ON T1.publisher_id = T2.id INNER JOIN alignment AS T3 ON T3.id = T1.alignment_id WHERE T3.alignment = 'Bad';

/*
Gold Result:
(0.0, None)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN T3.alignment = 'Bad' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id) AS percentage_bad, SUM(CASE WHEN T3.alignment = 'Bad' THEN 1 ELSE 0 END) AS count_bad FROM publisher AS T1 INNER JOIN superhero AS T2 ON T1.id = T2.publisher_id INNER JOIN alignment AS T3 ON T2.alignment_id = T3.id WHERE T1.publisher_name = 'Marvel Comics';

/*
Prediction Result:
(0.0, 0)
*/