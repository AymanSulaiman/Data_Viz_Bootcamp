# Importing the modules needed
import os, csv

# creating the path and reading the file with the OS and CSV 
budget_csv = os.path.join("Resources","budget_data.csv")

# using a with statement to open and analuse the budget file
with open(budget_csv) as budget_file:
    budget_reader = csv.reader(budget_file, delimiter=',')
    print(f"{budget_reader} is the location in the memory")

    budget_header = next(budget_reader)
    print(f"These are the headers. \n {budget_header}")
    
    # Getting the budget data in a list and attaching it into a variable
    budget_data = [row for row in budget_reader]
    print(f"This is the data for the budget in a list. \n {budget_data} \n")


# The code below can be performed out of the 'with' loop
#   * The total number of months included in the dataset

# finding the list of month dates and finding the total number of months
Dates_list = [Month[0] for Month in budget_data]
Months_total = len([Month[0] for Month in budget_data])
print(f"Total Number of Months: {Months_total}. \n")
    
#   * The net total amount of "Profit/Losses" over the entire period
Profits = 0
for p in budget_data:
    column_2 = int(p[1])
    Profits += column_2
print(f"The total profits: ${Profits}. \n")

    #   * The average of the changes in "Profit/Losses" over the entire period

# creating a list for the difference in profit in each month to make life easier
profit_per_month_list = []
for i in budget_data:
    profit_per_month_list.append(i[1])
    
print(f"Print profit per month list \n{profit_per_month_list}\n")

# profit_per_month being converted to integers and I was too lazy to write the full thing for the for function below
ppml_int = [int(k) for k in profit_per_month_list]
# ppml_int stands for profits_per_month_list_integers
# printing out the list to see if they are integers
print(f"The Profit Per Month List:\n{ppml_int}\n")
print(f"The Length of the Profit Per Month List: {len(ppml_int)}\n")

# Monthly profit difference in a for statement
month_profit_difference = [(ppml_int[j + 1] - ppml_int[j]) for j in range(len(ppml_int)-1)]

print(f"List of Monthly difference. \n{month_profit_difference}")


# Need to make a function for average because I think I am not allowed to use numpy
def average(value):
    return round((sum(value))/(len(value)), 2)

# This is the average monthly profit difference is found
average_monthly_profit_difference = average(month_profit_difference)
print(f"The average monthly profit is {average_monthly_profit_difference}\n")


#   * The greatest increase in profits (date and amount) over the entire period
maximum_value = max(month_profit_difference)
maximum_value_position = month_profit_difference.index(max(month_profit_difference))
# Had to add 1 to the position date since the month profit difference was decreased by 1
maximum_value_position_date = Dates_list[maximum_value_position+1]

print(f"The Largest Value is: ${maximum_value}")

print(f"The date of the Largest Value is: {maximum_value_position_date}")

#   * The greatest decrease in losses (date and amount) over the entire period
minimum_value = min(month_profit_difference)
minimum_value_position = month_profit_difference.index(min(month_profit_difference))
# Had to add 1 to the position date since the month profit difference was decreased by 1
minimum_value_position_date = Dates_list[minimum_value_position+1]

print(f"The Minimum Value is: ${minimum_value}")

print(f"The date of the Minimum Value is {minimum_value_position_date}\n")

Summery_Of_Data = f"Finanical Analysis\n\
---------------------------------------------------\n\
Total Months: {Months_total}\n\
Total: ${Profits}\n\
Average Change: ${average_monthly_profit_difference}\n\
Greatest Increase in Profits: {maximum_value_position_date} (${maximum_value})\n\
Greatest Decrease in Profits: {minimum_value_position_date} (${minimum_value})\n\
"
print(Summery_Of_Data)

output_path = os.path.join('PyBank_Analysis.txt')


with open(output_path, 'w', newline='') as datafile:
    
    datafile.write(Summery_Of_Data)

    

# * As an example, your analysis should look similar to the one below:

#   ```text
#   Financial Analysis
#   ----------------------------
#   Total Months: 86
#   Total: $38382578
#   Average  Change: $-2315.12
#   Greatest Increase in Profits: Feb-2012 ($1926159)
#   Greatest Decrease in Profits: Sep-2013 ($-2196167)
#   ```

# * In addition, your final script should both print the analysis to the terminal and export a text file with the results.