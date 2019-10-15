#! python3

from pathlib import Path
import re
import pprint

g_key_regex = r"^\s+\[\s*\"(.+)\"\s*\]\s*=\s*\"*(.+)\"*\s*[,;]$"	#"
loc_keys = {}

p = Path('locale')
for x in p.iterdir():
	if (x.name == "Locale-default.lua"):
		continue
	#print(x.name)

	with open(x, encoding='utf-8') as lua_file:
		lua_data = lua_file.readlines()
		set_data = set()

		for idx, line in enumerate(lua_data):
			m = re.search(g_key_regex, line)
			if m:
				loc_name = m.group(1)
				set_data.add(loc_name)

		loc_keys[x.name] = set_data


for s in loc_keys:
	print(s, len(loc_keys[s]))

#pprint.pprint(loc_keys)

output = ""

with open("locale/locale-enUS.lua", encoding='utf-8') as lua_file:
	lua_data = sorted(lua_file.readlines())

	for line in lua_data:
		m = re.search(g_key_regex, line)
		if m:
			loc_name = m.group(1)
			loc_value = m.group(2).rstrip('"')
			output += '"{name}","{value}"\n'.format(name=loc_name, value=loc_value)

print(output)
