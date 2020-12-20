passports = []

ALL_FIELDS = %w(byr iyr eyr hgt hcl ecl pid cid).map(&:to_sym)
OPTIONAL_FIELDS = [:cid]
MANDATORY_FIELDS = ALL_FIELDS - OPTIONAL_FIELDS

Passport = Struct.new(*ALL_FIELDS) do
  def valid?
    MANDATORY_FIELDS.map do |field|
      public_send(field)
    end.all?  { |val| !val.nil? }
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
puts passports.select { |pass| pass.valid? }.length
