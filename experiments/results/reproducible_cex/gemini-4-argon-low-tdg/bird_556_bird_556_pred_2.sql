-- Schema DDL
CREATE TABLE badges (Id INTEGER NOT NULL PRIMARY KEY, UserId INTEGER NULL, Name TEXT NULL, Date DATETIME NULL, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE comments (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, Score INTEGER NULL, Text TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postHistory (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostHistoryTypeId INTEGER NULL, PostId INTEGER NULL, RevisionGUID TEXT NULL, CreationDate DATETIME NULL, UserId INTEGER NULL, Text TEXT NULL, Comment TEXT NULL, UserDisplayName TEXT NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE postLinks (Id INTEGER NOT NULL PRIMARY KEY, CreationDate DATETIME NULL, PostId INTEGER NULL, RelatedPostId INTEGER NULL, LinkTypeId INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (RelatedPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE posts (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, PostTypeId INTEGER NULL, AcceptedAnswerId INTEGER NULL, CreaionDate DATETIME NULL, Score INTEGER NULL, ViewCount INTEGER NULL, Body TEXT NULL, OwnerUserId INTEGER NULL, LasActivityDate DATETIME NULL, Title TEXT NULL, Tags TEXT NULL, AnswerCount INTEGER NULL, CommentCount INTEGER NULL, FavoriteCount INTEGER NULL, LastEditorUserId INTEGER NULL, LastEditDate DATETIME NULL, CommunityOwnedDate DATETIME NULL, ParentId INTEGER NULL, ClosedDate DATETIME NULL, OwnerDisplayName TEXT NULL, LastEditorDisplayName TEXT NULL, FOREIGN KEY (LastEditorUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (OwnerUserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE tags (Id INTEGER NOT NULL PRIMARY KEY, TagName TEXT NULL, Count INTEGER NULL, ExcerptPostId INTEGER NULL, WikiPostId INTEGER NULL, FOREIGN KEY (ExcerptPostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE);

CREATE TABLE users (Id INTEGER NOT NULL UNIQUE PRIMARY KEY, Reputation INTEGER NULL, CreationDate DATETIME NULL, DisplayName TEXT NULL, LastAccessDate DATETIME NULL, WebsiteUrl TEXT NULL, Location TEXT NULL, AboutMe TEXT NULL, Views INTEGER NULL, UpVotes INTEGER NULL, DownVotes INTEGER NULL, AccountId INTEGER NULL, Age INTEGER NULL, ProfileImageUrl TEXT NULL);

CREATE TABLE votes (Id INTEGER NOT NULL PRIMARY KEY, PostId INTEGER NULL, VoteTypeId INTEGER NULL, CreationDate DATE NULL, UserId INTEGER NULL, BountyAmount INTEGER NULL, FOREIGN KEY (PostId) REFERENCES posts (Id) ON update CASCADE ON delete CASCADE, FOREIGN KEY (UserId) REFERENCES users (Id) ON update CASCADE ON delete CASCADE);

-- Loading data
PRAGMA foreign_keys = OFF;
-- DATASET 1
-- Tests:
-- 1. Floating-point division (CAST AS REAL vs integer division: 3 / 2 = 1.5 vs 1)
-- 2. COUNT(DISTINCT T2.DisplayName) vs COUNT(DISTINCT T2.Id) (Users 1 and 2 share 'Alice')
-- 3. Multiple badges per user (COUNT(T1.Id) vs COUNT(DISTINCT T1.UserId))
-- 4. Duplicate badge names (COUNT(T1.Id) vs COUNT(DISTINCT T1.Name))
-- 5. Boundary condition on Views (200 excluded, 201 included)
-- 6. Users without badges (LEFT JOIN vs INNER JOIN)
-- 7. Badges with NULL UserId (RIGHT/LEFT JOIN vs INNER JOIN)
INSERT INTO users (Id, Reputation, DisplayName, Views) VALUES (1, 100, 'Alice', 201);
INSERT INTO users (Id, Reputation, DisplayName, Views) VALUES (2, 100, 'Alice', 250);
INSERT INTO users (Id, Reputation, DisplayName, Views) VALUES (3, 100, 'Bob', 300);
INSERT INTO users (Id, Reputation, DisplayName, Views) VALUES (4, 500, 'Charlie', 200);
INSERT INTO users (Id, Reputation, DisplayName, Views) VALUES (5, 500, 'David', 150);
INSERT INTO users (Id, Reputation, DisplayName, Views) VALUES (6, 500, 'Eve', 400);
INSERT INTO badges (Id, UserId, Name) VALUES (10, 1, 'Gold');
INSERT INTO badges (Id, UserId, Name) VALUES (11, 1, 'Gold');
INSERT INTO badges (Id, UserId, Name) VALUES (12, 2, 'Silver');
INSERT INTO badges (Id, UserId, Name) VALUES (13, 4, 'Bronze');
INSERT INTO badges (Id, UserId, Name) VALUES (14, 5, 'Bronze');
INSERT INTO badges (Id, UserId, Name) VALUES (15, NULL, 'Orphan');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T1.Id) AS REAL) / COUNT(DISTINCT T2.DisplayName) FROM badges AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.Views > 200;

/*
Gold Result:
(3.0,)
*/

-- Prediction Query
SELECT COUNT(badges."id") * 1.0 / COUNT(DISTINCT users."id") AS average_badges FROM users JOIN badges ON users."id" = badges."userid" WHERE users."views" > 200;

/*
Prediction Result:
(1.5,)
*/