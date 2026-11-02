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
INSERT INTO "colour" ("id", "colour") VALUES (-2147483648, '9n8');

-- Inserting into table: superhero --
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'Black Panther', 'ypuzhsrw', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1908028688, 2122220075);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'Black Panther', 'dpos', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1576219117, -1823627488);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-1, 'Black Panther', 'e376nium52', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (0, 'Black Panther', 'fqyp5s5bbp0', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 743312762, -1822992503);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 't1__5c8991', 'g', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -890215420, 1610062532);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, NULL, 'hsrwbbp', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 13244799, -1659388584);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'Black Panther', 'g', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -890215420, 1610062532);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'Black Panther', 'hsrwbbp', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 13244799, -1659388584);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'Black Panther', 'dposiie5unw', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1399556171, 1038707349);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: attribute --
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1, 't3__aed33e');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (2, 't3__aed33e');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (-2147483647, 't3__aed33e');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (3, 'klfa9000t');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (-1, 't3__aed33e');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (4, '9hl7');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (0, 'l0b4y');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (5, 'pgu7vfe4');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (6, 'l');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (-2147483639, NULL);

INSERT INTO "attribute" ("id", "attribute_name") VALUES (7, 'pgu7vfe4');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (-2147483637, NULL);

INSERT INTO "attribute" ("id", "attribute_name") VALUES (8, 'l');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (-2147483635, NULL);

INSERT INTO "attribute" ("id", "attribute_name") VALUES (9, '9000t5c4ec');

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');

-- Inserting into table: hero_attribute --
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1072996612);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 2, -1209887326);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 3, 1408123494);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, -1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 4, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, -1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 4, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 0, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 0, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 4, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (0, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, -1, -1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 1, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 4, 0);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (-1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -211209314);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1056308489);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -155284187);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1686459626);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1672720816);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1520489792);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1350414441);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 2094425101);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 61479715);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1496556994);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1449284300);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -977470238);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1794176801);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1194675273);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 2111987706);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -598313376);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1948383687);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 2035306060);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2, 5, 1160656988);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, 6, -845863578);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (4, 7, 1160656988);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (5, 8, -845863578);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (6, 9, -1683203397);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.attribute_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T1.superhero_name = 'Black Panther' ORDER BY T2.attribute_value ASC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
('t3__aed33e',)
*/

-- Prediction Query
SELECT a.attribute_name FROM hero_attribute AS ha INNER JOIN attribute AS a ON ha.attribute_id = a.id WHERE ha.hero_id = (SELECT id FROM superhero WHERE superhero_name = 'Black Panther') ORDER BY ha.attribute_value ASC, ha.hero_id NULLS LAST, ha.attribute_id NULLS LAST, a.id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/