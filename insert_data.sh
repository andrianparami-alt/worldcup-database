
#!/bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line

$PSQL "TRUNCATE TABLE games, teams RESTART IDENTITY;" > /dev/null

while IFS=',' read -r YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS || [[ -n $YEAR ]]
do
  if [[ $YEAR != "year" && -n $YEAR ]]
  then
    $PSQL "INSERT INTO teams (name) VALUES ('$WINNER'), ('$OPPONENT') ON CONFLICT (name) DO NOTHING; INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals) SELECT $YEAR, '$ROUND', w.team_id, o.team_id, $WINNER_GOALS, $OPPONENT_GOALS FROM teams AS w CROSS JOIN teams AS o WHERE w.name = '$WINNER' AND o.name = '$OPPONENT';" > /dev/null
  fi
done < games.csv
