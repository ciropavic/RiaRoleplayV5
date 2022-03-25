# esx_invest
A FiveM plugin <br>
Based off of [new_banking](https://forum.fivem.net/t/release-new-banking-reskin/220487) it is not a [dependency](#dependencies) but it is useful. (because it collaborates with it)

## Dependencies

 - [FXServer](https://docs.fivem.net/server-manual/setting-up-a-server/)
 - [Essentialmode](https://forum.fivem.net/t/release-essentialmode-base/3665)
 - [es_extended (ESX)](https://forum.fivem.net/t/release-esx-base/39881)
 - (optional [new_banking](https://forum.fivem.net/t/release-new-banking-reskin/220487))

## Why install this?
It brings more jobs like Stockbroker. <br>
Brings a new aspect to making money. By investing money into a company and after a time make a profit or loss. <br>
This will be one of the fastest ways to make money if you do it well. <br>

## TODO
 - [x] MySQL
	 - [x] Table `invest`:
		 - [x] Identifier (the id ESX gave to the user)
		 - [x] Amount (how much did he/she invest?)
		 - [x] Job (what is the job he/she invested in?)
		 - [x] Rate (what was the current investment rate?)
		 - [x] Active (is the investment still active?)
		 - [x] Created (when was the investment made?)
	 - [x] Add to table `jobs`:
	 	 - [x] investRate (what the current investment is on the job)
 - [x] Back-end
	 - [x] server.lua
		 - [x] use mysql-async to lay connection with database
		 - [x] get the current invested balance from the user
		 - [x] get the current available jobs from the database
		 - [x] a loop that gives the job a new investment rate and says if it got up or down
		 - [x] when stock is bought: 
			 - [x] check if user has amount on bank
			 - [x] added into the `invest` table with all the information
			 - [x] remove invested money from users bank
		 - [x] when stock is sold:
			 - [x] currentRate(1.5%) - boughtRate(0.7%) = diffrenceRate(+0,8%)
			 - [x] investment($200) + investment*(differenceRate) = newAmount($360)
			 - [x] add newAmount to the users bank
			 - [x] disable the investment
	 - [x] client.lua
		 - [x] NUI function so it can be send to the UI (job information or available jobs to invest in)
		 - [x] notify when user is around blip that they can open the menu
		 - [x] create blips from config file
		 - [x] new_banking button callback
		 - [x] UI bug fix (on resource stop `closeUI()`)
 - [x] Front-end
	 - [x] Style
		 - [x] Modern
		 - [x] Sleek
		 - [x] (Soft UI)
	- [x] Job list with table from what you can buy
	- [x] lots more but cba to write it out

## Installation
1. Download esx_invest
2. Make sure you have the [dependencies](#dependencies) installed.
3. Open the database.sql and start it in your database called `essentialmode`
4. Configure what you want in `config.lua`
5. Start the resource.
6. Find the blip to open the menu (or install [new_banking](https://forum.fivem.net/t/release-new-banking-reskin/220487) to open it in that menu. *not currently supported*)
7. Start investing.

# Credits
made by Tazio 2019 (finished it in 2020)
