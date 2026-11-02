-- Schema DDL
CREATE TABLE "i048" ("CName" TEXT, "AddressID" INTEGER, "AddressLine" TEXT);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: i048 --
INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', 1, '5k5swwqcgs');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', 1, '9n8');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', 1, '4');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('lhs_6338de', 1, 'lhs_ef1a0e');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', 1, 'gu7v');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', 1, 'e4');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', 1160656988, 'ia2yp');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('lhs_6338de', 1, 'lhs_ef1a0e');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('lhs_cc032f', 1, 'lhs_218f7a');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('uzhsrwbbp6lu', 1019800248, NULL);

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, NULL);

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, NULL);

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, NULL);

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('lhs_6338de', 1, NULL);

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES (NULL, -1910425938, 'tilbn');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES (NULL, NULL, 'rmdp');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES (NULL, NULL, 'siie');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES (NULL, NULL, 'unw6klfa');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES (NULL, 1, 'lhs_ef1a0e');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('9000t5c4ec', NULL, 'gce');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, '76nium52');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, 'zbuo4nrqrof');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, 'qyp5s5bbp0');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('lhs_6338de', 1, 'lhs_ef1a0e');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, '2eutliqa11r');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, 'ytoo3o9');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, 'l7');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('lhs_6338de', 1, 'lhs_ef1a0e');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, 'klex14ji');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, '7zwau2dwyr');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, '13pyu');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('lhs_6338de', 1, 'lhs_ef1a0e');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, '8d99rljsl');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, 'b4yp5qi');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('i04_10424c', NULL, 'rkf9vqx5');

INSERT INTO "i048" ("cname", "addressid", "addressline") VALUES ('lhs_6338de', 1, 'lhs_ef1a0e');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT cname, addressid AS minaddressid, addressline FROM (SELECT LHS.cname AS cname, LHS.addressid AS addressid, LHS.addressline AS addressline, RHS.cname AS cname_other FROM i048 AS LHS INNER JOIN (SELECT cname, MIN(addressid) AS minaddressid FROM i048 GROUP BY cname) AS RHS ON (LHS.addressid = RHS.minaddressid)) ORDER BY cname, minaddressid NULLS LAST, addressline NULLS LAST;

/*
Gold Result:
(None, -1910425938, 'tilbn')
(None, 1, 'lhs_ef1a0e')
(None, 1, 'lhs_ef1a0e')
(None, 1, 'lhs_ef1a0e')
('i04_10424c', 1, '4')
('i04_10424c', 1, '4')
('i04_10424c', 1, '4')
('i04_10424c', 1, '5k5swwqcgs')
('i04_10424c', 1, '5k5swwqcgs')
('i04_10424c', 1, '5k5swwqcgs')
('i04_10424c', 1, '9n8')
('i04_10424c', 1, '9n8')
('i04_10424c', 1, '9n8')
('i04_10424c', 1, 'e4')
('i04_10424c', 1, 'e4')
('i04_10424c', 1, 'e4')
('i04_10424c', 1, 'gu7v')
('i04_10424c', 1, 'gu7v')
('i04_10424c', 1, 'gu7v')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, None)
('lhs_6338de', 1, None)
('lhs_6338de', 1, None)
('lhs_cc032f', 1, 'lhs_218f7a')
('lhs_cc032f', 1, 'lhs_218f7a')
('lhs_cc032f', 1, 'lhs_218f7a')
('uzhsrwbbp6lu', 1019800248, None)
*/

-- Prediction Query
SELECT M.CName, first, M.AddressLine FROM (SELECT CName, MIN(AddressID) AS First FROM i048 GROUP BY CName) AS foo JOIN i048 AS M ON foo.CName = M.CName AND foo.First = M.AddressID;

/*
Prediction Result:
('i04_10424c', 1, '5k5swwqcgs')
('i04_10424c', 1, '9n8')
('i04_10424c', 1, '4')
('lhs_6338de', 1, 'lhs_ef1a0e')
('i04_10424c', 1, 'gu7v')
('i04_10424c', 1, 'e4')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_cc032f', 1, 'lhs_218f7a')
('uzhsrwbbp6lu', 1019800248, None)
('lhs_6338de', 1, None)
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
('lhs_6338de', 1, 'lhs_ef1a0e')
*/