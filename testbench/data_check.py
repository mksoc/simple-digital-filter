# Read file and generate input list
input_list = [int(line.rstrip('\n')) for line in open("random_data.txt")]

# Generate output list
output_list = []

for i in range(len(input_list)):
    result = input_list[i] // 2
    
    if i-1 >= 0:
        result = result - 2*input_list[i-1]
    if i-2 >= 0:
        result = result + input_list[i-2]
    if i-3 >= 0:
        result = result - (input_list[i-3] // 4)        
    if i % 2 != 0:
        result = -result
        
    if result > 127:
        output_list.append(127)
    elif result < -128:
        output_list.append(-128)
    else:
        output_list.append(result)
        
# Compare with hardware output
hw_list = [int(line.rstrip('\n')) for line in open("output_data.txt")]

error = False
for i in range(len(hw_list)):
    if hw_list[i] != output_list[i]:
        print("Errore alla riga {}".format(i))
        error = True
        break
        
if error != True:
    print("Success!")