-- Schema DDL
/* Relational schema for MMRO-BM (ManyMutationsRandomObfuscated: Random Letter Strings) */ /* Relational schema for ManyMutantsBM benchmark suite. */ /* Universal schema compatible with SQLite, PostgreSQL, and MySQL. */ CREATE TABLE udaxih (utlsgw INTEGER PRIMARY KEY, cbvhyj TEXT(100) NOT NULL UNIQUE, chdmio TEXT(100) NOT NULL);

CREATE TABLE hexdvx (ulfllg INTEGER PRIMARY KEY, viwvuc TEXT(100) NOT NULL, utlsgw INTEGER NOT NULL, tufrxh TEXT(50) NOT NULL, fomiuw INTEGER NOT NULL DEFAULT 1, FOREIGN KEY (utlsgw) REFERENCES udaxih (utlsgw));

CREATE TABLE rcsnba (rhvkyy INTEGER PRIMARY KEY, bhbzkm TEXT(100) NOT NULL UNIQUE, utlsgw INTEGER NOT NULL, icgswk REAL NOT NULL, gupmuo TEXT(20) NOT NULL, FOREIGN KEY (utlsgw) REFERENCES udaxih (utlsgw));

CREATE TABLE cghqta (eiehxr INTEGER PRIMARY KEY, ulfllg INTEGER NOT NULL, rhvkyy INTEGER NOT NULL, rixsns TEXT(20) NOT NULL, mlheqp REAL NOT NULL, UNIQUE (ulfllg, rhvkyy), FOREIGN KEY (ulfllg) REFERENCES hexdvx (ulfllg), FOREIGN KEY (rhvkyy) REFERENCES rcsnba (rhvkyy));

CREATE TABLE rgwuwr (cybdeu INTEGER PRIMARY KEY, rhvkyy INTEGER NOT NULL, fzvntc INTEGER, tufrxh TEXT(200) NOT NULL, mmtoqi TEXT(20) NOT NULL, gupmuo TEXT(20) NOT NULL, ravxdv TEXT(20) NOT NULL, FOREIGN KEY (rhvkyy) REFERENCES rcsnba (rhvkyy), FOREIGN KEY (fzvntc) REFERENCES hexdvx (ulfllg));

CREATE TABLE nhosiz (ryiyuk INTEGER PRIMARY KEY, djnfoa TEXT(100) NOT NULL, xxiqyf TEXT(20) NOT NULL, fomiuw INTEGER NOT NULL DEFAULT 1);

CREATE TABLE ayzfwn (qdujuq INTEGER PRIMARY KEY, ryiyuk INTEGER NOT NULL, tgelyf TEXT(20) NOT NULL, ryqatk TEXT(20) NOT NULL, padlzj TEXT(20) NOT NULL DEFAULT 'STANDARD', hbhscc REAL NOT NULL DEFAULT 0, FOREIGN KEY (ryiyuk) REFERENCES nhosiz (ryiyuk));

CREATE TABLE kiegyk (xpcyry INTEGER PRIMARY KEY, eevprf TEXT(100) NOT NULL UNIQUE, iqtngr TEXT(50) NOT NULL);

CREATE TABLE dcmdll (yxwgwj INTEGER PRIMARY KEY, xpcyry INTEGER NOT NULL, mvuloq TEXT(100) NOT NULL, odhhck REAL NOT NULL, asrhsh INTEGER NOT NULL DEFAULT 0, FOREIGN KEY (xpcyry) REFERENCES kiegyk (xpcyry));

CREATE TABLE tizbxo (acwubh INTEGER PRIMARY KEY, qdujuq INTEGER NOT NULL, yxwgwj INTEGER NOT NULL, cbkcqh INTEGER NOT NULL, ivpgre REAL NOT NULL, xssphz REAL, UNIQUE (qdujuq, yxwgwj), FOREIGN KEY (qdujuq) REFERENCES ayzfwn (qdujuq), FOREIGN KEY (yxwgwj) REFERENCES dcmdll (yxwgwj));

