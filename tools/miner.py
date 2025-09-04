#! python3

import requests
from bs4 import BeautifulSoup
import xml.etree.ElementTree as ET
import pprint
from pathlib import Path
import demjson3
import re
import argparse
import pickle
import logging
import os.path
import json

AGENT_HEADERS = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101 Firefox/72.0'}

g_json_cache = {}
g_wowhead_cache = {}
g_wowhead_item_cache = {}
g_wowhead_tooltip_cache = {}
g_muffin_data = {}
g_quiet_mode = False
g_xpac = "retail"
g_logged_url = None # "https://www.wowhead.com/items/trade-goods/herbs"
g_logged_set_name = "Muffin.Food.Mana.Basic"

def parse_rule(p_rule, p_url_root):
	ftype = p_rule.attrib['ftype']
	if ftype == "wowhead":
		url = p_url_root + p_rule.attrib['url']
		tests = []
		for reg_child in p_rule.findall('Test'):
			field = reg_child.attrib['field']
			pattern = reg_child.attrib['pattern']
			tests.append({'field' : field, 'pattern' : pattern})
		return {'ftype' : 'wowhead', 'url' : url, 'tests' : tests}



def load_miner_data(p_set_override, p_xpac):
	# create element tree object
	tree = ET.parse(f"set_{p_xpac}.xml")

	# get root element
	root = tree.getroot()

	all_sets = {}
	url_root = root.attrib['url_root']

	for item in root.findall('Set'):
		set_name = item.attrib['name']
		#print(item, set_name)

		if (p_set_override and p_set_override not in set_name.upper()):
			#print(set_name.upper(), p_set_override)
			continue

		current_set = {}
		current_set['inclusion'] = []

		for child in item.findall('Inclusion'):
			ftype = child.attrib['ftype']
			#print(child, ftype)
			if ftype == "wowhead":
				new_rule = parse_rule(child, url_root)
				current_set['inclusion'].append(new_rule)
			elif ftype == 'json':
				file_name = child.attrib['file_name']
				filters = child.attrib.copy()
				del filters['file_name']
				del filters['ftype']
				current_set['inclusion'].append({'ftype' : 'json', 'file_name' : file_name, 'filters' : filters})
			elif ftype == 'static':
				static_list = []
				for static_item in child.findall('Item'):
					static_list.append(int(static_item.attrib['id']))
				for static_item in child.findall('Spell'):
					static_list.append(-int(static_item.attrib['id']))

				current_set['inclusion'].append({'ftype' : 'static', 'static_list' : static_list})
			elif ftype == 'muffin_data':
				field = child.attrib['field']
				pattern = child.attrib.get('pattern')
				value = child.attrib.get('value')
				current_set['inclusion'].append({'ftype' : 'muffin_data', 'field' : field, 'pattern' : pattern, 'value' : value})
			else:
				print(f"Inclusion rules, What's a {ftype}??")
				exit()

		current_set['exclusion'] = []

		for child in item.findall('Exclusion'):
			ftype = child.attrib['ftype']
			#print(child, ftype)
			if ftype == "wowhead":
				new_rule = parse_rule(child, url_root)
				current_set['exclusion'].append(new_rule)

			elif ftype == 'json':
				file_name = child.attrib['file_name']
				filters = child.attrib.copy()
				del filters['file_name']
				del filters['ftype']
				current_set['exclusion'].append({'ftype' : 'json', 'file_name' : file_name, 'filters' : filters})
			elif ftype == 'muffin_data':
				field = child.attrib['field']
				pattern = child.attrib.get('pattern', None)
				neg_pattern = child.attrib.get('neg_pattern', None)
				current_set['exclusion'].append({'ftype' : 'muffin_data', 'field' : field, 'pattern' : pattern, 'neg_pattern' : neg_pattern})
				#	<Exclusion ftype="muffin_data" field="tooltip_single" pattern="use:" />
			elif ftype == 'static':
				static_list = []
				for static_item in child.findall('Item'):
					static_list.append(int(static_item.attrib['id']))
				for static_item in child.findall('Spell'):
					static_list.append(-int(static_item.attrib['id']))
				current_set['exclusion'].append({'ftype' : 'static', 'static_list' : static_list})
			else:
				print(f"Exclusion rules: What's a {ftype}??")
				exit()

		current_set['intersect'] = []

		for child in item.findall('Intersect'):
			ftype = child.attrib['ftype']
			#print(child, ftype)
			if ftype == "wowhead":
				new_rule = parse_rule(child, url_root)
				current_set['intersect'].append(new_rule)
			else:
				print(f"Intersect rules: What's a {ftype}??")
				exit()

		all_sets[set_name] = current_set

	return all_sets


