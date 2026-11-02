-- Schema DDL
CREATE TABLE "atom" ("atom_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "element" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "bond" ("bond_id" TEXT NOT NULL PRIMARY KEY, "molecule_id" TEXT DEFAULT NULL, "bond_type" TEXT DEFAULT NULL, FOREIGN KEY ("molecule_id") REFERENCES "molecule" ("molecule_id"));

CREATE TABLE "connected" ("atom_id" TEXT NOT NULL, "atom_id2" TEXT NOT NULL, "bond_id" TEXT DEFAULT NULL, PRIMARY KEY ("atom_id", "atom_id2"), FOREIGN KEY ("atom_id") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("atom_id2") REFERENCES "atom" ("atom_id") ON DELETE CASCADE ON UPDATE CASCADE, FOREIGN KEY ("bond_id") REFERENCES "bond" ("bond_id") ON DELETE CASCADE ON UPDATE CASCADE);

CREATE TABLE "molecule" ("molecule_id" TEXT NOT NULL PRIMARY KEY, "label" TEXT DEFAULT NULL);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('-21', 'Non-Carcinogenic23', 'ca');
INSERT INTO "atom" ("atom_id", "molecule_id", "element") VALUES ('Carcinogenic22', 'Non-Carcinogenic23', 'ca');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('Carcinogenic16', NULL, 'Non-Carcinogenic23');
INSERT INTO "bond" ("bond_id", "molecule_id", "bond_type") VALUES ('-15', '+14', 'Non-Carcinogenic23');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Carcinogenic22', '-21', '-15');
INSERT INTO "connected" ("atom_id", "atom_id2", "bond_id") VALUES ('Carcinogenic22', 'Carcinogenic22', 'Carcinogenic16');
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('Non-Carcinogenic23', NULL);
INSERT INTO "molecule" ("molecule_id", "label") VALUES ('+14', 'Non-Carcinogenic23');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.label FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'ca' GROUP BY T2.label ORDER BY COUNT(T2.label) DESC, T2.label NULLS LAST LIMIT 1;

/*
Gold Result:
(None,)
*/

-- Prediction Query
SELECT CASE WHEN SUM(CASE WHEN T2.label = '+' THEN 1 ELSE 0 END) > SUM(CASE WHEN T2.label = '-' THEN 1 ELSE 0 END) THEN 'Carcinogenic' ELSE 'Non-Carcinogenic' END AS Result FROM atom AS T1 INNER JOIN molecule AS T2 ON T1.molecule_id = T2.molecule_id WHERE T1.element = 'Ca';

/*
Prediction Result:
('Non-Carcinogenic',)
*/