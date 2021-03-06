class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length
    @character_count_without_spaces = @text.split.map(&:length).reduce(:+)
    @word_count = @text.split.size
    @occurrences = @text.split.count(@special_word)
end

def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    pmt = (@principal*@apr/1200)/(1-(1+@apr/1200)**(-12*@years))
    @monthly_payment = pmt.to_s

end

def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = @seconds/60
    @hours = @minutes/60
    @days = @hours/24
    @weeks = @days/7
    @years = @weeks/52
end

def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort
    @count = @numbers.length
    @minimum = @numbers.sort[0]
    @maximum = @numbers.sort[@numbers.length-1]
    @range = @maximum - @minimum

    #median
    median =''.to_f
    num_length = @numbers.length
    num_mid = num_length/2

    if num_mid%2 == 0
        median = (@sorted_numbers[num_mid] + @sorted_numbers[num_mid-1])/2
    else
        median = @sorted_numbers[num_mid+0.5]
    end

    @median = median

    #sum method
    def sum (num_array)
        total = 0
        num_array.each do |i|
            total = total + i
        end
        return total
    end

    @sum = sum(@numbers)

    @mean = @sum/(@numbers.length)

    #variance
    var_array = []
    @numbers.each do |x|
        var_array.push((x-@mean)**2)
    end

    variance = sum(var_array)/var_array.length
    @variance = variance

    @standard_deviation = @variance**0.5

#mode
index = 0
count = 1
count_array = []
count_hash={}

@sorted_numbers.each do |num|
    if index==0
        count_hash[num.to_s] = count
        count_array[index]=count_hash

    elsif index!=0 && @sorted_numbers[index] != @sorted_numbers[index-1]
        count_hash[num.to_s] = count
        count_array[index]=count_hash

    else
        count = count + 1
        count_hash[num.to_s] = count
        count_array[index+1-count]=count_hash
    end

    index = index + 1
    count = 1
    count_hash={}
end
count_array = count_array.compact

# def find_mode(temp_array)
#     temp_array.each do |count_hash|
#     # count_hash.max_by{|k,v| v}
#     count_hash.each { |k, v| puts k if v == hash.values.max }
#     end
# end

@mode = count_array, "I tried but just couldn't figure out how to calculate the mode"



end
end
