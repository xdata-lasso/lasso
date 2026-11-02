-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cards (id, artist, asciiname, availability, bordercolor, cardkingdomfoilid, cardkingdomid, coloridentity, colorindicator, colors, convertedmanacost, dueldeck, edhrecrank, faceconvertedmanacost, facename, flavorname, flavortext, frameeffects, frameversion, hand, hasalternativedecklimit, hascontentwarning, hasfoil, hasnonfoil, isalternative, isfullart, isonlineonly, isoversized, ispromo, isreprint, isreserved, isstarter, isstoryspotlight, istextless, istimeshifted, keywords, layout, leadershipskills, life, loyalty, manacost, mcmid, mcmmetaid, mtgarenaid, mtgjsonv4id, mtgofoilid, mtgoid, multiverseid, name, number, originalreleasedate, originaltext, originaltype, otherfaceids, power, printings, promotypes, purchaseurls, rarity, scryfallid, scryfallillustrationid, scryfalloracleid, setcode, side, subtypes, supertypes, tcgplayerproductid, text, toughness, type, types, uuid, variations, watermark) VALUES (2, NULL, 'mythic', NULL, 'Legal', 'mythic', NULL, 'default2', 'default1', NULL, NULL, 'default2', 0, 1.0, NULL, 'default1', 'mythic', 'default2', 'default1', 'mythic', 0, 0, 0, 0, 0, 2, 2, 2, 1, 2, 2, 2, 1, 2, 2, 'default1', 'default1', 'mythic', 'default1', 'default1', 'default1', 'default1', NULL, 'default2', 'mythic', NULL, 'default2', 'mythic', 'default1', NULL, 'mythic', 'mythic', 'mythic', 'Legal', NULL, NULL, 'mythic', 'default1', 'mythic', 'default1', 'default2', NULL, 'Legal', 'Legal', 'Legal', NULL, 'mythic', NULL, NULL, NULL, 'default1', 'default1', 'default2', 'mythic'), (0, NULL, 'default2', 'Legal', 'mythic', 'Legal', 'default1', 'default1', 'mythic', 'Legal', 1.0, 'default2', 1, 0.0, NULL, 'Legal', 'default2', 'default1', NULL, 'default2', 1, 1, 2, 1, 2, 0, 1, 2, 2, 2, 1, 1, 1, 2, 2, NULL, 'mythic', 'mythic', NULL, 'default1', 'Legal', 'default2', 'mythic', 'mythic', 'mythic', 'mythic', NULL, 'Legal', 'default2', 'default1', 'mythic', NULL, 'mythic', NULL, 'default1', NULL, NULL, 'default2', 'mythic', NULL, 'default1', NULL, NULL, NULL, 'default1', 'Legal', NULL, NULL, 'default1', 'default1', 'Legal', 'mythic', 'Legal', NULL), (1, NULL, 'default2', 'Legal', NULL, 'default1', 'default2', 'Legal', NULL, 'mythic', 2.0, 'mythic', NULL, 2.0, 'default1', 'Legal', 'default2', NULL, 'mythic', 'Legal', 1, 1, 2, 1, 2, 1, 0, 0, 0, 0, 1, 2, 1, 2, 1, 'Legal', 'mythic', 'default1', 'mythic', 'default2', 'default2', 'default2', NULL, 'mythic', NULL, 'default2', 'Legal', 'default2', 'mythic', 'default1', 'Legal', 'default1', 'default1', 'mythic', 'default1', NULL, 'mythic', 'default1', 'default1', NULL, 'Legal', 'default2', NULL, 'default1', 'mythic', 'default2', NULL, 'mythic', 'Legal', 'default2', NULL, 'Legal', NULL, 'default1');
INSERT INTO legalities (id, uuid, format, status) VALUES (0, 'default1', 'default1', 'default2'), (1, NULL, 'default2', NULL), (2, 'Legal', 'Legal', 'Legal');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.originalReleaseDate, T2.format FROM cards AS T1 INNER JOIN legalities AS T2 ON T1.uuid = T2.uuid WHERE T1.rarity = 'mythic' AND NOT T1.originalReleaseDate IS NULL AND T2.status = 'Legal' ORDER BY T1.originalReleaseDate, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 1;

/*
Gold Result:
*/

-- Prediction Query
SELECT c.originalReleaseDate, l.format FROM cards AS c INNER JOIN legalities AS l ON c.uuid = l.uuid WHERE c.rarity = 'mythic' ORDER BY c.originalReleaseDate ASC, c.id NULLS LAST, l.id NULLS LAST LIMIT 1;

/*
Prediction Result:
('mythic', 'default1')
*/