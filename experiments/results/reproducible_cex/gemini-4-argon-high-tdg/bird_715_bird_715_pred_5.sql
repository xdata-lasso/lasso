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
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes) VALUES (10, 100, 'User_Score_Neg1', 10, 10, 0);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes) VALUES (20, 100, 'User_Score_0', 10, 10, 0);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes) VALUES (30, 100, 'User_Score_1', 10, 10, 0);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes) VALUES (40, 100, 'User_Score_3', 10, 10, 0);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes) VALUES (50, 100, 'User_Score_5', 10, 10, 0);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes) VALUES (60, 100, 'User_Score_6', 10, 10, 0);
INSERT INTO users (Id, Reputation, DisplayName, Views, UpVotes, DownVotes) VALUES (70, 100, 'User_Score_Null', 10, 10, 0);
INSERT INTO posts (Id, PostTypeId, Score, OwnerUserId, Title) VALUES (100, 1, 10, 10, 'Sample Post');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (1001, 100, -1, 'Negative score', 10, 'Other_Name_1');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (1002, 100, 0, 'Zero score', 20, 'Other_Name_2');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (1003, 100, 1, 'Lower bound score', 30, 'Other_Name_3');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (1004, 100, 3, 'Middle score', 40, 'Other_Name_4');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (1005, 100, 5, 'Upper bound score', 50, 'Other_Name_5');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (1006, 100, 6, 'Above upper bound', 60, 'Other_Name_6');
INSERT INTO comments (Id, PostId, Score, Text, UserId, UserDisplayName) VALUES (1007, 100, NULL, 'Null score', 70, 'Other_Name_7');
PRAGMA foreign_keys = ON;
PRAGMA foreign_key_check;

-- Gold Query
SELECT T2.DisplayName FROM comments AS T1 INNER JOIN users AS T2 ON T1.UserId = T2.Id WHERE T1.Score BETWEEN 1 AND 5 AND T2.DownVotes = 0;

/*
Gold Result:
('User_Score_1',)
('User_Score_3',)
('User_Score_5',)
*/

-- Prediction Query
SELECT T1.UserDisplayName FROM comments AS T1 LEFT JOIN users AS T2 ON T1.UserId = T2.Id WHERE T2.DownVotes = 0 AND T1.Score BETWEEN 1 AND 5;

/*
Prediction Result:
('Other_Name_3',)
('Other_Name_4',)
('Other_Name_5',)
*/