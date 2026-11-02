-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cards (id, artist, asciiname, availability, bordercolor, cardkingdomfoilid, cardkingdomid, coloridentity, colorindicator, colors, convertedmanacost, dueldeck, edhrecrank, faceconvertedmanacost, facename, flavorname, flavortext, frameeffects, frameversion, hand, hasalternativedecklimit, hascontentwarning, hasfoil, hasnonfoil, isalternative, isfullart, isonlineonly, isoversized, ispromo, isreprint, isreserved, isstarter, isstoryspotlight, istextless, istimeshifted, keywords, layout, leadershipskills, life, loyalty, manacost, mcmid, mcmmetaid, mtgarenaid, mtgjsonv4id, mtgofoilid, mtgoid, multiverseid, name, number, originalreleasedate, originaltext, originaltype, otherfaceids, power, printings, promotypes, purchaseurls, rarity, scryfallid, scryfallillustrationid, scryfalloracleid, setcode, side, subtypes, supertypes, tcgplayerproductid, text, toughness, type, types, uuid, variations, watermark) VALUES (1, 'default1', 'default2', 'Creature', 'Creature', 'Legal', 'Creature', 'Legal', 'default2', 'Creature', 1.0, 'Creature', NULL, 1.0, 'default2', 'Legal', 'default1', 'default2', 'Legal', 'Legal', 0, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 'Legal', 'default2', 'default1', NULL, 'Creature', NULL, 'default1', 'Creature', 'Creature', 'Legal', 'default1', 'Creature', 'Legal', 'default2', 'default1', 'Creature', NULL, NULL, 'default1', NULL, 'Legal', 'default1', 'default1', 'Creature', 'default1', 'default1', 'default2', 'default2', 'default1', 'default2', 'default1', 'Creature', 'Creature', 'Creature', 'Legal', 'Creature', 'default1', 'Creature', 'default1');
INSERT INTO rulings (id, uuid, date, text) VALUES (1, 'default1', NULL, 'default2'), (0, NULL, '2023-01-01', 'default2'), (2, 'default1', '2023-01-02', 'default2'), (3, 'default1', NULL, 'Legal'), (4, NULL, '2023-01-02', NULL), (5, 'default1', '2023-01-01', 'default1'), (6, NULL, NULL, 'default1'), (7, NULL, NULL, 'Legal'), (8, 'default1', '2023-01-02', 'Legal'), (9, 'default1', NULL, 'default1'), (10, 'default1', NULL, 'Creature'), (11, NULL, '2023-01-01', 'default1'), (12, NULL, '2023-01-01', 'Creature'), (13, 'default1', '2023-01-01', NULL), (14, NULL, NULL, 'default2'), (15, NULL, '2023-01-01', 'Creature'), (16, 'default1', '2023-01-02', 'Creature'), (17, NULL, NULL, 'Legal');
INSERT INTO legalities (id, uuid, format, status) VALUES (1, 'default1', 'Legal', 'default1'), (0, 'default1', 'default2', 'default1'), (2, 'default1', 'Legal', NULL), (3, 'default1', 'Creature', 'default1'), (4, NULL, 'default2', 'default1'), (5, NULL, 'default2', 'Creature'), (6, 'default1', 'default2', 'Creature'), (7, NULL, 'Legal', NULL), (8, 'default1', NULL, 'Creature'), (9, NULL, 'Legal', 'Creature'), (10, NULL, 'default2', NULL), (11, NULL, 'Creature', NULL), (12, NULL, NULL, 'Creature'), (13, NULL, 'Creature', 'default2'), (14, NULL, 'default1', 'Creature'), (15, 'default1', 'default2', 'Creature'), (16, 'default1', 'Creature', 'default1'), (17, 'default1', NULL, 'default1'), (18, 'default1', 'default1', NULL), (19, 'default1', 'default1', 'default2'), (20, NULL, 'default1', NULL), (21, 'default1', 'Legal', 'Legal'), (22, NULL, 'default2', 'Legal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.id FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid INNER JOIN legalities AS T3 ON T1.uuid = T3.uuid WHERE T3.status = 'Legal' AND T1.types = 'Creature';

/*
Gold Result:
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
(1,)
*/

-- Prediction Query
SELECT T1.id FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid WHERE T1.types = 'Creature' AND T2.status = 'Legal';

/*
Prediction Result:
(1,)
*/