-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cards (id, artist, asciiname, availability, bordercolor, cardkingdomfoilid, cardkingdomid, coloridentity, colorindicator, colors, convertedmanacost, dueldeck, edhrecrank, faceconvertedmanacost, facename, flavorname, flavortext, frameeffects, frameversion, hand, hasalternativedecklimit, hascontentwarning, hasfoil, hasnonfoil, isalternative, isfullart, isonlineonly, isoversized, ispromo, isreprint, isreserved, isstarter, isstoryspotlight, istextless, istimeshifted, keywords, layout, leadershipskills, life, loyalty, manacost, mcmid, mcmmetaid, mtgarenaid, mtgjsonv4id, mtgofoilid, mtgoid, multiverseid, name, number, originalreleasedate, originaltext, originaltype, otherfaceids, power, printings, promotypes, purchaseurls, rarity, scryfallid, scryfallillustrationid, scryfalloracleid, setcode, side, subtypes, supertypes, tcgplayerproductid, text, toughness, type, types, uuid, variations, watermark) VALUES (1, '%B%', NULL, 'default1', NULL, '%B%', '%Artifact%', 'default2', 'Artifact', 'B', 1.0, 'Artifact', 1, 1.0, 'B', '%Artifact%', 'B', '%Artifact%', '%Artifact%', 'B', 1, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 'default1', '%B%', '%B%', '%B%', 'B', '%Artifact%', 'default1', 'Artifact', 'default1', 'Artifact', '%Artifact%', '%B%', 'default1', '%Artifact%', 'B', '%B%', '%B%', 'default1', '%Artifact%', '%Artifact%', '%Artifact%', '%B%', '%Artifact%', 'Artifact', '%B%', '%B%', '%Artifact%', 'B', '%B%', NULL, 'B', 'B', NULL, '%B%', 'B', '%B%', 'B', 'Artifact', 'Artifact'), (0, 'default1', 'default1', '%Artifact%', 'default2', '%B%', 'Artifact', NULL, '%B%', 'default1', 1.0, '%Artifact%', 1, 1.0, 'default2', 'Artifact', '%Artifact%', NULL, '%B%', NULL, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 'Artifact', 'Artifact', 'default1', NULL, NULL, 'default2', 'default2', 'Artifact', 'default1', 'default1', NULL, NULL, '%Artifact%', NULL, 'default1', 'default2', '%Artifact%', '%B%', 'default2', 'default2', 'default2', NULL, 'Artifact', NULL, 'default2', 'B', 'B', 'B', '%B%', 'Artifact', 'default2', 'B', '%Artifact%', 'default1', '%B%', 'default1', 'Artifact', '%B%', 'default2'), (2, 'default1', '%Artifact%', '%Artifact%', NULL, 'default1', 'B', NULL, 'Artifact', 'B', 1.0, 'B', NULL, 0.0, '%B%', 'default2', 'default2', '%Artifact%', 'default2', 'B', 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1, NULL, 'B', 'default1', 'B', 'default1', 'B', 'Artifact', 'default2', '%Artifact%', '%Artifact%', '%B%', 'default1', 'B', 'B', '%Artifact%', '%B%', '%B%', '%B%', 'Artifact', 'default1', NULL, 'default2', 'default1', NULL, 'default1', 'Artifact', 'Artifact', NULL, 'B', 'B', NULL, 'Artifact', 'default2', 'default2', '%B%', 'Artifact', '%Artifact%', NULL, 'default2');
INSERT INTO foreign_data (id, uuid, flavortext, language, multiverseid, name, text, type) VALUES (0, 'B', '%B%', '%Artifact%', 0, NULL, '%Artifact%', NULL), (1, '%Artifact%', 'default1', 'default1', 0, '%Artifact%', 'Artifact', 'default2');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM cards AS T1 INNER JOIN foreign_data AS T2 ON T1.uuid = T2.uuid WHERE T1.originalType = 'Artifact' AND T1.colors = 'B';

/*
Gold Result:
*/

-- Prediction Query
SELECT DISTINCT T1.name FROM cards AS T1 JOIN foreign_data AS T2 ON T1.uuid = T2.uuid WHERE T1.types LIKE '%Artifact%' AND T1.colors LIKE '%B%';

/*
Prediction Result:
('B',)
*/