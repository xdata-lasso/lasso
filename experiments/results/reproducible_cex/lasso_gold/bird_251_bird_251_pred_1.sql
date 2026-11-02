-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('shoulder', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('arm', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('report', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('ready', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('such', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('training', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('boy', '+');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('race', 'shoulder', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('billion', 'shoulder', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('ask', 'shoulder', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('interesting', 'shoulder', NULL);
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('energy', 'shoulder', 'challenge');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('dark', 'shoulder', 'challenge');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('not', 'shoulder', 'challenge');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('list', 'shoulder', 'challenge');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T.element FROM (SELECT T2.element, COUNT(DISTINCT T2.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.label = '+' GROUP BY T2.element ORDER BY COUNT(DISTINCT T2.molecule_id), T2.element NULLS LAST LIMIT 1) AS t;

/*
Gold Result:
('challenge',)
*/

-- Prediction Query
SELECT a.element FROM molecule AS m INNER JOIN atom AS a ON m.molecule_id = a.molecule_id WHERE m.label = '+' GROUP BY a.element ORDER BY COUNT(a.element) ASC, a.element NULLS LAST LIMIT 1;

/*
Prediction Result:
(None,)
*/