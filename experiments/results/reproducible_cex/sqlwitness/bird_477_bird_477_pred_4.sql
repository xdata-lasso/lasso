-- Schema DDL
CREATE TABLE "cards" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, artist TEXT, asciiName TEXT, availability TEXT, borderColor TEXT, cardKingdomFoilId TEXT, cardKingdomId TEXT, colorIdentity TEXT, colorIndicator TEXT, colors TEXT, convertedManaCost REAL, duelDeck TEXT, edhrecRank INTEGER, faceConvertedManaCost REAL, faceName TEXT, flavorName TEXT, flavorText TEXT, frameEffects TEXT, frameVersion TEXT, hand TEXT, hasAlternativeDeckLimit INTEGER DEFAULT 0 NOT NULL, hasContentWarning INTEGER DEFAULT 0 NOT NULL, hasFoil INTEGER DEFAULT 0 NOT NULL, hasNonFoil INTEGER DEFAULT 0 NOT NULL, isAlternative INTEGER DEFAULT 0 NOT NULL, isFullArt INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isOversized INTEGER DEFAULT 0 NOT NULL, isPromo INTEGER DEFAULT 0 NOT NULL, isReprint INTEGER DEFAULT 0 NOT NULL, isReserved INTEGER DEFAULT 0 NOT NULL, isStarter INTEGER DEFAULT 0 NOT NULL, isStorySpotlight INTEGER DEFAULT 0 NOT NULL, isTextless INTEGER DEFAULT 0 NOT NULL, isTimeshifted INTEGER DEFAULT 0 NOT NULL, keywords TEXT, layout TEXT, leadershipSkills TEXT, life TEXT, loyalty TEXT, manaCost TEXT, mcmId TEXT, mcmMetaId TEXT, mtgArenaId TEXT, mtgjsonV4Id TEXT, mtgoFoilId TEXT, mtgoId TEXT, multiverseId TEXT, name TEXT, number TEXT, originalReleaseDate TEXT, originalText TEXT, originalType TEXT, otherFaceIds TEXT, power TEXT, printings TEXT, promoTypes TEXT, purchaseUrls TEXT, rarity TEXT, scryfallId TEXT, scryfallIllustrationId TEXT, scryfallOracleId TEXT, setCode TEXT, side TEXT, subtypes TEXT, supertypes TEXT, tcgplayerProductId TEXT, text TEXT, toughness TEXT, type TEXT, types TEXT, uuid TEXT NOT NULL UNIQUE, variations TEXT, watermark TEXT);

CREATE TABLE "foreign_data" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, flavorText TEXT, language TEXT, multiverseid INTEGER, name TEXT, text TEXT, type TEXT, uuid TEXT REFERENCES cards (uuid));

CREATE TABLE "legalities" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, format TEXT, status TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

CREATE TABLE "sets" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, baseSetSize INTEGER, block TEXT, booster TEXT, code TEXT NOT NULL UNIQUE, isFoilOnly INTEGER DEFAULT 0 NOT NULL, isForeignOnly INTEGER DEFAULT 0 NOT NULL, isNonFoilOnly INTEGER DEFAULT 0 NOT NULL, isOnlineOnly INTEGER DEFAULT 0 NOT NULL, isPartialPreview INTEGER DEFAULT 0 NOT NULL, keyruneCode TEXT, mcmId INTEGER, mcmIdExtras INTEGER, mcmName TEXT, mtgoCode TEXT, name TEXT, parentCode TEXT, releaseDate DATE, tcgplayerGroupId INTEGER, totalSetSize INTEGER, type TEXT);

CREATE TABLE "set_translations" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, language TEXT, setCode TEXT REFERENCES sets (code) ON update CASCADE ON delete CASCADE, translation TEXT);

