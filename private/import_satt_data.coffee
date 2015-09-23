fs = require 'fs'
path = require 'path'
_ = require 'lodash'
file = "./satt.json"
data_raw = fs.readFileSync file, 'utf8'
data = JSON.parse data_raw

grouped = _.groupBy data, (mi) -> mi.menu.id
menus = []
for k, v of grouped
	m = _.first(v).menu
	delete m.updated_at
	delete m.created_at
	menus.push m

for m in menus
	m.items = grouped[m.id]
	for i in m.items
		delete i.menu
		delete i.order_items
		delete i.id
		delete i.updated_at
		delete i.created_at

for m in menus
	delete m.id

fs.writeFileSync "sattelite.json", JSON.stringify(menus, null, 2)
