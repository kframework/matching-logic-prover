#!/usr/bin/python
import re

p1 = re.compile("[a-zA-Z]\w*\'?:[a-zA-Z]\w*\'?$") #X:S
p2 = re.compile("\A\\\\[a][n][d]\(.+\)$") #phi1 /\ phi2
p3 = re.compile("\A\\\\[n][o][t]\(.+\)$") #not(phi)
p4 = re.compile("\A\\\\[e][x][i][s][t][s]\(.+\)$") #exists x:s,phi
p5 = re.compile("\A\\\\[e][q][u][a][l][s]\(.+\)$") #equals phi1, phi2, sort1, sort2
p6 = re.compile("\A\\\\?[a-zA-Z]+(.+)$") #app(phi1,pih2,...,phin)
FIRST = False
#pattern = str(raw_input("Enter a pattern :"))

nilPs = "#nilPatternList()"
appendPs = "#appendPatternList"
nilSs = "#nilSortList()"
appendSs = "#appendSortList"

def getArgSort(str):
	if p1.match(str) :
		res = (re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?)",str).group(2))
	elif p2.match(str):
		tmp = str[5:len(str)-1] 
		pos = tmp.index(",")
		while 1 :
			if tmp[0:pos].count('(') == tmp[0:pos].count(')'):
				res =  getArgSort(tmp[0:pos])
				break
			else: 
				pos = pos + tmp[pos+1:len(tmp)].index(",") + 1
	elif p3.match(str):
		res = getArgSort(str[5:len(str)-1])
	elif p4.match(str):
		res = getArgSort((re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?),(.+)", \
			str[8:len(str)-1]).group(3)))
	elif p5.match(str):
		tmp = str[5:len(str)-1] 
		while 1 :
			if tmp[0:pos].count('(') == tmp[0:pos].count(')'):
				res = getArgSort(tmp[0:pos])
			else: 
				pos = pos + tmp[pos+1:len(tmp)].index(",") + 1
	elif p6.match(str):
		pos_paren = str.index("(")
		key = str[0:pos_paren]
		res = dict_return[key]
	else : res = str
	#print "res" + res
	return res

def getResSort(str):
	res = ""
	#res += str.replace("*",)
	ls = dict_return.values()
	lens = len(ls) -1
	while lens >= 0 :
		res += str.replace("*",ls[lens]) + "\n"
		lens = lens -1
	return res

def lift(str):
	global FIRST 
	if p1.match(str) :
		FIRST = False
		return "#variable(\"" + \
    	       (re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?)",str).group(1)) + \
               "\",#sort(\"" + \
               (re.search("([a-zA-Z]\w*\'?):([a-zA-Z]\w*\'?)",str).group(2)) + \
                "\"))"
	elif p2.match(str):
		if FIRST :
			tmp = str[5:len(str)-2] 
		else :
			tmp = str[5:len(str)-1] 
		#print FIRST
		FIRST = False
		pos = tmp.index(",")
		while 1 :
			if tmp[0:pos].count('(') == tmp[0:pos].count(')'):
				return "#and(" + \
				   	lift(tmp[0:pos]) + \
				   	"," + \
				   	lift(tmp[pos+1:len(tmp)]) + \
				   	")"
			else: 
				pos = pos + tmp[pos+1:len(tmp)].index(",") + 1
	elif p3.match(str):
		if FIRST :
			FIRST = False
			return "#not(" + \
			   	lift(str[5:len(str)-2]) + ")"
		else :
			FIRST = False
			return "#not(" + \
			   	lift(str[5:len(str)-1]) + ")"
	elif p4.match(str):
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
	elif p5.match(str):
		if FIRST : 
			tmp = str[8:len(str)-2]
		else : 
			tmp = str[8:len(str)-1]
		FIRST = False
		pos = tmp.index(",")
		while 1 :
			if tmp[0:pos].count('(') == tmp[0:pos].count(')'):
				s1 = "#equals(" + \
				   	lift(tmp[0:pos]) + \
				   	"," + \
				   	lift(tmp[pos+1:len(tmp)]) + ",#sort(\"" + \
				   	getArgSort(tmp[0:pos]) + "\"),#sort(\"*\"))"
				return getResSort(s1)
			else: 
				pos = pos + tmp[pos+1:len(tmp)].index(",") + 1
	elif p6.match(str):
		#print str
		if str.count("(") == 0 :
			return "(" + str + ") is not pattern"
		pos_paren = str.index("(")
		key = str[0:pos_paren]
		liftList = ""
		tmp = str[pos_paren+1:len(str)-2]
		liftList = ""
		if tmp.count(",") == 0 :
			#print lift(str[pos_paren+1:len(str)-1])
			return "#application(#symbol(\"" + str[0:pos_paren] + \
				   "\"," + dict_arg[key] + ",#sort(\"" + \
				    dict_return[key] + "\"))," + lift(str[pos_paren+1:len(str)-1]) + ")"
		else :
			pos = tmp.index(",")
			i = 0
			while pos < len(tmp) - 1 :
				if tmp[i:pos].count('(') == tmp[i:pos].count(')'):
					#print liftList
					liftList += "." + lift(tmp[i:pos]) 
					i = pos + 1
				if pos + 1 >= len(tmp) :
					break
				if tmp[pos+1:len(tmp)].count(",") == 0 : 
					liftList += "." + lift(tmp[i:len(tmp)])
					break 
				#print tmp[pos+1:len(tmp)]
				pos = pos + tmp[i:len(tmp)].index(",") + 1
			#print liftList + "-----"
			if liftList != nilPs  and liftList.count(".") > 0 :
				count_paren = liftList.count(".") - 1
				liftList = liftList.replace(".", ","+appendPs + "(", count_paren)
				while count_paren > 0 :
					liftList = liftList + ")"
					count_paren = count_paren -1
				liftList = liftList[1:len(liftList)]
				liftList = liftList.replace(".",",")
			#print liftList
			return "#application(#symbol(\"" + str[0:pos_paren] + \
					"\"," + dict_arg[key] + ", #sort(\"" + dict_return[key]+"\"))," + \
					liftList + ")"
 	else :
 		if len(str) == 0 :
 			return nilPs
		else : 
			return "(" + str + ") is not pattern"
dict_arg = {}
dict_return = {}
dict_return = {}
result = ""
file_object = open('input.txt')
for line in file_object:
	if line.count("syntax") > 0 :
		line = line.replace("syntax ","")
		line = line.replace(" ","")
		line = line.replace("	","")
		#print line
		group = (re.search("(.*)::=([a-zA-Z]\w*\'?\(?.*\)?)", \
			    line).group(2))
		key = (re.search("([a-zA-Z]\w*\'?)\)?(.*)\)?",group).group(1))
		value = (re.search("([a-zA-Z]\w*\'?)\)?(.*)\)?",group).group(2))
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
		value_return = (re.search("(.*)::=([a-zA-Z]\w*\'?\(?.*\)?)", \
			    	line).group(1))
		#print key + " " + value + " " + value_return
		dict_arg[key] = value
		dict_return[key] = value_return 
#print dict_return.values()
file_object = open('input.txt')
for line in file_object:
	FIRST = True
	if line.count("axiom") > 0 :
		line = line.replace("axiom ","")
		line = line.replace(" ","")
		line = line.replace("	","")
		print line
		#print lift(line) 
		result += lift(line) +"\n"
		print "------------"
print result

	

