class Array
  # Extract only first lines
  # @return [Array<String>] Array of first lines
  def first_lines!
    map! do |el|
      if el.is_a? String
        el.split("\n").first
      else
        el
      end
    end
  end

  def first_lines
    self.dup.first_lines!
  end
end
