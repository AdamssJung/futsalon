## Footsalon ERD ##
CREATE TABLE "tb_players" (
  "id" SERIAL PRIMARY KEY,
  "name" varchar,
  "joined at" varchar,
  "mobile" int,
  "bod" date
);

CREATE TABLE "tb_matchinfohistory" (
  "match_id" varchar PRIMARY KEY,
  "season" varchar,
  "match_num" int,
  "match_date" date,
  "match_time" varchar,
  "stadium" varchar
);

CREATE index index_season_mnum on matchinfohistory (season, match_num);

CREATE TABLE "tb_awards" (
  "season" varchar,
  "award" varchar,
  "player_id" varchar,
  "prize" varchar
);

CREATE TABLE "tb_match_result" (
  "game_id" varchar PRIMARY KEY,
  "match_id" varchar,
  "hTeam" varchar,
  "htScore" int,
  "htHelper" varchar,
  "htKeep "varchar,
  "ATeam" varchar,
  "atScore" integer,
  "atHelper" varchar,
  "atKeep" varchar,
);

CREATE TABLE "tb_Score" (
  "goal_id" SERIAL PRIMARY KEY,
  "match_id" varchar,
  "game_id" varchar,
  "goal" varchar,
  "assist" varchar,
);

create table "tb_matchsummary" (
"match_id" varchar PRIMARY KEY,
"team" varchar,
"name" varchar,
"win" int,
"draw" int,
"lost" int,
"GF" int,
"GA" int
); 

CREATE TABLE "tb_mom" (
  "mom_id" SERIAL PRIMARY KEY,
  "match_id" varchar,
  "name" varchar,
  "vote" varchar
);

ALTER TABLE "tb_awards" ADD FOREIGN KEY ("player_id") REFERENCES "tb_players" ("id");
ALTER TABLE "tb_awards" ADD FOREIGN KEY ("season") REFERENCES "tb_matchinfohistory" ("season");
ALTER TABLE "tb_match_result" ADD FOREIGN KEY ("match_id") REFERENCES "tb_matchinfohistory" ("match_id");
ALTER TABLE "tb_GoalHistory" ADD FOREIGN KEY ("match_id") REFERENCES "tb_matchinfohistory" ("match_id");
ALTER TABLE "tb_matchsummary" ADD FOREIGN KEY ("match_id") REFERENCES "tb_matchinfohistory" ("match_id");
ALTER TABLE "tb_mom" ADD FOREIGN KEY ("match_id") REFERENCES "tb_matchinfohistory" ("match_id");