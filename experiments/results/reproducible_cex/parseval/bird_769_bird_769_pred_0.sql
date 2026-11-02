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
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1, 't1__ea1f15', 'e4', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 1160656988, -992890117);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (2, 't1__ea1f15', 'rwbbp', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, 13244799, -1659388584);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (3, 'a9000t5c4eci', 'gce376nium52', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 1, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (4, 'cgsk9', '8c4p', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 2, -2147483648, 1871297066, 809183447);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (5, 'a2ypuzhsrwbb', 'p6luhvdlttil', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 5, -2147483648, 429706943, 462974032);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (6, 'w6kl', 'a9', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 6, -2147483648, 1620389964, 546571701);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (7, 'gce', '76nium52', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 7, -2147483648, -443340271, 757448742);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (8, 'qyp5s5bbp0', '2eutliqa11r', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 8, -2147483648, 2137741668, -525979501);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (9, 'lex', '4ji7zwa', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 9, -2147483648, 2123196517, 364869063);

INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (10, '9rljsl0b4', 'p5qi2rk', -2147483648, -2147483648, -2147483648, -2147483648, -2147483648, 10, -2147483648, -705985602, 537874887);

-- Inserting into table: alignment --
INSERT INTO "alignment" ("id", "alignment") VALUES (-2147483648, '5k5swwqcgs');

-- Inserting into table: attribute --
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1, 'Durability');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (-2147483647, 'Durability');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (2, 'Durability');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (3, 'qyp5s5bbp0');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (4, NULL);

INSERT INTO "attribute" ("id", "attribute_name") VALUES (5, 'Durability');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (6, 't3__dffe88');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (7, NULL);

INSERT INTO "attribute" ("id", "attribute_name") VALUES (8, 'Durability');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (9, 't3__dffe88');

INSERT INTO "attribute" ("id", "attribute_name") VALUES (10, NULL);

-- Inserting into table: gender --
INSERT INTO "gender" ("id", "gender") VALUES (-2147483648, '4');

-- Inserting into table: publisher --
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1, 'Dark Horse Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (-2147483647, 'Dark Horse Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (3, 'Dark Horse Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (4, 'qa1');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (2, 'Dark Horse Comics');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (5, 't4__e98e8b');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (6, 't4__e98e8b');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (7, 't4__e98e8b');

INSERT INTO "publisher" ("id", "publisher_name") VALUES (8, NULL);

INSERT INTO "publisher" ("id", "publisher_name") VALUES (9, NULL);

INSERT INTO "publisher" ("id", "publisher_name") VALUES (10, NULL);

-- Inserting into table: race --
INSERT INTO "race" ("id", "race") VALUES (-2147483648, 'u7');

-- Inserting into table: hero_attribute --
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1914020640);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2, 1, 429706943);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (2, 1, 462974032);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, 1, -1179823637);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 3, 743312762);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 2137741668);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, 1, 226938182);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 3, 1775126557);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 2123196517);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, 1, 392822403);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 3, 1661181156);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1025564911);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 537874887);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -461695645);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1675430660);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -688509700);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, 1, -261132974);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1660358170);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1106350634);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1748371085);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1742081330);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, 1, 1606439408);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 982314585);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 638024588);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1520489792);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -658391922);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (3, 1, 564390026);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 1746373317);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, -1714354341);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1, 1, 678047687);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (4, 4, 89267185);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (5, 5, -1137908826);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (6, 6, 947159877);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (7, 7, -1179823637);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (8, 8, 1898504886);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (9, 9, -953437896);

INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (10, 10, -461695645);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T3.id = T2.attribute_id INNER JOIN publisher AS T4 ON T4.id = T1.publisher_id WHERE T4.publisher_name = 'Dark Horse Comics' AND T3.attribute_name = 'Durability' ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Gold Result:
('t1__ea1f15',)
*/

-- Prediction Query
SELECT T1.superhero_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id INNER JOIN publisher AS T4 ON T1.publisher_id = T4.id WHERE T3.attribute_name = 'durability' AND T4.publisher_name = 'Dark Horse Comics' ORDER BY T2.attribute_value DESC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST, T4.id NULLS LAST LIMIT 1;

/*
Prediction Result:
*/