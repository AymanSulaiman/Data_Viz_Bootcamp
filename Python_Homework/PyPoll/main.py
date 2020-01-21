import os, csv

# creating the path and reading the file with the OS and CSV 
election_csv = os.path.join("Resources","election_data.csv")

# with statement to get the header and to convert the file to a list of lists
with open(election_csv) as election_file:
    election_reader = csv.reader(election_file, delimiter=',')
    print(f"{election_reader} is the location in the memory")

    election_header = next(election_reader)
    print(f"These are the headers. \n {election_header}")
    
    # Getting the election data in a list and attaching it into a variable

    # The code below gives the list of  
    # for row in election_reader:
    #     print(row)
    
    election_data = [row for row in election_reader]
    # print(f"This is the data for the election in a list. \n {election_data} \n")
    
   
#   * A complete list of candidates who received votes
# For some reason, writing the code below just works 
election_data_list = [e for e in election_data]
print(election_data_list)

#   * The total number of votes cast
election_number_of_votes = len(election_data)
print(election_number_of_votes)

# A fuction will make the code cleaner and more efficient so I don't have to write the same code over and over again
#   * The total number of votes each candidate won
def number_of_votes(candidate):
    y = 0
    for x in election_data:
        if x[2] == candidate:
            y += 1
    return y

# Applying the 'number_of_votes' def function for each candidate.

election_khan_votes = number_of_votes("Khan")
print(f"Khan Votes: {election_khan_votes}")

election_correy_votes = number_of_votes("Correy")
print(f"Correy Votes: {election_correy_votes}")

election_li_votes = number_of_votes("Li")
print(f"Li Votes: {election_li_votes}")

election_otooley_votes = number_of_votes("O'Tooley")
print(f"O'Tooley Votes: {election_otooley_votes}")

# A fuction will make the code cleaner and more efficient so I don't have to write the same code over and over again
#   * The percentage of votes each candidate won
def candiate_percent(election_person_votes):
    calc = 100*(election_person_votes/election_number_of_votes)
    percentage = round(calc, 3)
    return percentage

# Applying the 'candidate_percentage' def function for each candidate.

election_khan_votes_percent = candiate_percent(election_khan_votes)
print(f"Khan Vote Percentage: {election_khan_votes_percent}")

election_correy_votes_percent = candiate_percent(election_correy_votes)
print(f"Correy Vote Percentage: {election_correy_votes_percent}")

election_li_votes_percent = candiate_percent(election_li_votes)
print(f"Li Vote Percentage: {election_li_votes_percent}")

election_otooley_votes_percent = candiate_percent(election_otooley_votes)
print(f"O'Tooley Vote Percentage: {election_otooley_votes_percent}")


# Made a list of [[Name, Percentage of votes, number of votes], [Name, Percentage of votes, number of votes], [Name, Percentage of votes, number of votes]]
candidates_data = [["Khan", election_khan_votes_percent, election_khan_votes],
                   ["Correy", election_correy_votes_percent, election_correy_votes],
                   ["Li", election_li_votes_percent, election_li_votes],
                   ["O'Tooley", election_otooley_votes_percent, election_otooley_votes]]

print(candidates_data)

#   * The winner of the election based on popular vote.
# This was ditermined from finding the election percenatge data between lines 65 to 75 so I applied the winner to the index of the 'candidates_data' list of list
Winner = candidates_data[0][0]
print(Winner)

# * As an example, your analysis should look similar to the one below:
# Summery of data assigned to the variable 'Summery_Of_Data'
Summery_Of_Data = f"Election Results\n\
-------------------------\n\
Total Votes: {election_number_of_votes}\n\
-------------------------\n\
Khan: {election_khan_votes_percent}% ({election_khan_votes})\n\
Correy: {election_correy_votes_percent}% ({election_correy_votes})\n\
Li: {election_li_votes_percent}% ({election_li_votes})\n\
O'Tooley: {election_otooley_votes_percent}% ({election_otooley_votes})\n\
-------------------------\n\
Winner: {Winner}\n\
-------------------------\n"
print(Summery_Of_Data)

# Output path will be in the root of the PyPoll folder just to make my life easy
output_path = os.path.join('PyPoll_Analysis.txt')

# Below is a with satement that writes the summery of data to the output path PyPoll_Analysis.txt
with open(output_path, 'w', newline='') as datafile:
    
    datafile.write(Summery_Of_Data)
#   ```text
#   Election Results
#   -------------------------
#   Total Votes: 3521001
#   -------------------------
#   Khan: 63.000% (2218231)
#   Correy: 20.000% (704200)
#   Li: 14.000% (492940)
#   O'Tooley: 3.000% (105630)
#   -------------------------
#   Winner: Khan
#   -------------------------
#   ```
