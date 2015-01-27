require "minitest/autorun"
require "pry"

def roman_numeral_converter numeral 
  counting_numbers = { "M" => 1000, "D" => 500, "C" => 100, "L" => 50, "X" => 10, "V" => 5, "I" => 1 }
  better_hash ={ "CM" => 900, "CD" => 400, "XL" => 90, "XC" => 40, "IX" => 9, "IV" => 4}
  reverse_hash = { "CM" => "CCCCCCCCC", "CD" => "CCCC", "XL" => "XXXXXXXXX", "XC" => "XXXX", "IX" => "IIIIIIIII", "IV" => "IIII"}

  if numeral.class == String
    numeral.to_s.upcase!
    if /[^MCDLXVI]/.match(numeral) != nil
      return "Invalid input."
    else
      number = 0
    # numeral = numeral.sub(/CM/, "CCCCCCCCC")
    # numeral = numeral.sub(/CD/, "CCCC")
    # numeral = numeral.sub(/XL/, "XXXXXXXXX")
    # numeral = numeral.sub(/XC/, "XXXX")
    # numeral = numeral.sub(/IX/, "IIIIIIIII")
    # numeral = numeral.sub(/IV/, "IIII")
    #hash = { "CM" => "CCCCCCCCC", "CD" => "CCCC", "XL" => "XXXXXXXXX", "XC" => "XXXX", "IX" => "IIIIIIIII", "IV" => "IIII"}
    # better_hash ={ "CM" => 900, "CD" => 400, "XL" => 90, "XC" => 40, "IX" => 9, "IV" => 4}
      better_hash.each do |key,value| 
        if numeral.include?(key)
          number += value
          numeral.sub!(key, "")
        end 
      end
    # number += roman_array.count("M") * 1000
    # number += roman_array.count("D") * 500
    # number += roman_array.count("C") * 100
    # number += roman_array.count("L") * 50
    # number += roman_array.count("X") * 10
    # number += roman_array.count("V") * 5
    # number += roman_array.count("I") 
    
    # counting_numbers = { "M" => 1000, "D" => 500, "C" => 100, "L" => 50, "X" => 10, "V" => 5, "I" => 1 }
      counting_numbers.each do |letter, value|
        if numeral.include?(letter)
          numeral.split("//")
          number += value * (numeral.count(letter)) 
        end
      end
    end
    elsif
      numeral.class == Fixnum
      number = ""
      counting_numbers.each do |key, value|
        change = numeral / value
        numeral -= (change*value)
        change.times do   
          number << key
        reverse_hash.each do |k, v|
          if number.include?(v)
            number.sub!(v, k)
          end
        end
      end
    end
  else
    return "Invalid input"
  end
  number
end

  class TestRoman < Minitest::Test
    def test_1
      assert_equal roman_numeral_converter("I"), 1
    end

    def test_longer_numeral
      assert_equal roman_numeral_converter("MDXVI"), 1516
    end

    def test_subtractive_case
      assert_equal roman_numeral_converter("XIV"), 14
    end

    def test_complicated_subtractive_number
      assert_equal roman_numeral_converter("CMXCIV"), 944
    end

    def test_lower_case_typo
      assert_equal roman_numeral_converter("dxxx"), 530
    end

    def test_not_a_string
      assert_equal roman_numeral_converter(1001), ("MI")
    end

     def test_reverse_longer_numeral
      assert_equal roman_numeral_converter(1516), ("MDXVI") 
    end

    def test_reverse_subtractive_case
      assert_equal roman_numeral_converter(14), ("XIV")
    end

    def test_invalid_input
      assert_equal roman_numeral_converter("I don't understand roman numerals."),("Invalid input.")
    end
end