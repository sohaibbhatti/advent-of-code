operations = []
potential_flips = []
File.open("input.txt").each.with_index do |line, idx|
  current_op = line.chomp.split(" ")
  operation = { op: current_op[0], val: current_op[1].to_i, visited: false }
  operations << operation
  potential_flips << idx if %w(jmp nop).include?(operation[:op])
end

size = operations.length

def run_instructions(operations)
  idx = 0
  total = 0
  should_exit = false
  size = operations.length
  while !should_exit do
    if operations[idx][:visited]
      puts "breaking at #{idx}"
      should_exit = true
      return false
    end
    if idx == size - 1
      puts 'on the last statement woot woot'
      should_exit = true
    end
    operations[idx][:visited] = true
    if operations[idx][:op] == "acc"
      total += operations[idx][:val]
      idx +=1
    elsif operations[idx][:op] == "nop"
      idx +=1
    elsif operations[idx][:op] == "jmp"
      idx += operations[idx][:val]
    end
  end

  total
end

potential_flips.each do |idx|
  cloned_operations = []
  operations.each { |op| cloned_operations << op.clone }
  cloned_operations[idx][:op] = cloned_operations[idx][:op] == "jmp" ? "nop" : "jmp"
  res = run_instructions(cloned_operations)
  if res
    puts res
    break
  end
end
