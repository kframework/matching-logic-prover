########################################################
# This is the translator that takes kore definitions
# and degugar them by lifting all object-level patterns 
# to meta-level ones. The input is a file input.kore.txt
# and the lifted output is file output.kore.txt.
#########################################################

#!/usr/bin/python
import re
import os

# regular expressions of different types of patterns
#X:S
exp_variable = re.compile("[a-zA-Z]\w*\'?:[a-zA-Z]\w*\'?$") 
#phi1 /\ phi2
exp_and = re.compile("\A\\\\[a][n][d]\(.+\)$") 
#not(phi)
exp_not = re.compile("\A\\\\[n][o][t]\(.+\)$") 
#exists x:s,phi
exp_exists = re.compile("\A\\\\[e][x][i][s][t][s]\(.+\)$") 
#equals phi1, phi2, sort1, sort2
exp_equals = re.compile("\A\\\\[e][q][u][a][l][s]\(.+\)$") 
#phi1 \/ phi2
exp_or = re.compile("\A\\\\[o][r]\(.+\)$") 
#meta-level pattern
exp_meta = re.compile("[a-zA-Z]\w*\'?::[a-zA-Z]\w*\'?$") 
#others, including app(phi1,pih2,...,phin) and non-patterns
exp_others = re.compile("\A\\\\?[a-zA-Z]+(.+)$") 
# other patterns like forall are not added here. 
# But it's trival. Just add new exps analogous to the existed ones

# when first read in a line, the last character \n shall be ignored
FIRST = False
# not needed right now, may be useful later
ERROR = False

#strings needed in composing applications
nilPs = "#nilPattern"
appendPs = "#appendPatternList"
nilSs = "#nilSort"
appendSs = "#appendSortList"

