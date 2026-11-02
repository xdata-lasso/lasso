-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+50', '#24', 'h');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('+20', '#21', '+29');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('+23', '#24', '#');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('h22', '#24', '#');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('+20', '+50', 'h22');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('+50', '+20', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('#24', '+');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('#21', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T1.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(DISTINCT T1.molecule_id) FROM molecule AS T1 INNER JOIN atom AS T2 ON T1.molecule_id = T2.molecule_id INNER JOIN bond AS T3 ON T1.molecule_id = T3.molecule_id WHERE T3.bond_type = '#' AND T2.element = 'h';

/*
Gold Result:
(200.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN m.label = '+' THEN 1 ELSE 0 END) AS REAL) * 100.0 / COUNT(m.molecule_id) FROM molecule AS m JOIN atom AS a ON m.molecule_id = a.molecule_id JOIN bond AS b ON a.molecule_id = b.molecule_id WHERE a.element = 'h' AND b.bond_type = '#';

/*
Prediction Result:
(100.0,)
*/