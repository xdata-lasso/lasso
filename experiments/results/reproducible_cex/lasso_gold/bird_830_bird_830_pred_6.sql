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
INSERT INTO "alignment" ("id", "alignment") VALUES (1751, 'avoid');
INSERT INTO "alignment" ("id", "alignment") VALUES (1752, 'right');
INSERT INTO "alignment" ("id", "alignment") VALUES (1753, 'east');
INSERT INTO "alignment" ("id", "alignment") VALUES (1754, 'window');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1755, 'Rick Lawrence');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1756, 'Christina Wilson');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1757, 'Chase Baker');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1758, 'Anthony Sparks');
INSERT INTO "attribute" ("id", "attribute_name") VALUES (1745, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1759, 'physical');
INSERT INTO "colour" ("id", "colour") VALUES (1760, 'smile');
INSERT INTO "colour" ("id", "colour") VALUES (1761, 'thank');
INSERT INTO "colour" ("id", "colour") VALUES (1762, 'outside');
INSERT INTO "colour" ("id", "colour") VALUES (1779, NULL);
INSERT INTO "colour" ("id", "colour") VALUES (1783, NULL);
INSERT INTO "gender" ("id", "gender") VALUES (1763, 'will');
INSERT INTO "gender" ("id", "gender") VALUES (1764, 'fight');
INSERT INTO "gender" ("id", "gender") VALUES (1765, 'leg');
INSERT INTO "gender" ("id", "gender") VALUES (1766, 'capital');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1767, 'Eric Powell');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1768, 'Joshua Kim');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1769, 'Stacy Navarro');
INSERT INTO "publisher" ("id", "publisher_name") VALUES (1770, 'Allison Perez');
INSERT INTO "race" ("id", "race") VALUES (1771, 'represent');
INSERT INTO "race" ("id", "race") VALUES (1772, 'think');
INSERT INTO "race" ("id", "race") VALUES (1773, 'traditional');
INSERT INTO "race" ("id", "race") VALUES (1774, 'parent');
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1775, 'Black Panther', 'Alicia Hubbard', 1763, 1759, 1779, 1783, 1771, 1767, 1751, 1787, 1791);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1776, 'Black Panther', 'Laura Hines', 1763, 1759, 1779, 1783, 1771, 1767, 1751, 1810.0, 1816.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1777, 'Black Panther', 'Joseph Ramos', 1763, 1759, 1779, 1783, 1771, 1767, 1751, 1833.0, 1841.0);
INSERT INTO "superhero" ("id", "superhero_name", "full_name", "gender_id", "eye_colour_id", "hair_colour_id", "skin_colour_id", "race_id", "publisher_id", "alignment_id", "height_cm", "weight_kg") VALUES (1778, 'Black Panther', 'Zachary Graham', 1763, 1759, 1779, 1783, 1771, 1767, 1751, 1856.0, 1866.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1775, 1755, 1795);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1775, 1755, 1802.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1775, 1755, 1809.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1775, 1755, 1816.0);
INSERT INTO "hero_attribute" ("hero_id", "attribute_id", "attribute_value") VALUES (1775, 1745, 1795);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T3.attribute_name FROM superhero AS T1 INNER JOIN hero_attribute AS T2 ON T1.id = T2.hero_id INNER JOIN attribute AS T3 ON T2.attribute_id = T3.id WHERE T1.superhero_name = 'Black Panther' ORDER BY T2.attribute_value ASC, T1.id NULLS LAST, T2.hero_id NULLS LAST, T2.attribute_id NULLS LAST, T3.id NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT a.attribute_name FROM attribute AS a INNER JOIN hero_attribute AS ha ON a.id = ha.attribute_id INNER JOIN superhero AS s ON ha.hero_id = s.id WHERE s.superhero_name = 'Black Panther' GROUP BY a.id ORDER BY MIN(ha.attribute_value) ASC, a.attribute_name NULLS LAST LIMIT 1;

/*
Prediction Result:
('Rick Lawrence',)
*/