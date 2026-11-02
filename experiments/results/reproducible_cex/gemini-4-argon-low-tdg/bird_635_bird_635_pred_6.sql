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
-- 1. HAVING boundary condition: COUNT(T4.Id) = 5 (passes > 4) vs COUNT(T4.Id) = 4 (fails > 4, tests >= 4 mutant).
-- 2. GROUP BY T2.PostId, T4.Id vs GROUP BY T2.PostId alone (Post 101 has 2 votes, each with 4 postHistory records; grouped by both, count is 4 (excluded); grouped only by PostId, count is 8 (included)).
-- 3. COUNT(T1.Id) vs COUNT(DISTINCT T1.Id) or COUNT(DISTINCT T4.Id) (since 1 user and 1 vote per group, DISTINCT would return 1 instead of 5).
-- 4. Correct join condition T1.Id = T2.UserId vs T1.Id = T3.OwnerUserId or T1.Id = T4.UserId.
-- 5. WHERE T1.DisplayName = 'Matt Parker' filter vs other users.
INSERT INTO users (Id, DisplayName) VALUES (1, 'Matt Parker');
INSERT INTO users (Id, DisplayName) VALUES (2, 'Other User');
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId) VALUES (100, 2, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId) VALUES (101, 2, 2);
INSERT INTO posts (Id, OwnerUserId, LastEditorUserId) VALUES (102, 1, 1);
-- Post 100: 5 postHistory records by Matt Parker (User 1).
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1001, 100, 1);
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1002, 100, 1);
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1003, 100, 1);
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1004, 100, 1);
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1005, 100, 1);
-- 1 extra postHistory on Post 100 by User 2 (tests WHERE filter).
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1006, 100, 2);
-- Post 101: 4 postHistory records by Matt Parker (User 1) (boundary test for > 4).
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1011, 101, 1);
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1012, 101, 1);
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1013, 101, 1);
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1014, 101, 1);
-- Post 102: Owned by Matt Parker (User 1), but postHistory is by User 2 (tests join on T2.UserId vs T3.OwnerUserId).
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1021, 102, 2);
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1022, 102, 2);
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1023, 102, 2);
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1024, 102, 2);
INSERT INTO postHistory (Id, PostId, UserId) VALUES (1025, 102, 2);
-- Votes:
-- Vote 200 on Post 100 -> forms a group (100, 200) of size 5 for Matt Parker.
INSERT INTO votes (Id, PostId, UserId) VALUES (200, 100, 2);
-- Votes 201 and 202 on Post 101 -> forms two groups (101, 201) and (101, 202) of size 4 each.
INSERT INTO votes (Id, PostId, UserId) VALUES (201, 101, 2);
INSERT INTO votes (Id, PostId, UserId) VALUES (202, 101, 2);
-- Vote 203 on Post 102 -> forms group (102, 203) of size 5 for User 2.
INSERT INTO votes (Id, PostId, UserId) VALUES (203, 102, 1);
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT COUNT(T1.Id) FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id INNER JOIN votes AS T4 ON T4.PostId = T3.Id WHERE T1.DisplayName = 'Matt Parker' GROUP BY T2.PostId, T4.Id HAVING COUNT(T4.Id) > 4;

/*
Gold Result:
(5,)
*/

-- Prediction Query
SELECT COUNT(T1.Id) FROM posts AS T1 INNER JOIN votes AS T2 ON T1.Id = T2.PostId INNER JOIN users AS T3 ON T1.OwnerUserId = T3.Id WHERE T3.DisplayName = 'Matt Parker' AND T2.PostId > 4;

/*
Prediction Result:
(1,)
*/