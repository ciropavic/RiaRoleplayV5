### Requirements
- progressBar

You can get my version of `progressBar` from my github repository:
https://github.com/Hamza8700/fivem_scripts

### Installation
1) Drag & drop the folder into your `resources` server folder.
2) Configure the config file to your liking.
3) Import the SQL file into your database.
4) Add `start t1ger_carinsurance` to your server config.

### Auto Payment
To enable insurances are paid whenever player receives salary-

1) copy this line: 	TriggerClientEvent('t1ger_carinsurance:payVehInsurance', xPlayer.source)
2) go to es_extended/server/paycheck.lua
3) Inside the for loop, paste that client event, just like shown here: https://gyazo.com/c37531944640d132681a9e2269ac83ab
