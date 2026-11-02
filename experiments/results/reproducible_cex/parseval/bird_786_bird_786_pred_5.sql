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
INSERT INTO "colour" ("id", "colour") VALUES (-2147483648, 'qcgsk9');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483648, 'wbbp6luhvdlt', 'ilbnp', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1236688122, 2087640001);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5sw');

-- Inserting into table: attribute --
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1, 'Strength');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (2, 'Strength');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (3, 'Strength');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (4, 'Strength');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (5, 'Strength');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (6, 'Strength');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (7, 'Strength');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (8, 'Strength');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (9, 'Strength');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (10, 'Strength');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '8c4p');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7vfe4hria2y');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'uzhs');

-- Inserting into table: hero_attribute --
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 1, NULL);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 1, NULL);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 1, NULL);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 1, NULL);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 1, NULL);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 1, NULL);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 2, -1399556171);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 3, 1419861592);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 4, 374105386);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 5, -1683203397);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 6, -1585009206);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 7, 283598170);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 8, -443340271);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 9, -1179823637);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-2147483648, 10, 781505063);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.hero_id) FROM hero_attribute AS T1 INNER JOIN attribute AS T2 ON T1.attribute_id = T2.id WHERE T2.attribute_name = 'Strength' AND T1.attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute);

/*
Gold Result:
(1,)
*/

-- Prediction Query
SELECT COUNT(DISTINCT hero_id) FROM hero_attribute WHERE attribute_id = (SELECT id FROM attribute WHERE attribute_name = 'Strength') AND attribute_value = (SELECT MAX(attribute_value) FROM hero_attribute WHERE attribute_id = (SELECT id FROM attribute WHERE attribute_name = 'Strength'));

/*
Prediction Result:
(0,)
*/