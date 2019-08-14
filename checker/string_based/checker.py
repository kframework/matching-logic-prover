import re
import pprint

### Encoding of patterns
# We let N denote natural numbers and P,Q denote patterns.
# The parentheses (...) are enforced. 
# element variable             (\ev N)
# set variable                 (\sv N)
# constant symbol              (\cst N)
# application                  (\app P Q)
# bottom                       (\bot)
# implies                      (\imp P Q)
# exists                       (\ex (\ev N) P)
# mu                           (\mu (\sv N) P)

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
    return '(\\imp' + ' ' + p + ' ' + q + ')'
def mk_exists(x, p):
    return '(\\ex' + ' ' + x + ' ' + p + ')'
def mk_app(p, q):
    return '(\\app' + ' ' + p + ' ' + q + ')'
def mk_bottom():
    return '(\\bot)'
def mk_or(p, q):
    return mk_implies(mk_implies(p, mk_bottom()), q)
def mk_mu(svar, p):
    return '(\\mu' + ' ' + svar + ' ' + p + ')'

def parse_proof_annotation(annot):
    # Drop the closing parentheses
    annot_content = annot[1:-1]
    rule_name_search = re.search("[a-zA-Z]*", annot_content)
    rule_name = rule_name_search.group()
    rule_args = annot_content[rule_name_search.end():]
    if rule_name == 'Assumption':
        return [rule_name]
    elif rule_name in ['PropositionFalsum', 'PropagationBottomLeft', 'PropagationBottomRight', 'Exists']:
        (arg1, rest1) = next_block(rule_args)
        return [rule_name, arg1]
    elif rule_name in ['PropositionK', 'MP', 'PreFixpoint']:
        (arg1, rest1) = next_block(rule_args)
        (arg2, resg2) = next_block(rest1)
        return [rule_name, arg1, arg2]
    elif rule_name in ['PropositionS', 'ExistsAxiom', 
            'PropagationOrLeft', 'PropagationOrRight', 'PropagationExistsLeft',
            'PropagationExistsRight', 'SVSubstitution']:
        (arg1, rest1) = next_block(rule_args)
        (arg2, rest2) = next_block(rest1)
        (arg3, rest3) = next_block(rest2)
        return [rule_name, arg1, arg2, arg3]
    elif rule_name in ['ExistsRule', 'FramingLeft', 'FramingRight', 'KT']:
        (arg1, rest1) = next_block(rule_args)
        (arg2, rest2) = next_block(rest1)
        (arg3, rest3) = next_block(rest2)
        (arg4, rest4) = next_block(rest3)
        return [rule_name, arg1, arg2, arg3, arg4]
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


def lookup_before(poid, parsed_po, current_poid):
    for step in parsed_po:
        if step[0] != current_poid and step[0] == poid:
            return step[1]
    raise Exception('Step \"' + poid + '\" doesn\'t exist in checked proof.')

def ca_substitution(pat, r, x):
    # FIXME: variable capturing
    return pat.replace(x, r)

def occur(x, p):
    return p.find(x) != -1

