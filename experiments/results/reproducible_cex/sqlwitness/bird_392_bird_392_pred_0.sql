-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cards (id, artist, asciiname, availability, bordercolor, cardkingdomfoilid, cardkingdomid, coloridentity, colorindicator, colors, convertedmanacost, dueldeck, edhrecrank, faceconvertedmanacost, facename, flavorname, flavortext, frameeffects, frameversion, hand, hasalternativedecklimit, hascontentwarning, hasfoil, hasnonfoil, isalternative, isfullart, isonlineonly, isoversized, ispromo, isreprint, isreserved, isstarter, isstoryspotlight, istextless, istimeshifted, keywords, layout, leadershipskills, life, loyalty, manacost, mcmid, mcmmetaid, mtgarenaid, mtgjsonv4id, mtgofoilid, mtgoid, multiverseid, name, number, originalreleasedate, originaltext, originaltype, otherfaceids, power, printings, promotypes, purchaseurls, rarity, scryfallid, scryfallillustrationid, scryfalloracleid, setcode, side, subtypes, supertypes, tcgplayerproductid, text, toughness, type, types, uuid, variations, watermark) VALUES (1, 'default2', NULL, NULL, 'default1', NULL, 'default2', 'uncommon', NULL, 'default1', 2.0, NULL, 0, 1.0, NULL, 'uncommon', 'default2', 'uncommon', NULL, NULL, 2, 3, 1, 0, 3, 0, 3, 3, 0, 4, 3, 0, 0, 2, 3, 'default2', 'default1', 'default2', 'default2', 'default1', 'default1', 'default1', 'default1', NULL, 'uncommon', 'uncommon', 'uncommon', 'default2', NULL, 'uncommon', 'uncommon', 'uncommon', 'uncommon', 'default2', NULL, 'uncommon', 'default2', 'default1', 'default2', 'uncommon', 'uncommon', 'default2', 'default2', 'uncommon', 'default2', 'default2', 'default2', 'uncommon', 'uncommon', 'default2', 'uncommon', 'uncommon', NULL, 'uncommon'), (0, NULL, 'uncommon', 'uncommon', 'default2', NULL, 'uncommon', 'default2', 'default1', 'uncommon', 2.0, 'uncommon', 1, 0.0, NULL, 'default1', 'default2', NULL, NULL, NULL, 0, 3, 3, 4, 0, 1, 4, 3, 4, 1, 1, 3, 2, 1, 4, NULL, 'default1', 'default2', 'default2', 'default2', 'uncommon', 'default2', NULL, 'default2', NULL, 'default1', NULL, 'uncommon', 'default2', 'default2', 'default1', 'default1', 'default2', 'default1', NULL, 'default1', NULL, 'default1', NULL, 'default1', NULL, 'default1', NULL, NULL, 'uncommon', 'uncommon', NULL, 'uncommon', NULL, NULL, 'default2', 'default2', 'default2', 'default1'), (3, 'default1', NULL, NULL, NULL, 'default1', 'default1', NULL, 'default2', NULL, 0.0, 'default1', 1, 2.0, 'default2', 'uncommon', 'default2', 'uncommon', 'uncommon', NULL, 2, 2, 0, 3, 3, 2, 4, 4, 0, 0, 4, 2, 3, 3, 3, 'default2', 'default1', NULL, 'default2', 'default2', NULL, 'uncommon', 'default2', 'uncommon', 'default2', 'default1', 'uncommon', 'uncommon', 'default1', NULL, NULL, NULL, 'default1', 'uncommon', 'uncommon', 'default1', NULL, 'default1', 'uncommon', 'default1', 'uncommon', 'default1', 'uncommon', 'default2', 'default1', NULL, 'uncommon', NULL, 'uncommon', 'default1', 'uncommon', 'default1', 'uncommon', 'default1');
INSERT INTO rulings (id, uuid, date, text) VALUES (3, NULL, '2023-01-01', 'default1'), (2, NULL, '2023-01-01', 'default1'), (1, NULL, '2023-01-01', 'uncommon'), (0, 'default1', '2023-01-02', 'default1'), (4, 'default1', '2023-01-01', 'uncommon'), (5, NULL, '2023-01-01', 'default1'), (6, 'default1', '2023-01-02', NULL), (7, 'default1', '2023-01-01', 'uncommon'), (8, 'uncommon', '2023-01-02', 'default1'), (9, NULL, '2023-01-02', 'uncommon');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT DISTINCT T1.name FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.rarity = 'uncommon' ORDER BY T2.date ASC, T1.name NULLS LAST LIMIT 3;

/*
Gold Result:
('default1',)
*/

-- Prediction Query
SELECT T1.name FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.rarity = 'uncommon' ORDER BY T2.date ASC, T1.id NULLS LAST, T2.id NULLS LAST LIMIT 3;

/*
Prediction Result:
('default1',)
('default1',)
('default1',)
*/