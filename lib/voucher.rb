# Usage:
# 
# n = NewBase.new('VVVVVAAA')
# puts n.value
# n.next
# puts n.value

# n = NewBase.new
# 0.upto(33**8) do |i|
#   puts n.value
#   if n.next == false
#     exit
#   end  
# end

module DVM
  class NewBase
    def initialize(passed_value = nil)
      @sequence = [ 'A', 'F', 'P', '1', 'Z', 'G', 'Q', '9','B', 'H', 'R', '2', 'Y', 'I', 'S', '8', 'C', 'J', 'T', '3', 'X', 'K', 'U', '7', 'D', 'L', '4', 'W', 'M', '6', 'E', 'N', '5', 'V' ] # 34 (0 .. 33)
      
      @pos_map = { "A" => 0, "F" => 1, "P" => 2, "1" => 3, "Z" => 4, "G" => 5, "Q" => 6, "9" => 7,"B" => 8, "H" => 9, "R" => 10, "2" => 11, "Y" => 12, "I" => 13, "S" => 14, "8" => 15, "C" => 16, "J" => 17, "T" => 18, "3" => 19, "X" => 20, "K" => 21, "U" => 22, "7" => 23, "D" => 24, "L" => 25, "4" => 26, "W" => 27, "M" => 28, "6" => 29, "E" => 30, "N" => 31, "5" => 32, "V" => 33 }

      @sequence_length = @sequence.length - 1
      @string_length = 8
      @last_value = 'V' * @string_length
      
      if passed_value && passed_value.length == @string_length
        @current_value = passed_value
      else
        @current_value = 'A' * @string_length
      end
    end
    
    def value
      @current_value
    end
    
    def get_position_by_value(value)
      @pos_map[value]
    end
    
    def get_value_by_position(position)
      @sequence[position]
    end  
    
    def next_value_in_position(position_value)
      if get_position_by_value(position_value) == @sequence_length
        get_value_by_position(0)
      else
        get_value_by_position(get_position_by_value(position_value)+1)
      end
    end

    def next
      if self.value == @last_value
        return false
      end
      
      last_base = @string_length - 1
      
      last_base.downto(0) do |i|
        if get_position_by_value(@current_value[i]) == @sequence_length
          @current_value[i] = get_value_by_position(0)
          next
        else
          @current_value[i] = next_value_in_position(@current_value[i])
          break
        end
      end
    end  
  end
end
