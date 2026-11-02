-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cards (id, artist, asciiname, availability, bordercolor, cardkingdomfoilid, cardkingdomid, coloridentity, colorindicator, colors, convertedmanacost, dueldeck, edhrecrank, faceconvertedmanacost, facename, flavorname, flavortext, frameeffects, frameversion, hand, hasalternativedecklimit, hascontentwarning, hasfoil, hasnonfoil, isalternative, isfullart, isonlineonly, isoversized, ispromo, isreprint, isreserved, isstarter, isstoryspotlight, istextless, istimeshifted, keywords, layout, leadershipskills, life, loyalty, manacost, mcmid, mcmmetaid, mtgarenaid, mtgjsonv4id, mtgofoilid, mtgoid, multiverseid, name, number, originalreleasedate, originaltext, originaltype, otherfaceids, power, printings, promotypes, purchaseurls, rarity, scryfallid, scryfallillustrationid, scryfalloracleid, setcode, side, subtypes, supertypes, tcgplayerproductid, text, toughness, type, types, uuid, variations, watermark) VALUES (101, 'default1', 'default2', 'default1', 'Spanish', 'Spanish', 'Spanish', 'default1', 'default2', NULL, 1.0, NULL, 100, 0.0, 'default2', 'Spanish', 'default2', 'Spanish', NULL, 'default2', 2, -1, 100, -1, 101, 100, 2, 99, 100, 100, 1, -1, 99, 101, 2, 'Spanish', 'default2', 'default2', 'Spanish', 'default1', 'Spanish', 'default1', 'default2', 'Spanish', NULL, NULL, 'default1', NULL, 'Spanish', 'default2', 'Spanish', 'default2', NULL, 'Spanish', 'default1', 'default2', NULL, 'Spanish', NULL, 'default1', 'default1', NULL, 'default2', 'default1', NULL, NULL, NULL, 'default2', 'Spanish', 'Spanish', 'Spanish', 'default1', 'Spanish', 'Spanish'), (99, 'Spanish', NULL, 'default1', 'default1', 'Spanish', 'Spanish', 'default2', 'default2', NULL, 99.0, 'default1', 0, 101.0, 'Spanish', 'default1', NULL, 'Spanish', NULL, 'Spanish', 1, 99, 0, 2, 101, 1, 2, -1, 0, 1, -1, 99, 1, 1, 0, NULL, NULL, 'default1', 'Spanish', 'Spanish', 'default1', NULL, 'default2', 'default1', NULL, NULL, NULL, NULL, NULL, 'Spanish', 'default2', NULL, 'Spanish', NULL, 'default1', 'Spanish', NULL, NULL, 'Spanish', 'default2', 'Spanish', 'default1', NULL, NULL, 'Spanish', 'default1', 'Spanish', 'default2', 'default1', 'default2', NULL, 'default2', NULL, 'default2'), (-1, NULL, 'default1', NULL, 'Spanish', NULL, 'Spanish', NULL, 'default2', 'Spanish', 0.0, 'default1', 1, 100.0, NULL, NULL, 'default1', NULL, 'default2', 'default1', 101, 100, 0, 0, 1, 2, 100, -1, 100, 99, 0, 0, -1, 1, 99, NULL, NULL, 'Spanish', NULL, 'default1', NULL, 'default2', 'default1', 'Spanish', NULL, 'default2', 'default2', NULL, NULL, 'Spanish', 'default2', 'Spanish', 'default1', 'Spanish', NULL, 'Spanish', 'Spanish', 'Spanish', 'Spanish', 'default1', NULL, 'Spanish', 'default2', 'Spanish', 'default1', 'default1', NULL, 'Spanish', 'default1', 'default1', 'Spanish', 'Spanish', NULL, 'Spanish');
INSERT INTO foreign_data (id, uuid, flavortext, language, multiverseid, name, text, type) VALUES (101, 'Spanish', 'default2', 'Spanish', 2, 'default2', NULL, 'default2'), (1, 'default1', 'Spanish', 'Spanish', 100, 'default2', 'default1', 'Spanish'), (2, 'default1', 'default1', NULL, 1, 'default2', 'default1', 'Spanish');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT (SELECT CAST(SUM(CASE WHEN language = 'Spanish' THEN 1 ELSE 0 END) AS REAL) * 100 / COUNT(*) FROM foreign_data), name FROM foreign_data WHERE language = 'Spanish';

/*
Gold Result:
(66.66666666666667, 'default2')
(66.66666666666667, 'default2')
*/

-- Prediction Query
SELECT name, (COUNT(*) FILTER(WHERE language = 'Spanish') * 100.0 / COUNT(*)) AS percentage FROM foreign_data GROUP BY name;

/*
Prediction Result:
('default2', 66.66666666666667)
*/