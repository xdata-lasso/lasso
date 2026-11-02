-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: atom --
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('21', 't2__b1563f', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('25', '?', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('_', 't2__b1563f', 'e4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('A', 't2__b1563f', 'hria2ypuzhs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Q', 't2__b1563f', 'rwbbp6luhvd');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('O', 't2__b1563f', 'tti');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('2', 't2__b1563f', 'bnp');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('23', 't2__b1563f', 'mdpos');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('24', '!', '5k5swwqcgs');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('a', 'I', '9n8');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('4', 'H', '4');

INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('@', 'G', 'gu7v');

-- Inserting into table: molecule --
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('t2__b1563f', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('@', '+');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('?', '9n8');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('A', 'gu7v');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('!', NULL);

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('I', 't2__cdea0e');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('H', 't2__cdea0e');

INSERT INTO "molecule" ("molecule_id", "label") VALUES ('G', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T2.molecule_id FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE SUBSTRING(T1.atom_id, -2) BETWEEN '21' AND '25' AND T2.label = '+';

/*
Gold Result:
('t2__b1563f',)
*/

-- Prediction Query
SELECT DISTINCT a.molecule_id FROM atom AS a JOIN (SELECT molecule_id FROM molecule WHERE label = '+') AS m ON a.molecule_id = m.molecule_id WHERE SUBSTRING(a.atom_id, 7, 2) BETWEEN '21' AND '25' ORDER BY a.molecule_id;

/*
Prediction Result:
*/