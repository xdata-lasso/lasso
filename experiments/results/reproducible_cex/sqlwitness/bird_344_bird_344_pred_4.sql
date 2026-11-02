-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cards (id, artist, asciiname, availability, bordercolor, cardkingdomfoilid, cardkingdomid, coloridentity, colorindicator, colors, convertedmanacost, dueldeck, edhrecrank, faceconvertedmanacost, facename, flavorname, flavortext, frameeffects, frameversion, hand, hasalternativedecklimit, hascontentwarning, hasfoil, hasnonfoil, isalternative, isfullart, isonlineonly, isoversized, ispromo, isreprint, isreserved, isstarter, isstoryspotlight, istextless, istimeshifted, keywords, layout, leadershipskills, life, loyalty, manacost, mcmid, mcmmetaid, mtgarenaid, mtgjsonv4id, mtgofoilid, mtgoid, multiverseid, name, number, originalreleasedate, originaltext, originaltype, otherfaceids, power, printings, promotypes, purchaseurls, rarity, scryfallid, scryfallillustrationid, scryfalloracleid, setcode, side, subtypes, supertypes, tcgplayerproductid, text, toughness, type, types, uuid, variations, watermark) VALUES (1, 'default2', 'default2', 'Banned', 'default1', 'gladiator', 'default2', NULL, NULL, 'default1', 0.0, 'gladiator', 0, NULL, 'gladiator', 'mythic', NULL, 'Banned', 'default2', 'mythic', 0, 1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 'Banned', 'mythic', 'gladiator', 'mythic', 'Banned', 'Banned', 'default1', 'default1', 'mythic', 'gladiator', NULL, NULL, 'default2', 'Banned', 'Banned', 'Banned', 'mythic', 'mythic', 'default2', 'gladiator', 'Banned', 'Banned', 'Banned', 'default2', 'mythic', NULL, 'Banned', 'mythic', 'default1', 'default1', 'gladiator', 'mythic', 'default2', 'default2', 'mythic', 'default1', 'default2', 'Banned', NULL), (0, 'default1', NULL, 'mythic', 'Banned', 'Banned', 'default1', 'default1', 'mythic', NULL, 0.0, 'mythic', NULL, 0.0, NULL, NULL, 'default2', 'default1', 'gladiator', 'default1', 0, 1, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 'mythic', 'gladiator', 'gladiator', 'default2', NULL, 'gladiator', 'default1', NULL, 'mythic', NULL, NULL, 'mythic', 'mythic', 'gladiator', 'default2', NULL, 'Banned', 'default2', 'gladiator', 'default1', NULL, 'Banned', NULL, 'mythic', 'mythic', NULL, 'gladiator', 'default2', 'default2', 'default2', 'default1', 'default2', 'default1', 'gladiator', 'default1', 'gladiator', 'default1', 'Banned', NULL), (2, 'default2', 'mythic', 'default1', 'mythic', 'default1', 'default1', 'mythic', 'gladiator', 'default1', 0.0, 'mythic', NULL, 1.0, 'default1', 'default2', 'default2', 'Banned', 'mythic', 'gladiator', 0, 1, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 'default1', 'default1', 'default2', 'gladiator', 'default2', NULL, 'default2', 'default2', 'default1', NULL, 'default1', 'default2', 'gladiator', 'mythic', 'Banned', 'default1', 'Banned', 'mythic', NULL, 'gladiator', 'Banned', NULL, 'default2', 'default2', 'gladiator', 'gladiator', 'Banned', 'mythic', 'mythic', NULL, 'default2', 'default2', 'default1', 'Banned', 'default2', 'default1', 'mythic', 'default1', 'mythic');
INSERT INTO legalities (id, uuid, format, status) VALUES (0, NULL, 'default1', 'mythic'), (1, 'mythic', 'default1', 'Banned'), (2, 'mythic', 'gladiator', 'mythic'), (3, 'default1', NULL, 'Banned'), (4, NULL, NULL, 'gladiator'), (5, 'default1', 'gladiator', 'default1'), (6, 'default1', 'default2', 'default1'), (7, 'default1', 'gladiator', 'Banned'), (8, 'default2', 'gladiator', 'default1'), (9, NULL, 'gladiator', 'Banned');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.id FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid WHERE T2.format = 'gladiator' AND T2.status = 'Banned' AND T1.rarity = 'mythic';

/*
Gold Result:
(0,)
*/

-- Prediction Query
SELECT T1.uuid FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid WHERE T1.rarity = 'mythic' AND T2.format = 'gladiator' AND T2.status = 'Banned';

/*
Prediction Result:
('default1',)
*/