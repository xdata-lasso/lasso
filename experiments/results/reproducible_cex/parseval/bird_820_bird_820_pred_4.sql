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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 'Hulk', 'ypuzhsrw', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1908028688, 2122220075);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (-2147483647, 'Hulk', 'mdpos', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1576219117, -1823627488);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 'Hulk', '9000t5c4ec', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1683203397, 528680845);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'zbuo4nrqrof', 'qyp5s5bbp0', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 743312762, -1822992503);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'Hulk', 'g', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -890215420, 1610062532);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 't1__09da82', 'ia2yp', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1670923962, 700293388);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 't1__09da82', 'l', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -845863578, -1610064545);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, NULL, 'ie5', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -1209887326, -1399556171);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, NULL, 'ecigce376n', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1313172851, -761141909);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, NULL, 'rqrofqyp5s', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 902551284, 2107872094);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: attribute --
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1, 'Strength');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (-2147483647, 'Strength');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (3, 'Strength');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (2, 'yytoo');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (4, NULL);

INSERT INTO "attribute" ("id", "attribute_name") VALUES (5, 't3__510efe');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (6, NULL);

INSERT INTO "attribute" ("id", "attribute_name") VALUES (7, 'Strength');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (8, 't3__510efe');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (9, NULL);

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483648, 'u7');

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'fe4hri');

-- Inserting into table: hero_attribute --
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 2, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 2, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 2, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, NULL);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (4, 4, -106629402);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (5, 5, 906324270);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (6, 6, 429706943);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (7, 7, 1038707349);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (8, 8, 283598170);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (9, 9, 882961052);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.attribute_value FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T1.superhero_name = 'Hulk' AND T3.attribute_name = 'Strength';

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(None,)
*/

-- Prediction Query
SELECT attribute_value FROM hero_attribute WHERE hero_id = (SELECT id FROM superhero WHERE superhero_name = 'Hulk') AND attribute_id = (SELECT id FROM attribute WHERE attribute_name = 'Strength');

/*
Prediction Result:
*/