def find_lib_files(p_data_path, p_file_override):
	all_lib_files = []

	p = Path(p_data_path)
	for x in p.iterdir():
		if x.is_dir():
			continue

		if (p_file_override and p_file_override in str(x).upper()) or (not p_file_override):
			all_lib_files.append(str(x))

	return all_lib_files


def update_lib_file(p_lib_file_name, p_all_sets):
	data_regex = r"^\s*\[\"([a-zA-Z .]+)\"\]\s*=\s*\"([\-0-9,: ]*)\""  #"
	rev_regex = r"LibStub\(\"LibPeriodicTable-3.1\"\):AddData\(\"([a-zA-Z. ]+)\", \"Rev: ([0-9]+)" #"
	rev_fmt = 'LibStub("LibPeriodicTable-3.1"):AddData("{lib_name}", "Rev: {rev}",\n'
	data_fmt = '\t["{setname}"] = "{data}",\n'

	changed_sets = 0

	with open(p_lib_file_name) as f:
		lib_lines = f.readlines()

	for idx, line in enumerate(lib_lines):
		m = re.search(rev_regex, line)
		if m:
			lib_name = m.group(1)
			rev = int(m.group(2)) + 1
			print("\nFile:{name}\t\tRevision:{rev}".format(name=lib_name, rev=rev))
			lib_lines[idx] = rev_fmt.format(lib_name = lib_name, rev = rev)
			#print(lib_lines[idx])
			continue

		m = re.search(data_regex, line)
		if m:
			set_name = m.group(1)
			set_data_string = m.group(2)

			set_data = set()
			if set_data_string != "":
				set_data = set(map(int, set_data_string.split(',')))

			if set_name not in p_all_sets:
				g_logger.debug(f"Updating :{set_name}, \tbut don't know what to do with it")
				continue

			g_logger.info(f"Updating : {set_name}")
			#print(set_name, set_data_string)
			#pprint.pprint(set_data)

			new_set_data = get_set_data(set_name, set_data, p_all_sets)

#			if not new_set_data:
#				continue
			#pprint.pprint(set_data)
			#pprint.pprint(new_set_data)
			#pprint.pprint(new_set_data.difference(set_data))

			added = len(new_set_data.difference(set_data))
			removed = len(set_data.difference(new_set_data))
			if (added + removed > 0):
				changed_sets += 1
				sorted_data = sorted(new_set_data)
				data_str = str(sorted_data).strip('[]')
				lib_lines[idx] = data_fmt.format(setname = set_name, data = data_str)
				#print(lib_lines[idx])

			if (added > 0):
				g_logger.debug("Added:")
				for d in new_set_data.difference(set_data):
					item_name = g_muffin_data[d]['item_name'] if d in g_muffin_data else "?"
					g_logger.debug(f"\t{d} : {item_name}")
			if (removed > 0):
				g_logger.debug("Removed:")
				for d in set_data.difference(new_set_data):
					item_name = g_muffin_data[d]['item_name'] if d in g_muffin_data else ""
					g_logger.debug(f"\t{d} : {item_name}")
			g_logger.info(f"\tOld total:{len(set_data)}\t\tNew total: {len(new_set_data)}\t\tAdded: {added}\t\tRemoved: {removed}\n\n")
		#else:
			#print("Ignoring line:", line)

	if changed_sets > 0:
		with open(p_lib_file_name, "w") as f:
			f.writelines(lib_lines)

	g_logger.info(f"\nUpdated {changed_sets} sets\n\n")


