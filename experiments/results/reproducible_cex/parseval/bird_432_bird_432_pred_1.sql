-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- Inserting into table: sets --
INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (1, -55602865, 'swwqcgsk', '9n8c4pgu7v', 't1__227fe9', -1865039888, 1160656988, -992890117, 1914020640, 1268590800, 'puzhsrw', 1908028688, 2122220075, 'p6luhvdlttil', 'n', 'rmdp', 'siie', '2025-06-27', -1209887326, -1399556171, 'a9000t5c4eci');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (0, -443340271, 'uo4nrqrofqy', '5s5b', '@', 2107872094, 882961052, 743312762, -1822992503, -868774469, 'qa1', 2074205376, 274769912, 'oo3o9', 'l7', 'klex14ji', '7zwau2dwyr', '2022-12-09', -1097120355, 244829661, 'jsl');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483646, -346339240, 'yp5qi2rk', '9v', 'A', 556727997, 1178000634, 1836127587, -1529584866, 1196308825, 'd21vy9uxj4hw', -2050247126, -736979194, 'h2gn', 'q', 'nqcx5h', 'cprj', '2023-05-30', -792947627, -1898531797, '9fjgq8n2f');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483645, 638024588, '6vck6ah0f8js', 'wlq7xb', 'code_4', 602161869, 1350414441, 2094425101, -961217731, -1888505890, 'z16nijjai5d', -1625552518, -1738458256, 'jd', 'yzt1afgog', 'itsj3', 'y', '2024-01-17', -106471771, 1235416111, 'jh3den8');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483644, 1523825314, 'u5', '1of77p', 'code_5', -435350511, 1992637800, -820614248, 481546706, -1784554553, '2g0v5q8qd', 569007824, -1139855872, 'io22785', '7cvtjpt', 'tg6bnou5zi', '6c4bfkfo', '2020-02-20', 382831862, -406331049, 'ezjo7wg');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483643, -405743609, 'g', '5i3', 'code_6', -1405314653, 1816660482, -1212676731, 1692046802, -1300180872, '58q', 1817366143, 1615073310, '7p2r94gth2m', 'ajjl', '3', 'okv8uttmu2', '2022-05-03', -1817527403, -1402164108, 'yz7zzb');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (-2147483642, 1043710187, '42q7sx58b4', 'pmaus3auvmkr', 't2__b43f67', 609771851, -1934017803, 1105964624, -663234145, -2013213247, '9mo7', -354292049, 238533676, 'jxfofws', 'do2zobb', 'q0k32od', 'cl5ams', '2022-07-13', -984562992, -605061107, 'gc1d');

INSERT INTO "sets" ("id", "basesetsize", "block", "booster", "code", "isfoilonly", "isforeignonly", "isnonfoilonly", "isonlineonly", "ispartialpreview", "keyrunecode", "mcmid", "mcmidextras", "mcmname", "mtgocode", "name", "parentcode", "releasedate", "tcgplayergroupid", "totalsetsize", "type") VALUES (3, 1, '5k5swwqcgs', '9n8', 'code_8', 1610062532, -106629402, 1871297066, 809183447, 89267185, 'e4', 1160656988, -992890117, 'a2ypuzhsrwbb', 'p6luhvdlttil', 'n', 'rmdp', '2022-07-21', -918961358, -1602639011, 'unw6klfa');

-- Inserting into table: set_translations --
INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483648, 'Russian', 't1__227fe9', 'gce376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483647, 'Russian', 'A', 'dqv0gcb9');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483646, 'Russian', 'A', 'k3zbily');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483645, 'Russian', 'A', 'c68x8vacx7');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483644, 'Russian', 'A', 'd5ysxc');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (-2147483643, 'Russian', 'A', '8y');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (2, 'Russian', 't2__b43f67', 'j9erhizgk1');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (3, 'Russian', 't2__b43f67', 'yoeyo6l0hdt6');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (4, 'Russian', 't2__b43f67', '00t5c4ecigc');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (5, 'Russian', 't1__227fe9', 'e376nium52');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (6, 't2__ad5611', 't1__227fe9', 'zbuo4nrqrof');

INSERT INTO "set_translations" ("id", "language", "setcode", "translation") VALUES (7, NULL, 't1__227fe9', 'qyp5s5bbp0');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.id FROM sets AS T1 INNER JOIN set_translations AS T2 ON T1.code = T2.setCode WHERE T2.language = 'Russian' GROUP BY T1.baseSetSize ORDER BY COUNT(T1.id) DESC, T1.id NULLS LAST LIMIT 1;

/*
Gold Result:
(-2147483646,)
*/

-- Prediction Query
SELECT name FROM sets WHERE code IN (SELECT setCode FROM set_translations WHERE language = 'Russian') AND baseSetSize = (SELECT MAX(baseSetSize) FROM sets WHERE code IN (SELECT setCode FROM set_translations WHERE language = 'Russian')) LIMIT 1;

/*
Prediction Result:
('q0k32od',)
*/