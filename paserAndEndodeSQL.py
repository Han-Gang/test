for line in sys.stdin:
  cmd = 'a = '+line.strip() + " +  ';'"
  exec(cmd)
  list1 = a.split(",")
  for ind,i in enumerate(list1):
     if all(ord(c) < 128 for c in i):
         pass
     else:
         list1[ind]="""X'"""+i[2:-1].encode('hex')+"""'"""
  print ",".join(list1)

