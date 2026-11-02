-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+50', '#51', 'h');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('#24', 'h25', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('+23', 'h25', '+50');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('+50', '+50', '#24');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('#51', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('h25', '+50');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T2.element = 'h';

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CASE WHEN COUNT(DISTINCT a.molecule_id) = 0 THEN 0 ELSE (COUNT(DISTINCT CASE WHEN m.label = '+' THEN m.molecule_id ELSE NULL END) * 100.0 / COUNT(DISTINCT a.molecule_id)) END AS percentage FROM connected AS c JOIN atom AS a ON c.atom_id = a.atom_id JOIN bond AS b ON c.bond_id = b.bond_id JOIN molecule AS m ON a.molecule_id = m.molecule_id WHERE a.element = 'h' AND b.bond_type = '#';

/*
Prediction Result:
(100.0,)
*/