# input a string of pattern and return its return sort
# match with regular expressions respectively and get its sort
def getPatternSort(str):
	#print str
	# get the pattern well-organized 
	if str.count("(") < str.count(")") :
		str = str[0:len(str)-1]
	# x:s -> s
	if exp_variable.match(str) :
		res = (re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?)",str).group(2))
	# \and(P1, P2) -> getPatternSort(P1)
	elif exp_and.match(str):
		tmp = str[5:len(str)-1] 
		pos = tmp.index(",")
		while 1 :
			if tmp[0:pos].count('(') == tmp[0:pos].count(')'):
				res =  getPatternSort(tmp[0:pos])
				break
			else: 
				pos = pos + tmp[pos+1:len(tmp)].index(",") + 1
	# \not(P) -> getPatternSort(P)
	elif exp_not.match(str):
		res = getPatternSort(str[5:len(str)-1])
	# \exists(x:S, P) -> getPatternSort(P)
	elif exp_exists.match(str):
		res = getPatternSort((re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?),(.+)", \
			str[8:len(str)-1]).group(3)))
	# \equals(P1, P2) -> getPatternSort(P1)
	elif exp_equals.match(str):
		tmp = str[5:len(str)-1] 
		while 1 :
			if tmp[0:pos].count('(') == tmp[0:pos].count(')'):
				res = getPatternSort(tmp[0:pos])
			else: 
				pos = pos + tmp[pos+1:len(tmp)].index(",") + 1
	# \or(P1, P2) -> getPatternSort(P1)
	elif exp_or.match(str):
		tmp = str[4:len(str)-1] 
		pos = tmp.index(",")
		while 1 :
			if tmp[0:pos].count('(') == tmp[0:pos].count(')'):
				res =  getPatternSort(tmp[0:pos])
				break
			else: 
				pos = pos + tmp[pos+1:len(tmp)].index(",") + 1
	# x::S -> S
	elif exp_meta.match(str):
		res = (re.search("([a-zA-Z]*)::([a-zA-Z]*)",str).group(2))
	# regard as app now. get app's name and get return sort from dict_return 
	elif exp_others.match(str):
		pos_paren = str.index("(")
		key = str[0:pos_paren]
		res = dict_return[key]
	else : res = str
	return res

comment = """def getResSort(str):
	res = ""
	#res += str.replace("*",)
	ls = dict_return.values()
	ls = list(set(ls))
	#print ls
	lens = len(ls) -1
	while lens >= 0 :
		res += str.replace("*",ls[lens]) + "\n"
		lens = lens -1
	return res"""

# main function of lifting.
# input an object-level pattern and return the meta-level one 
def lift(str):
	global FIRST 
	global ERROR
	# x:s -> #variable("x",#sort("s"))
	if exp_variable.match(str) :
		FIRST = False
		return "#variable(\"" + \
    	       (re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?)",str).group(1)) + \
               "\",#sort(\"" + \
               (re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?)",str).group(2)) + \
                "\"))"
	# \and(P1, P2) -> #and(lift(P1), lift(P2))
	elif exp_and.match(str):
		if FIRST :
			tmp = str[5:len(str)-2] 
		else :
			tmp = str[5:len(str)-1] 
		FIRST = False
		pos = tmp.index(",")
		while 1 :
			if tmp[0:pos].count('(') == tmp[0:pos].count(')'):
				# check the sorts of two arguments, if not match then print the problem
				if getPatternSort(tmp[0:pos]) != getPatternSort(tmp[pos+1:len(tmp)]):
					print "not well formed in " + str
				return "#and(" + \
				   	lift(tmp[0:pos]) + \
				   	"," + \
				   	lift(tmp[pos+1:len(tmp)]) + \
				   	")"
			else: 
				pos = pos + tmp[pos+1:len(tmp)].index(",") + 1
	# \not(P) -> #not(lift(P))
	elif exp_not.match(str):
		if FIRST :
			FIRST = False
			return "#not(" + \
			   	lift(str[5:len(str)-2]) + ")"
		else :
			FIRST = False
			return "#not(" + \
			   	lift(str[5:len(str)-1]) + ")"
	# \exists(x:s, P) -> #exists("x",#sort("s"),lift(P))
	elif exp_exists.match(str):
		if FIRST : 
			tmp = str[8:len(str)-2]
		else : 
			tmp = str[8:len(str)-1]
		FIRST = False
		return "#exists(\"" + \
			   (re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?),(.+)",tmp).group(1)) + \
               "\",#sort(\"" + \
               (re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?),(.+)",tmp).group(2)) + \
			   "\")," + \
			   lift((re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?),(.+)",tmp).group(3))) + \
			   ")"
	# \equals(P1,P2) ->
	# forall(s:#sort, #equals(lift(P1),lift(P2),getPatternSort(P1),s:#Sort))
	elif exp_equals.match(str):
		if FIRST : 
			tmp = str[8:len(str)-2]
		else : 
			tmp = str[8:len(str)-1]
		FIRST = False
		pos = tmp.index(",")
		while 1 :
			if tmp[0:pos].count('(') == tmp[0:pos].count(')'):
				if getPatternSort(tmp[0:pos]) != getPatternSort(tmp[pos+1:len(tmp)]):
					print "not well formed in " + str
				if getPatternSort(tmp[0:pos]).count("#") ==0 :
					s1 = "\\forall(s:#Sort," + \
						"#equals(" + \
				   		lift(tmp[0:pos]) + \
				   		"," + \
				   		lift(tmp[pos+1:len(tmp)]) + ",#sort(\"" + \
				   		getPatternSort(tmp[0:pos]) + "\"),s:#Sort))"
				else :
					s1 = "\\forall(s:#Sort," + \
						"#equals(" + \
				   		lift(tmp[0:pos]) + \
				   		"," + \
				   		lift(tmp[pos+1:len(tmp)]) + "," + \
				   		getPatternSort(tmp[0:pos]) + ",s:#Sort))" 
				return s1
			else: 
				pos = pos + tmp[pos+1:len(tmp)].index(",") + 1
	# \or(P1, P2) -> #or(lift(P1), lift(P2))
	elif exp_or.match(str):
		if FIRST :
			tmp = str[4:len(str)-2] 
		else :
			tmp = str[4:len(str)-1] 
		FIRST = False
		pos = tmp.index(",")
		while 1 :
			if tmp[0:pos].count('(') == tmp[0:pos].count(')'):
				if getPatternSort(tmp[0:pos]) != getPatternSort(tmp[pos+1:len(tmp)]):
					print "not well formed in " + str
				return "#or(" + \
				   	lift(tmp[0:pos]) + \
				   	"," + \
				   	lift(tmp[pos+1:len(tmp)]) + \
				   	")"
			else: 
				pos = pos + tmp[pos+1:len(tmp)].index(",") + 1
	# x::S -> 
	# #and(x:#Pattern),\forall(s:#Sort,#equals(#sort("S"),#getSort(#Pattern),#sort("S"),s:#Sort))
	elif exp_meta.match(str):
		x = (re.search("([a-zA-Z]\w*\'?)::([a-zA-Z]\w*\'?)",str).group(1))
		s = (re.search("([a-zA-Z]\w*\'?)::([a-zA-Z]\w*\'?)",str).group(2))
		if s.count("#") == 0 :
			s1 = "#and(" + x + ":#Pattern," + \
					"\\forall(s:#Sort,#equals(#sort(\"" + s + "\")," + \
					"#getSort(#Pattern),#sort(\"" + s + "\"),s:#Sort)))"
		else :
			s1 = "#and(" + x + ":#Pattern," + \
					"\\forall(s:#Sort,#equals(#sort(\"" + s + "\")," + \
					"#getSort(#Pattern)," + s + ",s:#Sort)))"
		return s1
	# app(P1,P2,...) -> 
	# #application(#symbol("app",sortList,returnSort),PatternList)
	elif exp_others.match(str):
		#if str is not application
		if str.count("(") == 0 :
			return "[not pattern]: " + str
		pos_paren = str.index("(")
		# if str is application
		# key is the name of application
		key = str[0:pos_paren]
		# tmp is the temporary pattern list of application
		if FIRST :
			tmp = str[pos_paren+1:len(str)-2]
		else :
			tmp = str[pos_paren+1:len(str)-1]
		FIRST = False
		# liftList is the patternList of arguments of the application
		liftList = ""
		# if there is # in tmp then no need to lift just return 
		if tmp.count("#") > 0 : 
			return "#application(#symbol(\"" + str[0:pos_paren] + \
				   "\"," + dict_arg[key] + "," + \
				    dict_return[key] + ")," + tmp + ")"
		# if there is only one pattern in the pattern list of application
		if tmp.count(",") == 0 :
			# check sort
			if getPatternSort(tmp) != "" and getPatternSort(tmp) not in dict_arg[key] :
				print "sort not match in " + key
			return "#application(#symbol(\"" + str[0:pos_paren] + \
				   "\"," + dict_arg[key] + ",#sort(\"" + \
				    dict_return[key] + "\"))," + lift(tmp) + ")"
		# if there is multiple patterns in the pattern list of application
		else :
			pos_comma = tmp.index(",")
			i = 0 # temporary index
			num_pattern = 0 # number of patterns. Used for check sort
			# arg_ls is the list of arguments' sorts of the app. Used for check sort
			args = dict_arg[key]
			args_ls = args.split(",")
			while pos_comma < len(tmp) - 1 :
				if tmp[i:pos_comma].count('(') == tmp[i:pos_comma].count(')'):
					# check sort
					if getPatternSort(tmp[i:pos_comma]) != "" and getPatternSort(tmp[i:pos_comma]) not in args_ls[num_pattern] :
						print "sort not match in " + key
					num_pattern = num_pattern +1
					# use '.' to concatenate lifted patterns. String manipulation later
					liftList += "." + lift(tmp[i:pos_comma]) 
					i = pos_comma + 1
				if pos_comma + 1 >= len(tmp) :
					break
				if tmp[pos_comma+1:len(tmp)].count(",") == 0 : 
					if getPatternSort(tmp[i:len(tmp)]) != "" and \
					getPatternSort(tmp[i:len(tmp)]) not in args_ls[len(args_ls)-1] :
						print "sort not match in " + key
					liftList += "." + lift(tmp[i:len(tmp)])
					break 
				pos_comma = pos_comma + tmp[i:len(tmp)].index(",") + 1
			# use '#appendPatternList' to replace '.'
			if liftList != nilPs  and liftList.count(".") > 0 :
				count_paren = liftList.count(".") - 1
				liftList = liftList.replace(".", ","+appendPs + "(", count_paren)
				# add ')' to match with '#appendPatternList('
				while count_paren > 0 :
					liftList = liftList + ")"
					count_paren = count_paren -1
				liftList = liftList[1:len(liftList)]
				liftList = liftList.replace(".",",")
			return "#application(#symbol(\"" + str[0:pos_paren] + \
					"\"," + dict_arg[key] + ", #sort(\"" + dict_return[key]+"\"))," + \
					liftList + ")"
	# other junk
 	else :
 		str = str.replace("\n","").replace("\t","")
 		if len(str) == 0 :
 			return nilPs
		else : 
			return "[not pattern]: " + str
# dictionaries
dict_arg = {} # key: app name; value: arguments' sorts
dict_return = {} # key: app name; value: return sort
dict_module = {} #key: module name; value: original syntax and axioms in the module. Used for import

list_meta = [] # list of meta app names
result = "" # final output

file_object = open('input.kore.txt')
file_mid = open('mid.kore.txt','w') # intermediate file. all imports desugared
for line in file_object:
	if line.count("module") > 0 and line.count("endmodule") == 0 :
		name = (re.search("module ([a-zA-Z]\w*)",line).group(1))
		dict_module[name] = ""
		file_mid.write(line)
	elif line.count("import") > 0 :
		import_name = (re.search(" *import ([a-zA-Z]\w*)",line).group(1))
		file_mid.write(dict_module[import_name])
	elif line.count("syntax") > 0 :
		lineList = []
		file_mid.write(line)
		dict_module[name] += line.replace("	","") + "\n\n"
		if line.count("::=") == 0 : continue 
		line = line.replace("syntax ","")
		line = line.replace(" ","")
		line = line.replace("	","")
		line_right = (re.search("(.*)::=(.*)", line).group(2))
		lineList = line_right.split('|')
		num = len(lineList) -1
		# record all the applications' sort info in dict_arg and ict_return
		while num >= 0 :
			group = lineList[num]
			key = (re.search("([a-zA-Z]\w*\'?)(\(?.*\)?)",group).group(1))
			value = (re.search("([a-zA-Z]\w*\'?)(\(?.*\)?)",group).group(2))
			value_return = (re.search("(.*)::=([a-zA-Z]\w*\'?\(?.*\)?)", \
			    	line).group(1))
			dict_return[key] = value_return 
			if value.count("#") > 0 :
				dict_arg[key] = value.replace("(","").replace(")","")
			else :
				value = value.replace("(","\"").replace(")","\"")
				value = value.replace(" ","").replace(",","\",\"").replace(",\"","),#sort(\"")
				value = "#sort(" + value + ")"
				if value == "#sort()" : value = nilSs
				else :
					count_paren = value.count(",")
					value = "," + value
					value = value.replace(",", ","+ appendSs+"(", count_paren)
					while count_paren > 0 :
						value = value + ")"
						count_paren = count_paren -1
					value = value[1:len(value)]
				dict_arg[key] = value
			num = num -1
	elif line.count("axiom") > 0 :
		file_mid.write(line)
		dict_module[name] += line.replace("	","") + "\n\n"
	elif line.count("endmodule") > 0 :
		file_mid.write(line) #dictionary need to be cleared here
file_mid.close()
file_object.close( )

comment = """#easy error matching check
file_object = open('input.kore.txt')
for line in file_object:
	if line.count("::=") == 0 or line.count("|") > 0 or line.count("#") :
		continue
	line = (re.search("(.*)::=(.*)", line).group(2))
	if line.count("(") > 0 :
		pos_paren = line.index("(")
		name = line[0:pos_paren]
		sorts = line[pos_paren+1:len(line)-1]
		#print name + " " + sorts
		sortList = sorts.split(",")
		#print sortList
		lens = len(sortList) - 1
		while lens >=0 :
			if sortList[lens] not in dict_arg[name.replace(" ","")] :
				ERROR = True
				break
			lens = lens -1
file_object.close( )"""

# main lift part
file_object = open('mid.kore.txt')
name = ""
for line in file_object:
	FIRST = True
	if line.count("module") > 0 and line.count("endmodule") == 0 :
		result += line + "\n"
		name = (re.search("module ([a-zA-Z]\w*)",line).group(1))
		dict_module[name] = ""
	elif line.count("endmodule") > 0 :
		result += line + "\n"
	elif line.count("syntax") > 0 and line.count("#") > 0 :
		result += line.replace("	","") + "\n"
		meta_name = (re.search("(.*)::= ?([a-zA-Z]+)\(.*\)", line).group(2))
		list_meta.append(meta_name) # not used for now
		dict_module[name] += line.replace("	","") + "\n\n"
	elif line.count("axiom") > 0 :
		line = line.replace("axiom ","")
		line = line.replace("	","").replace(" ","")
		result += "axiom " + lift(line) +"\n\n"
		dict_module[name] += "axiom " + lift(line) +"\n\n"
file_object.close( )
if ERROR : # not used for now
	print "error detected. No output file available."
else :
	file_object = open('output.kore.txt','w')
	file_object.write(result)
	file_object.close( )
os.remove('mid.kore.txt')

	

