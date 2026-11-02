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
-- Tests exact boundary conditions (counts of 4, 5, 6, 7) with distinct badge names
INSERT INTO users (Id) VALUES (1);
INSERT INTO users (Id) VALUES (2);
INSERT INTO users (Id) VALUES (3);
INSERT INTO users (Id) VALUES (4);
INSERT INTO badges (Id, UserId, Name) VALUES (1, 1, 'B1');
INSERT INTO badges (Id, UserId, Name) VALUES (2, 1, 'B2');
INSERT INTO badges (Id, UserId, Name) VALUES (3, 1, 'B3');
INSERT INTO badges (Id, UserId, Name) VALUES (4, 1, 'B4');
INSERT INTO badges (Id, UserId, Name) VALUES (5, 2, 'B1');
INSERT INTO badges (Id, UserId, Name) VALUES (6, 2, 'B2');
INSERT INTO badges (Id, UserId, Name) VALUES (7, 2, 'B3');
INSERT INTO badges (Id, UserId, Name) VALUES (8, 2, 'B4');
INSERT INTO badges (Id, UserId, Name) VALUES (9, 2, 'B5');
INSERT INTO badges (Id, UserId, Name) VALUES (10, 3, 'B1');
INSERT INTO badges (Id, UserId, Name) VALUES (11, 3, 'B2');
INSERT INTO badges (Id, UserId, Name) VALUES (12, 3, 'B3');
INSERT INTO badges (Id, UserId, Name) VALUES (13, 3, 'B4');
INSERT INTO badges (Id, UserId, Name) VALUES (14, 3, 'B5');
INSERT INTO badges (Id, UserId, Name) VALUES (15, 3, 'B6');
INSERT INTO badges (Id, UserId, Name) VALUES (16, 4, 'B1');
INSERT INTO badges (Id, UserId, Name) VALUES (17, 4, 'B2');
INSERT INTO badges (Id, UserId, Name) VALUES (18, 4, 'B3');
INSERT INTO badges (Id, UserId, Name) VALUES (19, 4, 'B4');
INSERT INTO badges (Id, UserId, Name) VALUES (20, 4, 'B5');
INSERT INTO badges (Id, UserId, Name) VALUES (21, 4, 'B6');
INSERT INTO badges (Id, UserId, Name) VALUES (22, 4, 'B7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT UserId FROM (SELECT UserId, COUNT(Name) AS num FROM badges GROUP BY UserId) AS T WHERE T.num > 5;

/*
Gold Result:
(3,)
(4,)
*/

-- Prediction Query
SELECT COUNT(T1.UserId) FROM badges AS T1 GROUP BY T1.UserId HAVING COUNT(T1.Id) > 5;

/*
Prediction Result:
(6,)
(7,)
*/