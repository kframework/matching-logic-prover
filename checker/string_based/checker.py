import re
import pprint

def matching_parentheses(s):
    if not s or s[0] != '(':
        raise Exception('First character is not \'(\':\n', s)
    else:
        c = 1
        i = 0
        while(c > 0 and i + 1 < len(s)):
            if s[i+1] == '(':
                c = c + 1
            elif s[i+1] == ')':
                c = c - 1
            i = i + 1
        if c == 0:
            return i
        else:
            raise Exception('No matching \')\' in:\n', s)

def next_block(s):
    s = s.lstrip() 
    span = matching_parentheses(s)
    return (s[:span+1], s[span+1:])

def mk_implies(p, q):
    return '(\\imp' + p + ' ' + q + ')'

def parse_proof_annotation(annot):
    # Drop the closing parentheses
    annot_content = annot[1:-1]
    rule_name_search = re.search("[a-zA-Z]*", annot_content)
    rule_name = rule_name_search.group()
    rule_args = annot_content[rule_name_search.end():]
    if rule_name == 'Assumption':
        return [rule_name]
    elif rule_name == 'PropositionK':
        (arg1, rest1) = next_block(rule_args)
        (arg2, resg2) = next_block(rest1)
        return [rule_name, arg1, arg2]
    else:
        return [rule_name]

def parse(po):
    proof_steps = map(lambda s: s.strip(), po.split(';'))[:-1]
    def parse_step(step):
        (poid, rest1) = next_block(step)
        (pat, rest2) = next_block(rest1)
        rest2 = rest2.lstrip()
        if len(rest2) < 2 or rest2[0:2] != "by":
            raise Exception('Unexpected proof annotation:', rest2)
        (annot, rest3) = next_block(rest2[2:])
        if rest3.strip():
            raise Exception('Unexpected proof annotation:', rest3)
        return [poid, pat, parse_proof_annotation(annot)]
    return map(parse_step, proof_steps)


def check(parsed_po):
    print 'checking ...'
    def check_step(k): 
        [poid,pat,annot] = parsed_po[k]
        rule_name = annot[0]
        if rule_name == 'Assumption':
            return True
        if rule_name == 'PropositionK':
            [arg1,arg2] = annot[1:3]
            return pat == mk_implies(arg1,mk_implies(arg2,arg1))
        return False 
    for k in range(len(parsed_po)):
        if not check_step(k):
            print 'Step', parsed_po[k][0], 'doesn\'t proof check'
            return False
    print 'proof checked.'
    return True


f = open('test_1', 'r')
po_1 = f.read()
f.close()

pprint.pprint(parse(po_1))
check(parse(po_1))

