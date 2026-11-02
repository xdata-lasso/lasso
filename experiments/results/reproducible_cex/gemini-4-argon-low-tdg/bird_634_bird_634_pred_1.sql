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
-- Target: Basic filtering (ignoring 'Other User'), aggregation (SUM vs MAX/COUNT/AVG), and join path (postHistory.UserId vs posts.OwnerUserId).
-- Noah Snyder wins via SUM(ViewCount) = 160 (from two posts: 80 + 80), whereas Harvey Motulsky has MAX(ViewCount) = 100 and COUNT = 3 (100 + 20 + 20 = 140).
-- Also, posts are owned by different users to ensure the join uses postHistory.UserId rather than posts.OwnerUserId or LastEditorUserId.
INSERT INTO users (Id, DisplayName, Views, Reputation) VALUES (1, 'Harvey Motulsky', 1000, 1000);
INSERT INTO users (Id, DisplayName, Views, Reputation) VALUES (2, 'Noah Snyder', 10, 10);
INSERT INTO users (Id, DisplayName, Views, Reputation) VALUES (3, 'Other User', 5000, 5000);
INSERT INTO posts (Id, ViewCount, Score, OwnerUserId, LastEditorUserId) VALUES (101, 100, 50, 3, 3);
INSERT INTO posts (Id, ViewCount, Score, OwnerUserId, LastEditorUserId) VALUES (102, 20, 50, 2, 2);
INSERT INTO posts (Id, ViewCount, Score, OwnerUserId, LastEditorUserId) VALUES (103, 20, 50, 2, 2);
INSERT INTO posts (Id, ViewCount, Score, OwnerUserId, LastEditorUserId) VALUES (104, 80, 5, 1, 1);
INSERT INTO posts (Id, ViewCount, Score, OwnerUserId, LastEditorUserId) VALUES (105, 80, 5, 1, 1);
INSERT INTO posts (Id, ViewCount, Score, OwnerUserId, LastEditorUserId) VALUES (106, 9999, 999, 1, 1);
INSERT INTO postHistory (Id, UserId, PostId, UserDisplayName) VALUES (1001, 1, 101, 'Noah Snyder');
INSERT INTO postHistory (Id, UserId, PostId, UserDisplayName) VALUES (1002, 1, 102, 'Noah Snyder');
INSERT INTO postHistory (Id, UserId, PostId, UserDisplayName) VALUES (1003, 1, 103, 'Noah Snyder');
INSERT INTO postHistory (Id, UserId, PostId, UserDisplayName) VALUES (1004, 2, 104, 'Harvey Motulsky');
INSERT INTO postHistory (Id, UserId, PostId, UserDisplayName) VALUES (1005, 2, 105, 'Harvey Motulsky');
INSERT INTO postHistory (Id, UserId, PostId, UserDisplayName) VALUES (1006, 3, 106, 'Harvey Motulsky');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T1.DisplayName FROM users AS T1 INNER JOIN postHistory AS T2 ON T1.Id = T2.UserId INNER JOIN posts AS T3 ON T2.PostId = T3.Id WHERE T1.DisplayName = 'Harvey Motulsky' OR T1.DisplayName = 'Noah Snyder' GROUP BY T1.DisplayName ORDER BY SUM(T3.ViewCount) DESC, T1.DisplayName NULLS LAST LIMIT 1;

/*
Gold Result:
('Noah Snyder',)
*/

-- Prediction Query
SELECT u.DisplayName, SUM(p.ViewCount) AS TotalViewCount FROM posts AS p INNER JOIN users AS u ON p.OwnerUserId = u.Id WHERE u.DisplayName IN ('Harvey Motulsky', 'Noah Snyder') GROUP BY u.DisplayName ORDER BY TotalViewCount DESC, u.DisplayName NULLS LAST LIMIT 1;

/*
Prediction Result:
('Harvey Motulsky', 10159)
*/