def get_set_data(p_set_name, p_set_data, p_all_sets):
	global g_json_cache

	#pprint.pprint(p_all_sets[p_set_name])
	inc_filters = p_all_sets[p_set_name]['inclusion']
	ex_filters = p_all_sets[p_set_name]['exclusion']
	intersect_filters = p_all_sets[p_set_name]['intersect']
	#pprint.pprint(ex_filters)

	set_data = set()

	for f in inc_filters:
		ftype = f['ftype']
		#pprint.pprint(f)
		g_logger.debug(f)
		if ftype == 'wowhead':
			url = f['url']
			new_set = get_set_from_wowhead_url(url, f['tests'])
			g_logger.debug("\t+url: {url} returned {items} items".format(url = url, items = len(new_set)))
			if p_set_name == g_logged_set_name:
				g_logger.debug("\t\tAdding: {items}".format(items = new_set))
			if (len(new_set) == 1000):
				g_logger.warning("\t+url: {url} returned {items} items".format(url = url, items = len(new_set)))
			set_data.update(new_set)

		elif ftype == 'json':
			file_name = f['file_name']
			if file_name not in g_json_cache:
				with open(file_name) as f_data:
					file_data = f_data.read()
				item_data = demjson3.decode(file_data)
				g_json_cache[file_name] = item_data

			cache = g_json_cache[file_name]
			filters = f['filters']
			new_set = get_set_from_json(cache, filters)
			g_logger.debug("\t+json: returned {items} items".format(items = len(new_set)))
			if p_set_name == g_logged_set_name:
				g_logger.debug("\t\tAdding: {items}".format(items = new_set))
			set_data.update(new_set)

		elif ftype == 'static':
			g_logger.debug(f"\t+static: {f['static_list']}")
			set_data.update(f['static_list'])

		elif ftype == 'muffin_data':
			field = f['field']
			pattern = f.get('pattern')
			value = f.get('value')
			new_set = search_muffin_data(field, pattern, value)
			g_logger.debug("\t+muffin: returned {items} items".format(items = len(new_set)))
			if p_set_name == g_logged_set_name:
				g_logger.debug("\t\tAdding: {items}".format(items = new_set))
			set_data.update(new_set)


		else:
			g_logger.warning(f"unknown filter: {ftype}")
			continue

	for f in ex_filters:
		ftype = f['ftype']
		ex_set_data = None
		if ftype == 'json':
			file_name = f['file_name']
			if file_name not in g_json_cache:
				with open(file_name) as f_data:
					file_data = f_data.read()
				item_data = demjson3.decode(file_data)
				g_json_cache[file_name] = item_data

			cache = g_json_cache[file_name]
			filters = f['filters']
			ex_set_data = get_set_from_json(cache, filters)
			print("\t-json: returned {items} items".format(items = len(ex_set_data)))

		elif ftype == 'wowhead':
			url = f['url']
			ex_set_data = get_set_from_wowhead_url(url, f['tests'])
			g_logger.debug("\t-url: {url} returned {items} items".format(url = url, items = len(ex_set_data)))
			if p_set_name == g_logged_set_name:
				g_logger.debug("\t\tRemoving: {items}".format(items = ex_set_data))

		elif ftype == 'muffin_data':
			field = f['field']
			pattern = f['pattern']
			neg_pattern = f['neg_pattern']
			ex_set_data = filter_set_by_muffin_data(set_data, field, pattern, neg_pattern)
			print("\t-field/pattern: {field}/{pattern}/{neg_pattern} returned {items} items".format(field = field, pattern = pattern, neg_pattern = neg_pattern, items = len(ex_set_data)))
			if p_set_name == g_logged_set_name:
				g_logger.debug("\t\tRemoving: {items}".format(items = ex_set_data))
			#	<Exclusion ftype="muffin_data" field="tooltip_single" pattern="use:" />

		elif ftype == 'static':
			g_logger.debug(f"\t-static: {f['static_list']}")
			ex_set_data = f['static_list']


		if(ex_set_data):
			set_data.difference_update(ex_set_data)

	for f in intersect_filters:
		ftype = f['ftype']
		g_logger.debug(f)
		if ftype == 'wowhead':
			url = f['url']
			i_set = get_set_from_wowhead_url(url, f['tests'])
			g_logger.debug("\t~url: {url} returned {items} items".format(url = url, items = len(i_set)))
			if (len(i_set) == 1000):
				g_logger.warning("\t~url: {url} returned {items} items".format(url = url, items = len(i_set)))
			new_set = set_data.intersection(i_set)
			set_data = new_set
		else:
			g_logger.warning(f"unknown intersect filter: {ftype}")
			continue


	return set_data