CREATE TABLE rdmcrj (pzngdd INTEGER PRIMARY KEY, yxwgwj INTEGER NOT NULL, ryiyuk INTEGER NOT NULL, vnlnno INTEGER NOT NULL, xbvuud INTEGER NOT NULL DEFAULT 0, bmxkzd TEXT(20) NOT NULL, FOREIGN KEY (yxwgwj) REFERENCES dcmdll (yxwgwj), FOREIGN KEY (ryiyuk) REFERENCES nhosiz (ryiyuk));

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO nhosiz (ryiyuk, djnfoa, xxiqyf, fomiuw) VALUES (0, 'COMPLETED', 'COMPLETED', 1), (1, 'COMPLETED', 'default2', 2), (2, 'RUSH', 'RUSH', 2), (3, 'OVERNIGHT', 'default1', 0), (4, 'COMPLETED', 'default2', 1), (5, 'OVERNIGHT', 'RUSH', 1), (6, 'COMPLETED', 'default2', 1), (7, 'OVERNIGHT', 'RUSH', 1), (8, 'default2', 'RUSH', 0), (9, 'default1', 'RUSH', 2), (10, 'default1', 'default1', 0), (11, 'default1', 'COMPLETED', 2), (12, 'OVERNIGHT', 'default2', 2), (13, 'default1', 'RUSH', 0), (14, 'RUSH', 'default2', 2), (15, 'RUSH', 'COMPLETED', 1), (16, 'default1', 'OVERNIGHT', 1), (17, 'OVERNIGHT', 'default2', 1), (18, 'default1', 'COMPLETED', 1), (19, 'OVERNIGHT', 'default2', 1), (20, 'COMPLETED', 'RUSH', 0), (21, 'OVERNIGHT', 'default2', 1), (22, 'OVERNIGHT', 'OVERNIGHT', 2), (23, 'OVERNIGHT', 'default2', 1), (24, 'default2', 'default1', 0), (25, 'default1', 'default2', 1);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (0, 0, 'COMPLETED', 'OVERNIGHT', 'OVERNIGHT', -1.0), (1, 23, 'default1', 'RUSH', 'COMPLETED', 0.0), (2, 22, 'COMPLETED', 'COMPLETED', 'default2', 1.0), (3, 18, 'COMPLETED', 'default1', 'default1', 1.0), (4, 16, 'default2', 'default2', 'default1', -1.0), (5, 9, 'default2', 'default2', 'OVERNIGHT', 1.0), (6, 4, 'COMPLETED', 'RUSH', 'default2', -1.0), (7, 0, 'RUSH', 'default2', 'default2', 2.0), (8, 1, 'COMPLETED', 'OVERNIGHT', 'RUSH', 2.0), (9, 13, 'COMPLETED', 'COMPLETED', 'default1', -1.0), (10, 11, 'OVERNIGHT', 'OVERNIGHT', 'RUSH', 2.0), (11, 5, 'OVERNIGHT', 'OVERNIGHT', 'default2', -1.0), (12, 17, 'default2', 'OVERNIGHT', 'default1', -1.0), (13, 9, 'RUSH', 'default1', 'COMPLETED', 2.0), (14, 20, 'default1', 'OVERNIGHT', 'OVERNIGHT', 2.0), (15, 14, 'default2', 'OVERNIGHT', 'default2', -1.0), (16, 0, 'default2', 'default2', 'default1', -1.0), (17, 23, 'RUSH', 'COMPLETED', 'OVERNIGHT', 0.0), (18, 6, 'default2', 'default1', 'default2', 2.0), (19, 2, 'OVERNIGHT', 'COMPLETED', 'default1', -1.0), (20, 17, 'default2', 'default2', 'default2', 0.0), (21, 1, 'OVERNIGHT', 'default1', 'COMPLETED', 0.0), (22, 18, 'default1', 'RUSH', 'COMPLETED', -1.0), (23, 16, 'COMPLETED', 'OVERNIGHT', 'default1', 2.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.ryiyuk, c.djnfoa, COUNT(o.qdujuq) AS total_orders, COALESCE(SUM(o.hbhscc), 0.0) AS total_spend FROM nhosiz AS c LEFT JOIN ayzfwn AS o ON c.ryiyuk = o.ryiyuk AND o.ryqatk = 'COMPLETED' WHERE c.fomiuw = 1 GROUP BY c.ryiyuk, c.djnfoa;

/*
Gold Result:
(0, 'COMPLETED', 0, 0.0)
(4, 'COMPLETED', 0, 0.0)
(5, 'OVERNIGHT', 0, 0.0)
(6, 'COMPLETED', 0, 0.0)
(7, 'OVERNIGHT', 0, 0.0)
(15, 'RUSH', 0, 0.0)
(16, 'default1', 0, 0.0)
(17, 'OVERNIGHT', 0, 0.0)
(18, 'default1', 0, 0.0)
(19, 'OVERNIGHT', 0, 0.0)
(21, 'OVERNIGHT', 0, 0.0)
(23, 'OVERNIGHT', 1, 0.0)
(25, 'default1', 0, 0.0)
*/

-- Prediction Query
SELECT c.ryiyuk, c.djnfoa, COUNT(o.qdujuq) AS total_orders, COALESCE(SUM(o.hbhscc), 0.0) AS total_spend FROM nhosiz AS c LEFT JOIN ayzfwn AS o ON c.ryiyuk = o.ryiyuk AND o.ryqatk = 'COMPLETED' AND NOT o.padlzj IN ('RUSH', 'OVERNIGHT') WHERE c.fomiuw = 1 GROUP BY c.ryiyuk, c.djnfoa;

/*
Prediction Result:
(0, 'COMPLETED', 0, 0.0)
(4, 'COMPLETED', 0, 0.0)
(5, 'OVERNIGHT', 0, 0.0)
(6, 'COMPLETED', 0, 0.0)
(7, 'OVERNIGHT', 0, 0.0)
(15, 'RUSH', 0, 0.0)
(16, 'default1', 0, 0.0)
(17, 'OVERNIGHT', 0, 0.0)
(18, 'default1', 0, 0.0)
(19, 'OVERNIGHT', 0, 0.0)
(21, 'OVERNIGHT', 0, 0.0)
(23, 'OVERNIGHT', 0, 0.0)
(25, 'default1', 0, 0.0)
*/