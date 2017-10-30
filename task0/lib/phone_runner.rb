class PhoneRunner

  def run(args)

    dictionary = {2 => "A".."C", 3 => "D".."F", 4 => "G".."I", 5 => "J".."L", 6 => "M".."O", 7 => "P".."S", 8 => "T".."V", 9 => "W".."Z" }
    phone_number = ""

    input = args

    if input != []

      letters = input.first.chars

      letters.each do |letter|
        if (1..9).include?(letter.to_i) || letter == "0" || letter == "-"
          phone_number = phone_number + letter
        else
          letter = letter.upcase
          dictionary.values.each do |value|
            if value.include?(letter)
              digit = dictionary.key(value).to_s
              phone_number = phone_number + digit
            end
          end
        end
      end

      phone_number

    else

      "Proper usage: \nphone.rb number"

    end

  end
  
end
