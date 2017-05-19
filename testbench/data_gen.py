import random

# Open file in write mode
outfile = open('random_data.txt', 'w')

# Write random number for 1024 times
for i in range(1024):
    outfile.write(str(random.randint(-128, 127)) + '\n')
        
outfile.close()