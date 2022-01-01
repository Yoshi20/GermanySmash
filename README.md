# GermanySmash
Germany Super Smash Bros community tool & simple tournament manager (Ruby on Rails project)

Local commands:
- bundle update
- rake db:migrate
- rake db:rollback
- rails s
- rails c

- dropdb germanysmash_development
- heroku pg:pull \<postgresql-name\> germanysmash_development --app germanysmash

- heroku pg:reset --app germanysmash-stage --confirm germanysmash-stage
- heroku pg:push germanysmash_development \<postgresql-name\> --app germanysmash-stage

Stage commands:
- git push stage master
- git push stage <branch>:main
- heroku logs --tail --remote stage
- heroku run rake db:migrate --remote stage
- heroku run rails c --remote stage
- heroku restart --remote stage

- heroku run rake tournaments_crawler:all --remote stage
- heroku run rake results_crawler:all --remote stage
- heroku run rake "utils:remove_player_from_finished_tournament[<t_id>,<p_id>]" --remote stage

Prod commands:
- git push prod master
- heroku logs --tail --remote prod
- heroku run rake db:migrate --remote prod
- heroku run rails c --remote prod
- heroku restart --remote prod

- heroku run rake tournaments_crawler:all --remote prod
- heroku run rake results_crawler:all --remote prod
- heroku run rake "utils:remove_player_from_finished_tournament[<t_id>,<p_id>]" --remote prod

General links:
- https://germanysmash.herokuapp.com
- https://www.germanysmash.de
- https://www.smashgermany.de
- https://challonge.com

Tournaments crawler links:
- https://smash.gg/tournaments?per_page=100&filter={%22upcoming%22%3Atrue%2C%22videogameIds%22%3A0%2C%22countryCode%22%3A%22CH%22}
- https://braacket.com/tournament/search?rows=100&country=ch&game=ssbu&status=1

Icons:
- https://www.ssbwiki.com/Category:Head_icons_(SSBU)

Banner:
- https://www.ssbwiki.com/Super_Smash_Bros._Ultimate

Google Analytics:
<!-- blup: - https://analytics.google.com/analytics/web/#/report-home/a145089919w206718824p199562205 -->