def get_set_from_json(p_json, p_filters):
	new_set = set()
	temp_dict = {}
	print("# Filters:", len(p_filters), "  -  ", p_filters)

	for filter_key, filter_data in p_filters.items():
		for entry in p_json:
			if entry[filter_key] == filter_data:
				id = entry['id']
				new_set.add(id)

	print(new_set)

	return new_set

def get_set_from_wowhead_url(p_url, p_tests):
	global g_wowhead_cache

	#print(p_url)
	#pprint.pprint(p_tests)

	new_set = set()

	if p_url in g_wowhead_cache:
		g_logger.debug("using cache")
		lview_data = g_wowhead_cache[p_url]
		#print(len(lview_data))
		#print(*lview_data, sep="\n")

	else:
		page = requests.get(p_url, headers=AGENT_HEADERS)
		soup = BeautifulSoup(page.content, 'html.parser')
		str_data = soup.prettify()
		lview = get_listview_from_page(str_data)
		if (not lview):
			#print("No listview found")
			return new_set
		#print(lview)

		lview_data = demjson3.decode(lview)
		g_wowhead_cache[p_url] = lview_data
		g_logger.debug(f"caching {p_url}")

	g_logger.debug(f"test: {p_tests}")

	#print(len(lview_data))
	if(p_url == g_logged_url):
#		print(*lview_data, sep="\n")
		print(type(lview_data))
		#print(lview_data)
		g_logger.debug("\n".join(str(x) for x in lview_data))

	lview_data_tmp = lview_data.copy()
	#Apply tests to filter out unwanted stuff
	for test in p_tests:
		pat = test['pattern']
		field = test['field']
		g_logger.debug(f"processing {pat}|{field}")
		#print(pat, field)
		lview_data_tmp = [tup for tup in lview_data_tmp if re.search(pat, tup[field], re.IGNORECASE)]

	if(p_url == g_logged_url):
#			print(*lview_data_tmp, sep="\n")
		g_logger.debug("\n".join(str(x) for x in lview_data_tmp))

	#print(len(lview_data), "\t", len(lview_data_tmp))
	#print(*lview_data_tmp, sep="\n")

	for j in lview_data_tmp:
		#print (j['name'], j['id'])
		new_set.add(int(j['id']))

	return new_set

def filter_set_by_muffin_data(set_data, field, pattern, neg_pattern):
	new_set = set()
	if(pattern):
		for item_id in set_data:
			if (item_id in g_muffin_data) and (field in g_muffin_data[item_id]):
				if re.search(pattern, g_muffin_data[item_id][field], re.IGNORECASE):
					new_set.add(item_id)
	elif(neg_pattern):
		for item_id in set_data:
			if (item_id in g_muffin_data) and (field in g_muffin_data[item_id]):
				if not re.search(neg_pattern, g_muffin_data[item_id][field], re.IGNORECASE):
					new_set.add(item_id)
	else:
		print("Error finding pattern or neg_pattern in filter_set_by_muffin_data")

	return new_set

def search_muffin_data(p_field, p_pattern, p_value):
	if (p_pattern):
		data_tmp = [item_id for item_id in g_muffin_data if re.search(p_pattern, g_muffin_data[item_id][p_field], re.IGNORECASE)]
	elif (p_value):
		data_tmp = [item_id for item_id in g_muffin_data if str(p_value) == str(g_muffin_data[item_id][p_field])]
	else:
		print ("Searching muffin data but pattern and value are blank")
		exit()

	new_set = set(data_tmp)

	return new_set

def get_listview_from_page(p_page):
	lv_regex = r"var listviewitems\s*=\s*(\[.*\])"

	m = re.search(lv_regex, p_page)

	if not m:
		#print("Error finding listviewitems")
		return None

	q_listview = m.group(1)

	return q_listview

