
#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line

printf "%b\n" "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

printf "%b\n" "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals + opponent_goals) FROM games")"

printf "%b\n" "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

printf "%b\n" "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 2) FROM games")"

printf "%b\n" "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals + opponent_goals) FROM games")"

printf "%b\n" "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games")"

printf "%b\n" "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2")"

printf "%b\n" "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "SELECT t.name FROM games AS g JOIN teams AS t ON g.winner_id = t.team_id WHERE g.year = 2018 AND g.round = 'Final'")"

printf "%b\n" "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "SELECT DISTINCT t.name FROM games AS g JOIN teams AS t ON t.team_id = g.winner_id OR t.team_id = g.opponent_id WHERE g.year = 2014 AND g.round = 'Eighth-Final' ORDER BY t.name")"

printf "%b\n" "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "SELECT DISTINCT t.name FROM games AS g JOIN teams AS t ON g.winner_id = t.team_id ORDER BY t.name")"

printf "%b\n" "\nYear and team name of all the champions:"
echo "$($PSQL "SELECT g.year, t.name FROM games AS g JOIN teams AS t ON g.winner_id = t.team_id WHERE g.round = 'Final' ORDER BY g.year")"

printf "%b\n" "\nList of teams that start with 'Co':"
echo "$($PSQL "SELECT name FROM teams WHERE name LIKE 'Co%' ORDER BY name")"
