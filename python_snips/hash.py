#!/usr/bin/python

dict = {}
dict['one'] = "This is one"
dict[2]     = "This is two"

tinydict = {'name': 'john','code':6734, 'dept': 'sales'}


print dict['one']       # Prints value for 'one' key
print dict[2]           # Prints value for 2 key
print tinydict          # Prints complete dictionary
print "All the keys --> " + str(tinydict.keys())
#print tinydict.keys()   # Prints all the keys
print "All the values --> "  + str(tinydict.values())
#print tinydict.values() # Prints all the values