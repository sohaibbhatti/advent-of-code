passports = []

ALL_FIELDS = %w(byr iyr eyr hgt hcl ecl pid cid).map(&:to_sym)
OPTIONAL_FIELDS = [:cid]
MANDATORY_FIELDS = ALL_FIELDS - OPTIONAL_FIELDS

Passport = Struct.new(*ALL_FIELDS) do
  def basic_valid?
    MANDATORY_FIELDS.map do |field|
      public_send(field)
    end.all?  { |val| !val.nil? }
  end

  def advanced_valid?
    basic_valid? && valid_birth_year? && valid_issue_year? && valid_expiry_year? &&
      valid_height? && valid_hair_color? && valid_eye_color? && valid_passport_id?
  end

  def valid_birth_year?
    byr.to_i >= 1920 && byr.to_i <= 2002
  end

  def valid_issue_year?
    iyr.to_i >= 2010 && iyr.to_i <= 2020
  end

  def valid_expiry_year?
    eyr.to_i >= 2020 && eyr.to_i <= 2030
  end

  def valid_height?
    numeric_height = hgt.gsub(/[^0-9]/, '').to_i
    if hgt.end_with?('cm')
      numeric_height >= 150 && numeric_height <= 193
    elsif hgt.end_with?('in')
      numeric_height >= 59 && numeric_height <= 76
    else
      false
    end
  end

  def valid_hair_color?
    hcl.start_with?('#') && hcl.length == 7 && hcl.gsub(/[^0-9a-f]/, '').length == 6
  end

  def valid_eye_color?
    %w(amb blu brn gry grn hzl oth).include? ecl
  end

  def valid_passport_id?
    pid.gsub(/[^0-9]/, '').length == 9
  end
end

passport = Struct.new(:byr, :iyr )

passport = Passport.new
passports << passport
File.foreach("input.txt") do |line|
  if line.chomp == ""
    passport = Passport.new
    passports << passport
    next
  end

  line.chomp.scan(/[a-z]{3}:\S+/).each do |key_value|
    key, value = key_value.split(":")
    if ALL_FIELDS.include?(key.downcase.to_sym)
      passport.public_send("#{key.downcase}=".to_sym, value)
    end
  end
end

puts passports.length
puts passports.select { |pass| pass.basic_valid? }.length
puts passports.select { |pass| pass.advanced_valid? }.length

