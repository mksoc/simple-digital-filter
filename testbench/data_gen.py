import random

outfile = open('random_data.txt', 'w')

for i in range(1024):
    outfile.write(str(random.randint(-128, 127)) + '\n')
        
outfile.close()