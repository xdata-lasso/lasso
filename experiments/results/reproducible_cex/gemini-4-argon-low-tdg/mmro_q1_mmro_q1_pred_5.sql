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
-- DATASET 1
-- Comprehensive dataset covering LEFT JOIN preservation, ON vs WHERE predicate placement,
-- COUNT(col) vs COUNT(*), COALESCE(SUM, 0.0) on NULLs, SUM(DISTINCT) vs SUM(ALL), and WHERE filtering.
INSERT INTO nhosiz (ryiyuk, djnfoa, xxiqyf, fomiuw) VALUES (1, 'Alice', 'TIER1', 1);
INSERT INTO nhosiz (ryiyuk, djnfoa, xxiqyf, fomiuw) VALUES (2, 'Bob', 'TIER2', 1);
INSERT INTO nhosiz (ryiyuk, djnfoa, xxiqyf, fomiuw) VALUES (3, 'Alice', 'TIER1', 1);
INSERT INTO nhosiz (ryiyuk, djnfoa, xxiqyf, fomiuw) VALUES (4, 'Diana', 'TIER3', 0);
INSERT INTO nhosiz (ryiyuk, djnfoa, xxiqyf, fomiuw) VALUES (5, 'Eve', 'TIER2', 2);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (101, 2, '2023-01-01', 'PENDING', 'STANDARD', 50.0);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (102, 3, '2023-01-02', 'COMPLETED', 'STANDARD', 25.5);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (103, 3, '2023-01-03', 'COMPLETED', 'EXPRESS', 25.5);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (104, 3, '2023-01-04', 'CANCELLED', 'STANDARD', 100.0);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (105, 4, '2023-01-05', 'COMPLETED', 'STANDARD', 75.0);
INSERT INTO ayzfwn (qdujuq, ryiyuk, tgelyf, ryqatk, padlzj, hbhscc) VALUES (106, 5, '2023-01-06', 'COMPLETED', 'STANDARD', 80.0);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT c.ryiyuk, c.djnfoa, COUNT(o.qdujuq) AS total_orders, COALESCE(SUM(o.hbhscc), 0.0) AS total_spend FROM nhosiz AS c LEFT JOIN ayzfwn AS o ON c.ryiyuk = o.ryiyuk AND o.ryqatk = 'COMPLETED' WHERE c.fomiuw = 1 GROUP BY c.ryiyuk, c.djnfoa;

/*
Gold Result:
(1, 'Alice', 0, 0.0)
(2, 'Bob', 0, 0.0)
(3, 'Alice', 2, 51.0)
*/

-- Prediction Query
SELECT c.ryiyuk, c.djnfoa, COUNT(o.qdujuq) AS total_orders, COALESCE(SUM(o.hbhscc), 1.0) AS total_spend FROM nhosiz AS c LEFT JOIN ayzfwn AS o ON c.ryiyuk = o.ryiyuk AND o.ryqatk = 'COMPLETED' WHERE c.fomiuw = 1 GROUP BY c.ryiyuk, c.djnfoa;

/*
Prediction Result:
(1, 'Alice', 0, 1.0)
(2, 'Bob', 0, 1.0)
(3, 'Alice', 2, 51.0)
*/