require 'sturdy'

describe Array do
  describe '#first_lines' do
    context 'with an array of strings' do
      before(:each) do
        @arr = ["A string with one line", "A string with two\nlines", "A multi\nline\nstring"]
      end

      it 'does not change the array' do
        @arr_first_lines = @arr.first_lines

        expect(@arr).to eq ["A string with one line", "A string with two\nlines", "A multi\nline\nstring"]
      end

      it 'returns a new array with only first lines' do
        @arr_first_lines = @arr.first_lines

        expect(@arr_first_lines).to eq ["A string with one line", "A string with two", "A multi"]
      end
    end

    context 'with heterogeneous array' do
      before(:each) do
        @arr = [1, "Multi\nline", -3.2, {}, "Line"]
      end

      it 'does not change the array' do
        @arr_first_lines = @arr.first_lines

        expect(@arr).to eq [1, "Multi\nline", -3.2, {}, "Line"]
      end

      it 'does not change non string items' do
        @arr_first_lines = @arr.first_lines

        expect(@arr_first_lines).to eq [1, "Multi", -3.2, {}, "Line"]
      end
    end
  end

  describe '#first_lines!' do
    context 'with an array of strings' do
      before(:each) do
        @arr = ["A string with one line", "A string with two\nlines", "A multi\nline\nstring"]
      end

      it 'returns an array with only first lines' do
        @arr_first_lines = @arr.first_lines!

        expect(@arr_first_lines).to eq ["A string with one line", "A string with two", "A multi"]
      end

      it 'updates the array' do
        @arr.first_lines!

        expect(@arr).to eq ["A string with one line", "A string with two", "A multi"]
      end
    end

    context 'with heterogeneous array' do
      before(:each) do
        @arr = [1, "Multi\nline", -3.2, {}, "Line"]
      end

      it 'does not change non string items' do
        @arr_first_lines = @arr.first_lines!

        expect(@arr_first_lines).to eq [1, "Multi", -3.2, {}, "Line"]
      end

      it 'updates the array' do
        @arr.first_lines!

        expect(@arr).to eq [1, "Multi", -3.2, {}, "Line"]
      end
    end
  end
end
