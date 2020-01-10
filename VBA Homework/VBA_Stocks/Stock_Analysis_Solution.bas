'This is the homework script to analyse the stock of this worksheet in the VBA language
'THis requires a loop to get the ticker symbol
'Measure the yearly change of the opening price of the beginning of the year and the closing price from the end of the year
'Measure the percent change of the opening price of the beginning of the year and the closing price from the end of the year
'Measure the total volume of the stock
'There needs to be conditional formatting that will highlight the positive change as green and the negative change as red

Sub Analysing_Stock_Per_Year()

    'Since the script is designed to go over each sheet; It is required of this script to make a variable go over each and every sheet

    'Decalring the variable
    Dim Work_Sheet As Worksheet

    'Starting the loop
    For Each Work_Sheet In Worksheets
    
        'For this loop, we need to create the labels for the summery tables for the columns
        'Ticker label
        Work_Sheet.Range("I1") = "Ticker Label"
        'Yearly Change
        Work_Sheet.Range("J1") = "Yearly Change"
        'Percent Change
        Work_Sheet.Range("K1") = "Percent Change"
        'Total Stock Volume
        Work_Sheet.Range("L1") = "Total Stock Volume"
        
        'Creating the Best and worst Performers, my goal is to do the hard stuff
        
        'Greatest Percentage Increase
        Work_Sheet.Range("N2").Value = "Greatest % Increase"
        'Greatest Percentage Decrease
        Work_Sheet.Range("N3").Value = "Greatest % Decrease"
        'Greatest Total Volume
        Work_Sheet.Range("N4").Value = "Greatest Total Volume"
        'Ticker Label
        Work_Sheet.Range("O1").Value = "Ticker"
        'Value Label
        Work_Sheet.Range("P1").Value = "Value"
        
        'Adjusting the lables so it looks presentable
        Work_Sheet.Columns("A:Z").EntireColumn.AutoFit

        'In this same loop we need to declare the variables and set them to zero if they are declared as a numerical value
        
        'Ticker Symbol
        Dim Ticker_Symbol As String
        
        'Total Volume
        Dim Total_Volume As Double
        Total_Volume = 0
        
        'Row count to keep track each ticker symbol in the summery table and it has to be at 2 since the values start at the second row
        Dim Row_Count As Long
        Row_Count = 2
        
        'Year Open
        Dim Year_Open As Double
        Year_Open = 0
        
        'Year Close
        Dim Year_Close As Double
        Year_Close = 0
        
        'Year Change
        Dim Year_Change As Double
        Year_Change = 0
        
        'Percent Change
        Dim Percent_Change As Double
        Percent_Change = 0
        
        'Final row, this needs to be copied and pasted.  Found the code from (https://www.excelcampus.com/vba/find-last-row-column-cell/)
        Dim Final_Row As Long
        Final_Row = Work_Sheet.Cells(Rows.Count, 1).End(xlUp).Row
        
        'What needs to be done next is to loop through the ticker symbols will help to get the desired values to the summery table.
                
        'Starting the loop
        For i = 2 To Final_Row
            
            'This is the If statement to obtain the open price
            If Work_Sheet.Cells(i, 1).Value <> Work_Sheet.Cells(i - 1, 1).Value Then
                                
                Year_Open = Work_Sheet.Cells(i, 3).Value
                        
            End If
            
            'Finding the total Volume for each ticker
            Total_Volume = Total_Volume + Work_Sheet.Cells(i, 7)
            
            'Determining if the ticker symbol is changing and to assign the other stats associated with the symbols via an if else statement
            If Work_Sheet.Cells(i, 1).Value <> Work_Sheet.Cells(i + 1, 1).Value Then
                                
                'The ticker symbol needs to move to the summery table
                Work_Sheet.Cells(Row_Count, 9).Value = Work_Sheet.Cells(i, 1).Value
                
                'The total Stock Volume needs to move to the summery table
                Work_Sheet.Cells(Row_Count, 12).Value = Total_Volume
                
                'Year Change Calculations
                Year_Close = Work_Sheet.Cells(i, 6).Value
                Year_Change = Year_Close - Year_Open
                
                'The year change needs to go to the summery table
                Work_Sheet.Cells(Row_Count, 10).Value = Year_Change
                
                'Making the cell either red or green depending on the value of the "Year_Change"
                If Year_Change >= 0 Then
                    Work_Sheet.Cells(Row_Count, 10).Interior.ColorIndex = 4
                Else
                    Work_Sheet.Cells(Row_Count, 10).Interior.ColorIndex = 3
                End If
                
                
                'Calculating the percentage change and putting it in the summery table
                If Year_Open = 0 And Year_Close = 0 Then
                    'It seems that if the opening and closing of the year is zero the percentage change is zero so just set the ticker at zero.
                    'It would make sense that most stocks will not be in this category though 
                    Percent_Change = 0
                    Work_Sheet.Cells(Row_Count, 11).Value = Percent_Change
                    Work_Sheet.Cells(Row_Count, 11).NumberFormat = "0.00%"
                    
                    
                ElseIf Year_Open = 0 Then
                    'If there is a stock that is ever increasing, it would have an infinite percentage.  It is best to label it as
                    'an ever increasing stock  
                    Dim Ever_Increasing_Percentage As String
                    Ever_Increasing_Percentage = "Ever increasing stock percentage"
                    Work_Sheet.Cells(Row_Count, 11).Value = Percent_Change
                
                    'The Two if else statements above are fail safes, the statement below will find the percent change.
                Else
                    Percent_Change = Year_Change / Year_Open
                    Work_Sheet.Cells(Row_Count, 11).Value = Percent_Change
                    Work_Sheet.Cells(Row_Count, 11).NumberFormat = "0.00%"
                
                End If
                
                'The row count needs to loop in a Row_Count++ fashion
                Row_Count = Row_Count + 1
                
                'The main variables have to be reset or else they will probably have the values of the previous value associated to the ticker number
                Total_Volume = 0
                Year_Open = 0
                Year_Close = 0
                Year_Change = 0
                Percent_Change = 0
                
            End If
            
            'The Easy and the Moderate parts have been done.
            'The easy part was to get the ticker, Yearly Change, Percent change, and the total stock volume
            'The moderate part was to colour the percentage in either Red or Green with respect the the negative and positive percentages
                
        'Ending the loop
        Next i
                
        
        'This is the hard part.
        'This invloves finding the ticker symbols and values that have the greatest % increase, % decrease, and total volume
        
        'Need to set the variables for the best performers as well as the stock with the best performers
        Dim Greatest_Stock As String
        'The Greatest_Value need to be double since all the values have decimals to 2 places
        Dim Greatest_Value As Double
        Greatest_Value = Work_Sheet.Cells(2, 11).Value
                
        'Need to set the variables for the worst performers as well as the stock with the best performers
        Dim Abismal_Stock As String
        'The Lowest_Value need to be double since all the values have decimals to 2 places
        Dim Abismal_Value As Double
        Abismal_Value = Work_Sheet.Cells(2, 11).Value
        
        'Need to set the variables for the Total Stock
        Dim Volume_Stock As String
        'The Total_Stock need to be double since all the values have decimals to 2 places
        Dim Volume_Value As Double
        Volume_Value = Work_Sheet.Cells(2, 12).Value
                
        
        'This would have to be a loop to find
        For hard = 2 To Final_Row
        
            'Searching for the Greatest_Stock <- This is the best stock
            If Work_Sheet.Cells(hard, 11).Value > Greatest_Value Then
                Greatest_Value = Work_Sheet.Cells(hard, 11).Value
                Greatest_Stock = Work_Sheet.Cells(hard, 9).Value
            End If
            
            'Searching for the Abismal_Stock <- This is the worst stock
            If Work_Sheet.Cells(hard, 11).Value < Abismal_Value Then
                Abismal_Value = Work_Sheet.Cells(hard, 11).Value
                Abismal_Stock = Work_Sheet.Cells(hard, 9).Value
            End If
            
            'Searching for the highest Volume_Stock <- This is the stock with the highest volume
            If Work_Sheet.Cells(hard, 12).Value > Volume_Value Then
                Volume_Value = Work_Sheet.Cells(hard, 12).Value
                Volume_Stock = Work_Sheet.Cells(hard, 9).Value
            End If
            
        Next hard
        

        'Assigning the newly found values to the summry table as well as formattting the percentages to get it as only percentages
        Work_Sheet.Range("O2").Value = Greatest_Stock
        Work_Sheet.Range("P2").Value = Greatest_Value
        Work_Sheet.Range("P2").NumberFormat = "0.00%"
        
        Work_Sheet.Range("O3").Value = Abismal_Stock
        Work_Sheet.Range("P3").Value = Abismal_Value
        Work_Sheet.Range("P3").NumberFormat = "0.00%"
        
        Work_Sheet.Range("O4").Value = Volume_Stock
        Work_Sheet.Range("P4").Value = Volume_Value
        
        'Adjusting the lables so it looks presentable
        Work_Sheet.Columns("A:Z").EntireColumn.AutoFit
        
        
Next Work_Sheet

End Sub