CREATE TABLE "rulings" (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, date DATE, text TEXT, uuid TEXT REFERENCES cards (uuid) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
INSERT INTO sets (id, basesetsize, block, booster, code, isfoilonly, isforeignonly, isnonfoilonly, isonlineonly, ispartialpreview, keyrunecode, mcmid, mcmidextras, mcmname, mtgocode, name, parentcode, releasedate, tcgplayergroupid, totalsetsize, type) VALUES (0, 0, 'default1', 'default1', 'Aaron Miller', 1, 1, 0, 1, 0, 'Jeremy Jarvis', 1, 1, 'Aaron Miller', 'Coldsnap', 'Chippy', 'Jeremy Jarvis', '2023-01-02', 1, NULL, 'default2'), (1, 0, 'default2', 'Chippy', 'Jeremy Jarvis', 1, 0, 0, 0, 1, 'Jeremy Jarvis', NULL, 0, 'Aaron Miller', 'Aaron Miller', 'Coldsnap', 'default1', '2023-01-01', 0, 1, 'Chippy'), (2, 0, 'Coldsnap', NULL, 'default2', 1, 0, 1, 1, 0, NULL, NULL, 0, 'Chippy', NULL, 'default2', 'Coldsnap', '2023-01-02', NULL, 1, 'Aaron Miller'), (3, NULL, 'Chippy', 'default2', 'Chippy', 0, 1, 1, 0, 0, 'default1', 1, 1, NULL, 'default1', 'Coldsnap', 'Chippy', '2023-01-01', 1, 1, 'Chippy'), (4, 1, 'Jeremy Jarvis', 'default2', 'Coldsnap', 1, 0, 0, 0, 1, 'default1', 0, 0, 'Coldsnap', 'default1', 'Chippy', 'Jeremy Jarvis', '2023-01-02', NULL, 1, 'default2');
INSERT INTO cards (id, artist, asciiname, availability, bordercolor, cardkingdomfoilid, cardkingdomid, coloridentity, colorindicator, colors, convertedmanacost, dueldeck, edhrecrank, faceconvertedmanacost, facename, flavorname, flavortext, frameeffects, frameversion, hand, hasalternativedecklimit, hascontentwarning, hasfoil, hasnonfoil, isalternative, isfullart, isonlineonly, isoversized, ispromo, isreprint, isreserved, isstarter, isstoryspotlight, istextless, istimeshifted, keywords, layout, leadershipskills, life, loyalty, manacost, mcmid, mcmmetaid, mtgarenaid, mtgjsonv4id, mtgofoilid, mtgoid, multiverseid, name, number, originalreleasedate, originaltext, originaltype, otherfaceids, power, printings, promotypes, purchaseurls, rarity, scryfallid, scryfallillustrationid, scryfalloracleid, setcode, side, subtypes, supertypes, tcgplayerproductid, text, toughness, type, types, uuid, variations, watermark) VALUES (0, 'Chippy', 'Chippy', NULL, 'Chippy', 'default2', 'default1', 'Aaron Miller', NULL, 'Aaron Miller', 0.0, 'Coldsnap', 1, 0.0, 'Coldsnap', 'Jeremy Jarvis', 'Chippy', 'default2', 'Coldsnap', NULL, 1, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 1, 0, 0, 'Jeremy Jarvis', NULL, 'Coldsnap', 'default1', 'Jeremy Jarvis', 'Aaron Miller', 'default1', 'Aaron Miller', 'default1', 'Coldsnap', 'Chippy', 'default1', 'default1', 'Coldsnap', 'Jeremy Jarvis', 'default1', 'default1', 'Chippy', 'default1', 'default2', 'Jeremy Jarvis', 'Aaron Miller', 'Jeremy Jarvis', 'Aaron Miller', 'default1', 'Jeremy Jarvis', 'Coldsnap', 'Chippy', 'Coldsnap', 'Coldsnap', NULL, 'Chippy', 'Chippy', 'default1', 'default2', 'Aaron Miller', 'default1', 'default2', NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.artist FROM cards AS T1 INNER JOIN sets AS T2 ON T2.code = T1.setCode WHERE (T2.name = 'Coldsnap' AND T1.artist = 'Chippy') OR (T2.name = 'Coldsnap' AND T1.artist = 'Aaron Miller') OR (T2.name = 'Coldsnap' AND T1.artist = 'Jeremy Jarvis') GROUP BY T1.artist;

/*
Gold Result:
('Chippy',)
*/

-- Prediction Query
SELECT DISTINCT artist FROM cards WHERE artist IN ('Jeremy Jarvis', 'Aaron Miller', 'Chippy') AND setCode = (SELECT code FROM sets WHERE name = 'Coldsnap');

/*
Prediction Result:
*/