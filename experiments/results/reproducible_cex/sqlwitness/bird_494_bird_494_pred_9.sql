-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO cards (id, artist, asciiname, availability, bordercolor, cardkingdomfoilid, cardkingdomid, coloridentity, colorindicator, colors, convertedmanacost, dueldeck, edhrecrank, faceconvertedmanacost, facename, flavorname, flavortext, frameeffects, frameversion, hand, hasalternativedecklimit, hascontentwarning, hasfoil, hasnonfoil, isalternative, isfullart, isonlineonly, isoversized, ispromo, isreprint, isreserved, isstarter, isstoryspotlight, istextless, istimeshifted, keywords, layout, leadershipskills, life, loyalty, manacost, mcmid, mcmmetaid, mtgarenaid, mtgjsonv4id, mtgofoilid, mtgoid, multiverseid, name, number, originalreleasedate, originaltext, originaltype, otherfaceids, power, printings, promotypes, purchaseurls, rarity, scryfallid, scryfallillustrationid, scryfalloracleid, setcode, side, subtypes, supertypes, tcgplayerproductid, text, toughness, type, types, uuid, variations, watermark) VALUES (1, NULL, NULL, 'NO', 'default2', 'NO', 'YES', 'default2', 'YES', 'default2', 1.0, 'default2', 2, 2.0, 'default2', 'default2', 'default1', 'Jim Pavelec', 'Jim Pavelec', 'Jim Pavelec', 2, 1, 1, 0, 0, 2, 2, 0, 0, 0, 0, 2, 2, 2, 1, 'default1', 'NO', 'default2', 'NO', 'NO', NULL, NULL, 'Jim Pavelec', 'YES', 'Jim Pavelec', 'YES', 'default1', 'NO', NULL, 'NO', NULL, 'NO', 'Jim Pavelec', 'YES', 'YES', 'YES', NULL, 'default1', 'default2', 'default1', 'default2', 'default1', 'default2', 'NO', 'default2', 'YES', 'YES', 'default2', 'Jim Pavelec', NULL, NULL, 'Jim Pavelec', 'Jim Pavelec', 'NO'), (0, 'Jim Pavelec', 'default1', 'NO', 'NO', 'NO', 'YES', NULL, NULL, 'default2', NULL, 'Jim Pavelec', 2, NULL, 'NO', NULL, 'default2', 'default1', 'default2', NULL, 0, 1, 1, 1, 2, 1, 0, 2, 2, 2, 0, 0, 0, 0, 0, 'Jim Pavelec', 'default2', 'Jim Pavelec', 'Jim Pavelec', 'default2', 'NO', 'default2', 'YES', 'default1', 'default1', 'default2', 'default1', 'default2', 'default1', 'default1', 'default1', 'default2', NULL, 'default2', 'Jim Pavelec', 'default1', 'NO', 'YES', 'YES', 'default1', 'default2', 'NO', 'Jim Pavelec', NULL, NULL, 'YES', 'default1', NULL, 'Jim Pavelec', 'default1', 'YES', 'default1', NULL, 'NO'), (2, 'Jim Pavelec', 'default1', 'default1', NULL, NULL, 'Jim Pavelec', NULL, 'default2', 'Jim Pavelec', NULL, 'default2', 0, 2.0, 'default2', NULL, 'NO', 'NO', 'YES', 'NO', 2, 2, 0, 2, 2, 2, 2, 1, 0, 1, 0, 1, 2, 2, 2, 'NO', 'default2', NULL, NULL, NULL, 'default2', 'NO', NULL, 'YES', NULL, NULL, 'NO', 'default1', 'NO', 'NO', NULL, NULL, 'YES', 'default2', 'NO', 'NO', 'default1', 'NO', 'YES', 'Jim Pavelec', 'Jim Pavelec', 'NO', 'default1', 'NO', 'YES', 'NO', 'Jim Pavelec', 'YES', NULL, 'Jim Pavelec', 'NO', 'YES', 'Jim Pavelec', 'default2'), (3, 'default1', NULL, 'Jim Pavelec', 'default1', 'NO', NULL, NULL, 'Jim Pavelec', 'Jim Pavelec', NULL, 'default2', NULL, NULL, 'NO', 'YES', 'default1', 'default1', 'NO', 'YES', 1, 1, 0, 1, 2, 0, 0, 0, 0, 2, 2, 1, 2, 1, 2, 'Jim Pavelec', 'YES', 'YES', 'YES', 'default2', 'YES', 'YES', 'YES', 'default1', NULL, NULL, 'Jim Pavelec', 'default1', 'NO', 'NO', 'YES', NULL, 'Jim Pavelec', 'YES', 'default2', 'default2', NULL, 'default1', 'default1', 'NO', NULL, 'Jim Pavelec', NULL, 'default1', 'YES', 'default2', 'default1', 'default1', 'Jim Pavelec', 'Jim Pavelec', 'default1', 'NO', 'default2', 'default1');
INSERT INTO rulings (id, uuid, date, text) VALUES (2, 'default1', NULL, 'YES'), (1, 'YES', '2023-01-01', 'default1'), (0, 'default1', '2023-01-02', 'default1');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.text, CASE WHEN T1.hasContentWarning = 1 THEN 'YES' ELSE 'NO' END FROM cards AS T1 INNER JOIN rulings AS T2 ON T2.uuid = T1.uuid WHERE T1.artist = 'Jim Pavelec';

/*
Gold Result:
('default1', 'YES')
('default1', 'NO')
('YES', 'YES')
*/

-- Prediction Query
SELECT T1.artist, T2.text, T1.hasContentWarning FROM cards AS T1 INNER JOIN rulings AS T2 ON T1.uuid = T2.uuid WHERE T1.artist = 'Jim Pavelec';

/*
Prediction Result:
('Jim Pavelec', 'default1', 1)
('Jim Pavelec', 'default1', 2)
('Jim Pavelec', 'YES', 1)
*/