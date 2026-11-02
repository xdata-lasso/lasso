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
-- 1. Floating-point division (CAST AS REAL) vs integer division (7 / 2 = 3.5 vs 3).
-- 2. COUNT(T2.Id) vs COUNT(DISTINCT T2.Id) and COUNT(T1.Id) vs COUNT(DISTINCT T1.Id) via M-to-N join (2 votes x 7 posts = 14 join rows).
-- 3. Join condition: T1.UserId = T2.OwnerUserId vs T1.PostId = T2.Id vs T1.UserId = T2.LastEditorUserId.
-- 4. WHERE filter: T1.UserId = 24 vs other users (23, 25, NULL) and vs T1.Id = 24 or T2.Id = 24.
INSERT INTO users (Id, DisplayName) VALUES (23, 'User23');
INSERT INTO users (Id, DisplayName) VALUES (24, 'User24');
INSERT INTO users (Id, DisplayName) VALUES (25, 'User25');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title) VALUES (101, 24, 23, 'P1');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title) VALUES (102, 24, 23, 'P2');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title) VALUES (103, 24, 23, 'P3');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title) VALUES (104, 24, 23, 'P4');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title) VALUES (105, 24, 23, 'P5');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title) VALUES (106, 24, 23, 'P6');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title) VALUES (107, 24, 23, 'P7');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title) VALUES (24, 25, 24, 'PostWithId24');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title) VALUES (108, 23, 24, 'PostEditedBy24');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId, Title) VALUES (109, NULL, 24, 'PostNullOwner');
INSERT INTO votes (Id, PostId, UserId) VALUES (1, 24, 24);
INSERT INTO votes (Id, PostId, UserId) VALUES (2, 108, 24);
INSERT INTO votes (Id, PostId, UserId) VALUES (24, 101, 25);
INSERT INTO votes (Id, PostId, UserId) VALUES (3, 101, 23);
INSERT INTO votes (Id, PostId, UserId) VALUES (4, 102, NULL);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT CAST(COUNT(T2.Id) AS REAL) / COUNT(DISTINCT T1.Id) FROM votes AS T1 INNER JOIN posts AS T2 ON T1.UserId = T2.OwnerUserId WHERE T1.UserId = 24;

/*
Gold Result:
(7.0,)
*/

-- Prediction Query
SELECT CAST(COUNT(T1.Id) AS REAL) / COUNT(T2.Id) FROM posts AS T1 INNER JOIN votes AS T2 ON T1.OwnerUserId = T2.UserId WHERE T1.OwnerUserId = 24;

/*
Prediction Result:
(1.0,)
*/