def check(parsed_po):
    def compare(expected, actual):
        if expected != actual:
            print "expected:", expected
            print "actual  :", actual
        return expected == actual
    def check_step(k): 
        [poid,pat,annot] = parsed_po[k]
        rule_name = annot[0]
        if rule_name == 'Assumption':
            return True
        if rule_name == 'PropositionK':
            [arg1,arg2] = annot[1:3]
            return compare(mk_implies(arg1,mk_implies(arg2,arg1)),
                    pat)
        if rule_name == 'PropositionS':
            [arg1,arg2,arg3] = annot[1:4]
            return compare(
                    mk_implies(mk_implies(arg1,mk_implies(arg2,arg3)),
                        mk_implies(mk_implies(arg1,arg2), mk_implies(arg1,arg3))),
                    pat)
        if rule_name == 'PropositionFalsum':
            [arg1] = annot[1:2]
            return compare(
                    mk_implies(mk_implies(mk_implies(arg1, '(\\bot)'), '(\\bot)'), arg1),
                    pat)
        if rule_name == 'MP':
            [arg1,arg2] = annot[1:3]
            pat1 = lookup_before(arg1, parsed_po, poid)
            pat2 = lookup_before(arg2, parsed_po, poid)
            return compare(mk_implies(pat2,pat), pat1)
        if rule_name == 'ExistsAxiom':
            [arg1,arg2,arg3] = annot[1:4]
            subst_pat = ca_substitution(arg2,arg3,arg1)
            return compare(mk_implies(subst_pat, mk_exists(arg1, arg2)),
                    pat)
        if rule_name == 'ExistsRule':
            [arg1,arg2,arg3,arg4] = annot[1:5]
            implication = lookup_before(arg1, parsed_po, poid)
            x = arg2
            phi = arg3
            psi = arg4
            return not occur(x, psi) and compare(mk_implies(phi, psi), implication) and compare(mk_implies(mk_exists(x, phi), psi), pat)
        if rule_name == 'PropagationBottomLeft':
            [arg1] = annot[1:2]
            return compare(mk_implies(mk_app(mk_bottom(), arg1), mk_bottom()),
                    pat)
        if rule_name == 'PropagationBottomRight':
            [arg1] = annot[1:2]
            return compare(mk_implies(mk_app(arg1, mk_bottom()), mk_bottom()),
                    pat)
        if rule_name == 'PropagationOrLeft':
            [arg1,arg2,arg3] = annot[1:4]
            return compare(mk_implies(mk_app(mk_or(arg1, arg2), arg3), mk_or(mk_app(arg1, arg3), mk_app(arg2, arg3))),
                    pat)
        if rule_name == 'PropagationOrRight':
            [arg1,arg2,arg3] = annot[1:4]
            return compare(mk_implies(mk_app(arg3, mk_or(arg1, arg2)), mk_or(mk_app(arg3, arg1), mk_app(arg3, arg2))),
                    pat)
        if rule_name == 'PropagationExistsLeft':
            [x,phi,psi] = annot[1:4]
            return not occur(x, psi) and compare(mk_implies(mk_app(mk_exists(x, phi), psi), mk_exists(x, mk_app(phi,psi))),
                    pat)
        if rule_name == 'PropagationExistsRight':
            [x,phi,psi] = annot[1:4]
            return not occur(x, psi) and compare(mk_implies(mk_app(psi, mk_exists(x, phi)), mk_exists(x, mk_app(psi, phi))),
                    pat)
        if rule_name == 'FramingLeft':
            [poid_premise, phi1, phi2, psi] = annot[1:5]
            premise_pat = mk_implies(phi1, phi2)
            conclusion_pat = mk_implies(mk_app(phi1, psi), mk_app(phi2, psi))
            return compare(premise_pat, lookup_before(poid_premise, parsed_po, poid)) and compare(conclusion_pat, pat)
        if rule_name == 'FramingRight':
            [poid_premise, phi1, phi2, psi] = annot[1:5]
            premise_pat = mk_implies(phi1, phi2)
            conclusion_pat = mk_implies(mk_app(psi, phi1), mk_app(psi, phi2))
            return compare(premise_pat, lookup_before(poid_premise, parsed_po, poid)) and compare(conclusion_pat, pat)
        if rule_name == 'SVSubstitution':
            [poid_premise, svar, psi] = annot[1:4]
            premise_pat = lookup_before(poid_premise, parsed_po, poid)
            return compare(ca_substitution(premise_pat, psi, svar), pat)
        if rule_name == 'PreFixpoint':
            [svar, phi] = annot[1:3]
            return compare(mk_implies(ca_substitution(phi, mk_mu(svar, phi), svar), mk_mu(svar, phi)), pat)
        if rule_name == 'KT':
            [poid_premise, svar, phi, psi] = annot[1:5]
            premise_pat = lookup_before(poid_premise, parsed_po, poid)
            return compare(mk_implies(ca_substitution(phi, psi, svar), psi), premise_pat) and compare(mk_implies(mk_mu(svar, phi), psi), pat)
        if rule_name == 'Exists':
            [x] = annot[1:2]
            return compare(mk_exists(x, x), pat)
        return False
    for k in range(len(parsed_po)):
        if not check_step(k):
            print 'Step', parsed_po[k][0], 'doesn\'t proof check'
            return False
    return True


# f = open('test_1', 'r')
# po_1 = f.read()
# f.close()
# 
# print "parsing PO ..."
# pprint.pprint(parse(po_1))
# print "PO parsed.\n"
# print "checking PO ..."
# check(parse(po_1))
# print "PO checked."

f = open('test_2', 'r')
po_2 = f.read()
f.close()

print "parsing PO ..."
pprint.pprint(parse(po_2))
print "PO parsed.\n"
print "checking PO ..."
check(parse(po_2))
print "PO checked."
