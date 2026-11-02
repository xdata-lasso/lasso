-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
INSERT INTO cards (id, name, asciiName, faceName, flavorName, uuid) VALUES (10, 'Black Lotus', 'Lotus_ASCII', 'Lotus_Face', 'Lotus_Flavor', 'u_cmd_1');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, uuid) VALUES (20, 'Ancestral Recall', 'Recall_ASCII', 'Recall_Face', 'Recall_Flavor', 'u_cmd_2');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, uuid) VALUES (30, 'Time Walk', 'Walk_ASCII', 'Walk_Face', 'Walk_Flavor', 'u_cmd_3');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, uuid) VALUES (40, 'Oko, Thief of Crowns', 'Oko_ASCII', 'Oko_Face', 'Oko_Flavor', 'u_mod_1');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, uuid) VALUES (50, 'Oko, Thief of Crowns', 'Oko_ASCII_2', 'Oko_Face_2', 'Oko_Flavor_2', 'u_mod_2');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, uuid) VALUES (60, 'Omnath, Locus of Creation', 'Omnath_ASCII', 'Omnath_Face', 'Omnath_Flavor', 'u_std_1');
INSERT INTO cards (id, name, asciiName, faceName, flavorName, uuid) VALUES (1, 'Wrong ID Join Card', 'Wrong_ASCII', 'Wrong_Face', 'Wrong_Flavor', 'u_wrong_1');
INSERT INTO legalities (id, format, status, uuid) VALUES (1, 'Commander', 'Banned', 'u_cmd_1');
INSERT INTO legalities (id, format, status, uuid) VALUES (2, 'Commander', 'Banned', 'u_cmd_2');
INSERT INTO legalities (id, format, status, uuid) VALUES (3, 'Commander', 'Banned', 'u_cmd_3');
INSERT INTO legalities (id, format, status, uuid) VALUES (4, 'Modern', 'Banned', 'u_mod_1');
INSERT INTO legalities (id, format, status, uuid) VALUES (5, 'Modern', 'Banned', 'u_mod_2');
INSERT INTO legalities (id, format, status, uuid) VALUES (6, 'Standard', 'Banned', 'u_std_1');
INSERT INTO legalities (id, format, status, uuid) VALUES (7, 'Standard', 'Legal', 'u_cmd_1');
INSERT INTO legalities (id, format, status, uuid) VALUES (8, 'Standard', 'Legal', 'u_cmd_2');
INSERT INTO legalities (id, format, status, uuid) VALUES (9, 'Standard', 'Legal', 'u_cmd_3');
INSERT INTO legalities (id, format, status, uuid) VALUES (10, 'Standard', 'Restricted', 'u_mod_1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.format, T1.name FROM cards AS T1 INNER JOIN legalities AS T2 ON T2.uuid = T1.uuid WHERE T2.status = 'Banned' GROUP BY T2.format ORDER BY COUNT(T2.status) DESC, T2.format NULLS LAST, T1.name NULLS LAST LIMIT 1;

/*
Gold Result:
('Commander', 'Black Lotus')
*/

-- Prediction Query
SELECT l.format, c.name FROM legalities AS l JOIN cards AS c ON l.uuid = c.uuid WHERE l.status = 'Banned' AND l.format = (SELECT format FROM legalities WHERE status = 'Banned' GROUP BY format ORDER BY COUNT(*) DESC, format NULLS LAST LIMIT 1);

/*
Prediction Result:
('Commander', 'Black Lotus')
('Commander', 'Ancestral Recall')
('Commander', 'Time Walk')
*/