def load_muffin_data(p_xpac):
	global g_muffin_data
	
	file_name = f"D:/Projects/Current/WoW/WoWData/ItemData/items_{p_xpac}.pkl"
	if os.path.isfile(file_name):
		with open(file_name,"rb") as f:
			g_muffin_data = pickle.load(f)
			g_logger.debug(f"Muffin Data length:{len(g_muffin_data)}\n")
	else:
		g_muffin_data = {}

def load_wowhead_cache(p_xpac):
	global g_wowhead_cache
	global g_wowhead_item_cache
	global g_wowhead_tooltip_cache

	g_wowhead_cache = {}
	cache_name = f"wowhead_cache_{p_xpac}.pkl"

	if os.path.isfile(cache_name):
		with open(cache_name,"rb") as f:
			g_wowhead_cache = pickle.load(f)
			g_logger.debug(f"Wowhead cache Data length:{len(g_wowhead_cache)}\n")
	else:
		g_logger.debug("Wowhead cache is empty\n")

	g_wowhead_tooltip_cache = {}
	cache_name = f"wowhead_tooltip_cache_{p_xpac}.pkl"

	if os.path.isfile(cache_name):
		with open(cache_name,"rb") as f:
			g_wowhead_tooltip_cache = pickle.load(f)
			g_logger.debug(f"Wowhead tooltip cache Data length:{len(g_wowhead_tooltip_cache)}\n")
	else:
		g_logger.debug("Wowhead tooltip cache is empty\n")


	g_wowhead_item_cache = {}
	cache_name = f"wowhead_item_cache_{p_xpac}.pkl"

	if os.path.isfile(cache_name):
		with open(cache_name,"rb") as f:
			g_wowhead_item_cache = pickle.load(f)
			g_logger.debug(f"Wowhead Item cache Data length:{len(g_wowhead_item_cache)}\n")
	else:
		g_logger.debug("Wowhead Item cache is empty\n")


def my_upper(p_string):
	if not p_string:
		raise argparse.ArgumentTypeError()

	return p_string.upper()


arg_parser = argparse.ArgumentParser(description='Mine WoW Data')
arg_parser.add_argument('-f', '--file', nargs='?', const = "", type = my_upper)
arg_parser.add_argument('-s', '--set', nargs='?', const = "", type = my_upper)
arg_parser.add_argument('xpac', choices=["classic", "wrath", "cata", "mop", "retail"])

parsed_args = arg_parser.parse_args()
file_override = parsed_args.file
set_override = parsed_args.set

g_xpac = parsed_args.xpac

g_logger = logging.getLogger('miner')
g_logger.setLevel(logging.DEBUG)

fh = logging.FileHandler(f"miner_{g_xpac}.log", mode="w")		# create file handler which logs even debug messages
fh.setLevel(logging.DEBUG)

ch = logging.StreamHandler()		# create console handler with a higher log level
ch.setLevel(logging.INFO)

g_logger.addHandler(fh)		# add the handlers to the logger
g_logger.addHandler(ch)

g_logger.info("Loading Muffin Data...")
load_muffin_data(g_xpac)

g_logger.info("Loading Wowhead Cache...")
load_wowhead_cache(g_xpac)

g_logger.info("Loading Miner Data...")
all_sets = load_miner_data(set_override, g_xpac)

libpt_path = f"../{g_xpac}/MuffinLibPTSets"
#pprint.pprint(all_sets, width=4)
g_logger.debug(f"LibPT Path: {libpt_path}\n")


g_logger.info("Finding Lib Files...")
all_lib_files = find_lib_files(libpt_path, file_override)

#pprint.pprint(all_lib_files, width=4)

for f in all_lib_files:
	update_lib_file(f, all_sets)



f = open(f"wowhead_cache_{g_xpac}.pkl","wb")
pickle.dump(g_wowhead_cache,f)
f.close()

with open(f"wowhead_cache_{g_xpac}.json", 'w') as f:
    json.dump(g_wowhead_cache, f)


f = open(f"wowhead_tooltip_cache_{g_xpac}.pkl","wb")
pickle.dump(g_wowhead_tooltip_cache,f)
f.close()

with open(f"wowhead_tooltip_cache_{g_xpac}.json", 'w') as f:
    json.dump(g_wowhead_tooltip_cache, f)
