# T1GER SHOPS

### Contact
Author: T1GER#9080
Discord: https://discord.gg/FdHkq5q

### Requirements
- progressBars [https://github.com/Hamza8700/fivem_scripts/tree/master/progressBars]

### Installation
1) Drag & drop the t1ger_shops into your `resources` server folder.
2) Configure the config file to your liking.
3) Install the required requirements and add to server config.
4) Run the provided .sql file and make sure everything is added to the database.
5) Add `start t1ger_shops` to your server config.
6) Make sure to read through the README!!!!

### Showcase
- https://youtu.be/_lJ3G30dzPY

### Protection
Do not touch or delete **protection_cl.lua** and **protection_sv.lua**. This is security. Upon deleting/corruption these, script will not work.

### Config.Items
- Add all items you want to have supported in the shops inside Config.Items
- Make sure to add type for each item, example "normal" for 24/7, "pawnshop" for pawnshop only items and "weapon" for weapons shop items.
- These are also the items the owner has possibility of ordering.

### Adding shops
- To add shops, navigate to Config.Shops
- Copy one of the existing shops and paste another one below. Edit the number and edit the content. 
- Make sure to add a shop type.
- Repeat these steps to add more shops. 
- For weapon shops to work, weapons must be ITEMS.

### Basket
- To view basket, the default command is /basket

### Shelves
- Shop owners can use F6 menu to add/remove shelves. These shelves are saved in database in JSON format. 

### Weapons 
- Make sure to set Config.WeaponLoadout accordingly to whether u are using weapons as items or as loadout.
- In config you may see an option for weapons/ammo called str_match, DO NOT TOUCH that!

### Weight / Limit
- Make sure to set Config.ItemWeightSystem accordingly to whether u are using Weight or Limit system for items.