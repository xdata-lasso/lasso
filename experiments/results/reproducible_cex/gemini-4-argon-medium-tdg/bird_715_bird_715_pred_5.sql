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
-- Tests exact boundary conditions for BETWEEN 1 AND 5, off-by-one errors (0, 1, 5, 6), and middle values.
INSERT INTO users (Id, DisplayName, DownVotes) VALUES (1, 'User_Score0', 0);
INSERT INTO users (Id, DisplayName, DownVotes) VALUES (2, 'User_Score1', 0);
INSERT INTO users (Id, DisplayName, DownVotes) VALUES (3, 'User_Score3', 0);
INSERT INTO users (Id, DisplayName, DownVotes) VALUES (4, 'User_Score5', 0);
INSERT INTO users (Id, DisplayName, DownVotes) VALUES (5, 'User_Score6', 0);
INSERT INTO users (Id, DisplayName, DownVotes) VALUES (6, 'User_ScoreNull', 0);
INSERT INTO comments (Id, UserId, Score, UserDisplayName) VALUES (101, 1, 0, 'Wrong_Display_1');
INSERT INTO comments (Id, UserId, Score, UserDisplayName) VALUES (102, 2, 1, 'Wrong_Display_2');
INSERT INTO comments (Id, UserId, Score, UserDisplayName) VALUES (103, 3, 3, 'Wrong_Display_3');
INSERT INTO comments (Id, UserId, Score, UserDisplayName) VALUES (104, 4, 5, 'Wrong_Display_4');
INSERT INTO comments (Id, UserId, Score, UserDisplayName) VALUES (105, 5, 6, 'Wrong_Display_5');
INSERT INTO comments (Id, UserId, Score, UserDisplayName) VALUES (106, 6, NULL, 'Wrong_Display_6');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM comments AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T1.Score BETWEEN 1 AND 5 AND T2.DownVotes = 0;

/*
Gold Result:
('User_Score1',)
('User_Score3',)
('User_Score5',)
*/

-- Prediction Query
SELECT T1.UserDisplayName FROM comments AS T1 LEFT JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.DownVotes = 0 AND T1.Score BETWEEN 1 AND 5;

/*
Prediction Result:
('Wrong_Display_2',)
('Wrong_Display_3',)
('Wrong_Display_4',)
*/