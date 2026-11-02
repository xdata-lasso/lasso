-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cards (id, artist, asciiname, availability, bordercolor, cardkingdomfoilid, cardkingdomid, coloridentity, colorindicator, colors, convertedmanacost, dueldeck, edhrecrank, faceconvertedmanacost, facename, flavorname, flavortext, frameeffects, frameversion, hand, hasalternativedecklimit, hascontentwarning, hasfoil, hasnonfoil, isalternative, isfullart, isonlineonly, isoversized, ispromo, isreprint, isreserved, isstarter, isstoryspotlight, istextless, istimeshifted, keywords, layout, leadershipskills, life, loyalty, manacost, mcmid, mcmmetaid, mtgarenaid, mtgjsonv4id, mtgofoilid, mtgoid, multiverseid, name, number, originalreleasedate, originaltext, originaltype, otherfaceids, power, printings, promotypes, purchaseurls, rarity, scryfallid, scryfallillustrationid, scryfalloracleid, setcode, side, subtypes, supertypes, tcgplayerproductid, text, toughness, type, types, uuid, variations, watermark) VALUES (0, '%*%', 'default2', 'French', 'French', '*', 'French', 'French', 'French', '*', 0.0, '*', 99, 0.0, NULL, '%*%', '%*%', 'default2', '%*%', '*', 101, 2, 99, 99, 101, -1, 100, 2, 100, -1, 101, 0, 0, 101, 101, 'French', '*', '*', 'French', '*', NULL, 'default2', '%*%', '*', '%*%', NULL, 'French', 'French', 'French', NULL, 'French', '%*%', 'default2', 'French', '*', 'default2', 'French', '%*%', 'default2', '*', NULL, 'French', '%*%', '%*%', 'default2', '%*%', 'default2', '%*%', '%*%', '*', '*', 'default1', '*', '*'), (-1, '%*%', '*', '*', '*', '*', 'default1', NULL, 'French', '*', NULL, 'default2', 99, 100.0, 'French', '*', 'default1', '%*%', 'default1', 'default1', 2, 2, 100, 100, 101, 2, 0, 99, 2, 100, 99, 101, -1, 99, 2, 'default1', 'French', 'French', 'default1', '*', NULL, NULL, '%*%', 'default2', '%*%', 'default1', '*', NULL, '*', 'default2', 'French', '%*%', '*', '*', '*', NULL, 'French', '*', '*', NULL, 'default2', NULL, 'default2', 'default1', NULL, NULL, NULL, 'default1', '%*%', NULL, '*', '%*%', 'default2', 'French');
INSERT INTO foreign_data (id, uuid, flavortext, language, multiverseid, name, text, type) VALUES (101, '%*%', NULL, 'French', -1, '%*%', '%*%', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(SUM(CASE WHEN T2.language = 'French' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(T1.id) FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T1.uuid = T2.uuid WHERE T1.power IS NULL OR T1.power LIKE '%*%';

/*
Gold Result:
(100.0,)
*/

-- Prediction Query
SELECT CAST(SUM(CASE WHEN "foreign_data"."language" = 'French' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT("cards"."id") FROM "cards" LEFT JOIN "foreign_data" ON "cards"."uuid" = "foreign_data"."uuid" WHERE "cards"."power" IS NULL OR "cards"."power" = '*';

/*
Prediction Result:
(50.0,)
*/