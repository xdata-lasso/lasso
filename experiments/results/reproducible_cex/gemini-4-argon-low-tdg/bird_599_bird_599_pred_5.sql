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
-- 1. COUNT(DISTINCT UserId) vs COUNT(UserId) vs COUNT(*) via duplicate UserIds and NULL UserIds in comments.
-- 2. Duplicate PostHistoryTypeId rows in postHistory (testing missing GROUP BY vs scalar subquery).
-- 3. Filtering on PostId = 3720 vs other PostIds (3719, 3721) and NULL PostIds.
-- 4. Disjoint UserIds between postHistory and comments (testing incorrect join conditions on UserId).
INSERT INTO users (Id, DisplayName) VALUES (1, 'User1');
INSERT INTO users (Id, DisplayName) VALUES (2, 'User2');
INSERT INTO users (Id, DisplayName) VALUES (3, 'User3');
INSERT INTO users (Id, DisplayName) VALUES (4, 'User4');
INSERT INTO posts (Id, Title, CommentCount) VALUES (3719, 'Post 3719', 5);
INSERT INTO posts (Id, Title, CommentCount) VALUES (3720, 'Post 3720', 99);
INSERT INTO posts (Id, Title, CommentCount) VALUES (3721, 'Post 3721', 5);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId) VALUES (10, 1, 3720, 3);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId) VALUES (11, 1, 3720, 3);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId) VALUES (12, 2, 3720, NULL);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId) VALUES (13, 3, 3719, 1);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId) VALUES (14, 4, 3721, 2);
INSERT INTO postHistory (Id, PostHistoryTypeId, PostId, UserId) VALUES (15, 5, NULL, 1);
INSERT INTO comments (Id, PostId, UserId, Score) VALUES (100, 3720, 1, 10);
INSERT INTO comments (Id, PostId, UserId, Score) VALUES (101, 3720, 1, 20);
INSERT INTO comments (Id, PostId, UserId, Score) VALUES (102, 3720, 2, 30);
INSERT INTO comments (Id, PostId, UserId, Score) VALUES (103, 3720, NULL, 40);
INSERT INTO comments (Id, PostId, UserId, Score) VALUES (104, 3719, 4, 50);
INSERT INTO comments (Id, PostId, UserId, Score) VALUES (105, 3721, 4, 60);
INSERT INTO comments (Id, PostId, UserId, Score) VALUES (106, NULL, 4, 70);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.PostHistoryTypeId, (SELECT COUNT(DISTINCT UserId) FROM comments WHERE PostId = 3720) AS NumberOfUsers FROM postHistory AS T1 WHERE T1.PostId = 3720;

/*
Gold Result:
(1, 2)
(1, 2)
(2, 2)
*/

-- Prediction Query
SELECT ph.PostHistoryTypeId, COUNT(DISTINCT c.UserId) AS CommentCount FROM postHistory AS ph INNER JOIN comments AS c ON ph.PostId = c.PostId WHERE ph.PostId = 3720 GROUP BY ph.PostHistoryTypeId;

/*
Prediction Result:
(1, 2)
(2, 2)
*/