-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cards (id, artist, asciiname, availability, bordercolor, cardkingdomfoilid, cardkingdomid, coloridentity, colorindicator, colors, convertedmanacost, dueldeck, edhrecrank, faceconvertedmanacost, facename, flavorname, flavortext, frameeffects, frameversion, hand, hasalternativedecklimit, hascontentwarning, hasfoil, hasnonfoil, isalternative, isfullart, isonlineonly, isoversized, ispromo, isreprint, isreserved, isstarter, isstoryspotlight, istextless, istimeshifted, keywords, layout, leadershipskills, life, loyalty, manacost, mcmid, mcmmetaid, mtgarenaid, mtgjsonv4id, mtgofoilid, mtgoid, multiverseid, name, number, originalreleasedate, originaltext, originaltype, otherfaceids, power, printings, promotypes, purchaseurls, rarity, scryfallid, scryfallillustrationid, scryfalloracleid, setcode, side, subtypes, supertypes, tcgplayerproductid, text, toughness, type, types, uuid, variations, watermark) VALUES (1, NULL, 'default1', 'Legal', NULL, 'default2', 'default2', 'Creature', NULL, 'legal', 0.0, 'Legal', 1, NULL, 'Creature', 'default2', NULL, NULL, 'Creature', 'legal', 1, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 'default1', 'default1', 'legal', 'default1', 'Legal', 'Creature', 'legal', NULL, 'default2', 'default1', NULL, 'default1', 'Legal', 'default1', 'legal', '%Creature%', 'Legal', NULL, 'Legal', 'default2', NULL, NULL, 'Creature', 'Legal', 'default2', 'default1', 'Legal', 'default2', '%Creature%', 'default1', '%Creature%', 'default1', 'default1', 'legal', '%Creature%', 'default1', 'Legal', '%Creature%', '%Creature%'), (0, 'default1', NULL, NULL, 'Legal', 'default2', NULL, 'default2', 'legal', 'legal', 0.0, 'default1', NULL, 1.0, '%Creature%', 'legal', 'Creature', 'legal', 'default2', NULL, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 1, 'Creature', 'default2', 'default1', 'legal', 'default1', 'default2', 'Legal', NULL, 'Legal', '%Creature%', 'Legal', '%Creature%', 'legal', 'Legal', 'default2', 'legal', 'default2', '%Creature%', 'Legal', 'default1', '%Creature%', 'legal', '%Creature%', NULL, 'default1', 'default2', '%Creature%', 'legal', 'legal', '%Creature%', NULL, 'Legal', 'default1', NULL, NULL, 'Creature', '%Creature%', 'default2', 'default1');
INSERT INTO rulings (id, uuid, date, text) VALUES (0, 'Legal', '2023-01-01', NULL), (1, NULL, '2023-01-02', 'default1'), (2, 'Legal', '2023-01-01', 'default2'), (3, '%Creature%', '2023-01-01', 'Legal'), (4, 'Legal', '2023-01-02', NULL), (5, 'Legal', '2023-01-02', 'Creature'), (6, '%Creature%', NULL, 'legal'), (7, '%Creature%', '2023-01-02', 'Creature'), (8, '%Creature%', '2023-01-02', 'legal'), (9, '%Creature%', '2023-01-02', 'legal'), (10, 'Legal', NULL, '%Creature%'), (11, '%Creature%', '2023-01-01', 'legal'), (12, 'Legal', '2023-01-02', 'Creature'), (13, '%Creature%', NULL, '%Creature%');
INSERT INTO legalities (id, uuid, format, status) VALUES (1, '%Creature%', 'Legal', 'Legal'), (0, 'Legal', 'default1', '%Creature%'), (2, 'Legal', 'default1', 'default1'), (3, NULL, NULL, 'default2'), (4, 'Legal', NULL, 'default1'), (5, NULL, 'default1', 'default2'), (6, '%Creature%', 'Creature', 'Legal'), (7, '%Creature%', 'legal', NULL), (8, NULL, 'default1', 'legal'), (9, NULL, 'Creature', 'legal'), (10, 'Legal', 'legal', 'default1'), (11, NULL, 'Creature', 'default2'), (12, NULL, '%Creature%', 'Legal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.id FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid INNER JOIN legalities AS T3 ON T1.uuid = T3.uuid WHERE T3.status = 'Legal' AND T1.types = 'Creature';

/*
Gold Result:
(0,)
(0,)
(0,)
(0,)
(0,)
(0,)
(0,)
(0,)
(0,)
(0,)
(0,)
(0,)
(0,)
(0,)
*/

-- Prediction Query
SELECT cards.id FROM cards INNER JOIN legalities ON cards.uuid = legalities.uuid WHERE legalities.status = 'legal' AND cards.types LIKE '%Creature%';

/*
Prediction Result:
*/